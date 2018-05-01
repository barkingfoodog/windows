# Require PowerShell 5.0 or later
if ($PSVersionTable.PSVersion.Major -ge 5) {
	Write-Host "PowerShell 5.0 or later is available. Exiting upgrade"
	exit 0
}

# Require .NET FrameWork 4.5
if (!(Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Version -like '4.5*') {
	choco install dotnet4.5 -y
}

# Install PowerShell
choco install powershell -y