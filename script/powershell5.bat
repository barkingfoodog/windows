:: Install chocolatey if missing
choco.exe --version
IF %ERRORLEVEL% NEQ 0 (
	@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
	@if errorlevel 1 echo ==^> WARNING: Error %ERRORLEVEL% was returned installing chocolatey
)

:: Install powershell5
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -File "A:\powershell5.ps1"
exit 0