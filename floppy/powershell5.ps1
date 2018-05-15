# Require PowerShell 5.0 or later
if ($PSVersionTable.PSVersion.Major -ge 5) {
	Write-Host "PowerShell 5.0 or later is available. Exiting upgrade"
	exit 0
}

# Require .NET FrameWork 4.5
if (!(Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Version -like '4.5*') {
	choco install dotnet4.5 -y
    exit 0
}

# Require pstools
if (!(Get-Command psexec)) {
    choco install pstools -y
}

# Install PowerShell over psexec
# See https://serverfault.com/questions/559287/what-does-wusa-exe-return-code-5-mean
psexec.exe -accepteula -u vagrant -p vagrant -h -i 1 powershell.exe -command "choco install powershell -y"
exit 0