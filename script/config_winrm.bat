winrm set winrm/config/winrs @{MaxShellsPerUser="30"}
winrm set winrm/config/winrs @{MaxConcurrentUsers="30"}
winrm set winrm/config/winrs @{MaxProcessesPerShell="30"}
winrm set winrm/config/service @{MaxConcurrentOperationsPerUser="1500"}