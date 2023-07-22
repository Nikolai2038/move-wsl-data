param(
    # WSL name to move
    [Parameter(Mandatory = $true)]
    [string]${movingWSLName},

    # Full path to new directory to store WSL folder
    [Parameter(Mandatory = $true)]
    [string]${targetWSLDir},

    # Full path to directory to store temp archives
    [string]${dirToTempStoreArchives}
)

# Default dir if not provided
if([string]::IsNullOrEmpty($dirToTempStoreArchives)) {
    $dirToTempStoreArchives = "${targetWSLDir}"
}

# Full path to new WSL folder
$wslNewPath = "${targetWSLDir}\${movingWSLName}"

# Full path to WSL's temp arhive
$wslTempArchivePath = "${dirToTempStoreArchives}\${movingWSLName}.tar"

Write-Output "Current WSL list:"
wsl -l -v
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }

# ========================================
# Moving WSL data
# ========================================
Write-Output "Shutting down WSL..."
wsl --shutdown
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }
Write-Output "Shutting down WSL: done!"

Write-Output ""
Write-Output "Saving WSL data to archive..."
wsl --export "${movingWSLName}" "${wslTempArchivePath}"
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }
Write-Output "Saving WSL data to archive: done!"

Write-Output ""
Write-Output "Removing WSL data..."
wsl --unregister "${movingWSLName}"
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }
Write-Output "Removing WSL data: done!"

Write-Output ""
Write-Output "Importing the distribution back to WSL, but now to a new location..."
wsl --import "${movingWSLName}" "${wslNewPath}" "${wslTempArchivePath}" --version 2
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }
Write-Output "Importing the distribution back to WSL, but now to a new location: done!"

Write-Output ""
Write-Output "Removing temp archive..."
Remove-Item "${wslTempArchivePath}"
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }
Write-Output "Removing temp archive: done!"
# ========================================

Write-Output ""
Write-Output "New WSL list:"
wsl -l -v
# Exit if was error
if (${LASTEXITCODE} -ne 0) { Exit ${LASTEXITCODE} }

Exit 0
