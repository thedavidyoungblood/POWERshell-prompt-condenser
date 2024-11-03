§ - "meRead" - as a 'mini-Readme,' in the script itself - §

# Header Metadata
**Script Name**: PowerShell Prompt Customization for Git Repository Root  
**Author**: David Youngblood @ LouminAI Labs § louminai.com  
**Creation Date**: 2024-11-03  
**Last Modified Date**: 2024-11-03  
**Version**: 1.0.0  
**Dependencies**:
- PowerShell 5.1 or higher
- Git

**Description**: This script customizes the PowerShell prompt to dynamically display the drive and the root of the current Git repository in the VS Code integrated terminal. If the user is not in a Git repository, it defaults to showing the drive and the top-level folder. This setup allows for a concise, contextually relevant prompt.

**Usage**:

1. **Open Your PowerShell Profile**:
   Open the PowerShell profile where the prompt customization will be set:
   ```powershell
   notepad $PROFILE
   ```

2. **Add the Custom `prompt` Function**:
   Copy and paste the provided `prompt` function into your PowerShell profile to enable the customized prompt:
   
   ```powershell
   function prompt {
       $path = (Get-Location).Path
       $drive = Split-Path -Path $path -Qualifier  # Get the drive (e.g., C:\)

       # Try to get the Git repository root
       $gitRoot = (git rev-parse --show-toplevel 2>$null)
       
       if ($gitRoot) {
           # If we're in a Git repo, use the repo root
           $repoRoot = Split-Path -Path $gitRoot -Leaf  # Get the name of the repo root folder
           $current = Split-Path -Path $path -Leaf       # Get the current directory
           
           if ($current -eq $repoRoot) {
               "$drive$repoRoot> "  # Show only drive + repo root
           } else {
               "$drive$repoRoot\$current> "  # Show drive + repo root + current if not at root
           }
       } else {
           # If not in a Git repo, fall back to showing drive + top-level folder
           $root = (Split-Path -Path $path -NoQualifier -Parent)
           $current = Split-Path -Path $path -Leaf

           if ($current -eq $root) {
               "$drive$root> "
           } else {
               "$drive$root\$current> "
           }
       }
   }
   ```

4. **Reload the Profile**:
   After saving the profile, reload it to apply the changes immediately:
   ```powershell
   . $PROFILE
   ```

**Contact Information**:  
Email: opensource@louminai.com  
Website: [louminai.com](http://louminai.com)  
GitHub: [https://github.com/LouminAILabs/POWERshell-prompt-condenser](https://github.com/LouminAILabs/POWERshell-prompt-condenser)  
License: MIT

---

# Script Overview and Purpose

This PowerShell customization script dynamically adjusts the prompt to display the **drive + repository root (+ current directory if not at the root)** when inside a Git repository. Outside of a Git repository, it defaults to displaying the drive and the top-level folder. This setup aims to keep the prompt concise and informative, especially in complex directory structures.

## Linkages and Backlinks

- **Related Scripts**: [PowerShell Profile Setup Guide](./powershell_profile_setup.md)
- **Next Steps**: [Advanced Prompt Customization](./advanced_prompt_customization.md)
- **References**: [Git Command Documentation](https://git-scm.com/docs)
- **Relationships**: Integrates with Git and PowerShell environments.

## Integration Pointers

- **Interacts with**: Git for detecting the repository root.
- **Outputs**: Modifies the PowerShell prompt display.
- **Data Format**: Output is the customized prompt string displayed in the terminal.

## Prerequisites and Dependencies

- **PowerShell Version**: Requires PowerShell 5.1 or higher.
- **Dependencies**: Git must be installed and accessible in the PowerShell environment.

## Versioning Details

- **Script Version**: 1.0.0
- **Last Updated**: 2024-11-03
- **Change Log**:
  - **v1.0.0**: Initial release with dynamic prompt customization based on Git repository root detection.

## Additional Elements

- **Configuration**:
  - Ensure Git is installed and accessible in the PowerShell environment to detect the repository root.

- **Adaptive Behavior**:
  - **Dynamic Prompt Adjustment**: Automatically switches to showing repository root if within a Git repository.
  - **Fallback Display**: Defaults to drive and top-level folder if not in a Git repository.

## Example Usage in Production

```powershell
# Open PowerShell and navigate to a Git repository
cd /path/to/repository

# The prompt should now display as "Drive:\RepoRoot\" if at the root
# or "Drive:\RepoRoot\CurrentFolder" if in a subdirectory

# Outside of a Git repo
cd /path/to/non-git-folder
# The prompt will display as "Drive:\TopLevelFolder\CurrentFolder" (or just TopLevelFolder if at the root)
```
