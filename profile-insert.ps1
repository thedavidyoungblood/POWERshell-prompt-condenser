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
