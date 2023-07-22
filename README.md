# move-wsl-data

## Description

Powershell script to move WSL data to new location.

Script also helps to reduce size of `ext4.vhdx` (WSL's data file), because for some reason `docker system prune` and `docker builder prune` do not reduce it.

## Requirements

You should have twice as much space on the disk to which you are moving the WSL data than the WSL data itself (or use third argument to change directory for storing temp archive - see below instructions). It is needed for run since the script creates an archive, and then applies it, creating WSL data, and only then deletes it.

## Usage

1. Clone the repository:

    ```powershell
    git clone https://github.com/Nikolai2038/move-wsl-data.git
    cd move-wsl-data
    ```

2. See list of available WSLs and remember name of one you want to move:

    ```powershell
    wsl -l -v
    ```

3. Stop Docker Desktop if you are using it.

4. Run script:

    ```powershell
    ./move.ps1 <WSL name to move> <full path to new directory to store WSL folder> [full path to directory to store temp archive]
    ```

    Example:

    ```powershell
    ./move.ps1 "docker-desktop-data" "D:\WSL"
    ```

    In this example, after execution, WSL data will be moved to `D:\WSL\docker-desktop-data\ext4.vhdx`.

    You can also run script without parameters:

    ```powershell
    ./move.ps1
    ```

    In this case PowerShell will request you to enter them one after another.

    By default, temp archive will be stored in the direcory to store WSL folder. If you want to specify another, pass all three arguments to the script. Example:

    ```powershell
    ./move.ps1 "docker-desktop-data" "D:\WSL" "E:\temp"
    ```
