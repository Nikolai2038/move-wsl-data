# move-wsl-data

## Description

Powershell script to move WSL data to new location.

Script also helps to reduce size of `ext4.vhdx` (WSL's data file), because for some reason `docker system prune` and `docker builder prune` do not reduce it.

## Usage

Clone the repository and then run:

```powershell
./move.ps1 <WSL name to move> <full path to new directory to store WSL folder>
```

Example:

```powershell
./move.ps1 "docker-desktop-data" "D:\WSL"
```

In this example, after execution, WSL data will be moved to `D:\WSL\docker-desktop-data\ext4.vhdx`.

To see list of available WSLs, run:

```powershell
wsl -l -v
```
