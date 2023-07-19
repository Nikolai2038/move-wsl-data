
param(
    # WSL name to move
    [Parameter(Mandatory=$true)]
    [string]${movingWSLName} = "",
    # Full path to new directory to store WSL folder
    [Parameter(Mandatory=$true)]
    [string]${targetWSLDir} = ""
)

if (!(${movingWSLName}) -or !(${targetWSLDir})) {
    Write-Error "Usage: move.ps1 <WSL name to move> <full path to new directory to store WSL folder>"
    Write-Output "Example: move.ps1 `"docker-desktop-data`" `"D:\WSL`""
    Exit 1
}

# Full path to new WSL folder
$wslNewPath = "${targetWSLDir}\${movingWSLName}"

# Full path to directory to store temp archives
$dirToTempStoreArchives = "${targetWSLDir}"

# Full path to WSL's temp arhive
$wslTempArchivePath = "${dirToTempStoreArchives}\${movingWSLName}.tar"

# ========================================
# Moving WSL data
# ========================================
# 1. Stop WSLs
wsl --shutdown
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }

# 2. Save WSL data to archive
wsl --export "${movingWSLName}" "${wslTempArchivePath}"
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }

# 3. Now remove WSL data
wsl --unregister "${movingWSLName}"
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }

# 4. Importing the distribution back to WSL, but now to a new location
wsl --import "${movingWSLName}" "${wslNewPath}" "${wslTempArchivePath}" --version 2
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }

# 5. Remove temp archive
Remove-Item "${wslTempArchivePath}"
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }
# ========================================

Exit 0
