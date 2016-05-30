# Install chocolatey
Write-Host "Installing chocolatey"
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Install salt
Write-Host "Installing salt"
choco install saltminion -r -y

# Install chef-client
Write-Host "Installing chef-client"
choco install chef-client -r -y 

# Install busser and serverspec
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine")

$env:BUSSER_ROOT = "$env:TEMP\verifier"
$env:GEM_HOME = "$env:TEMP\verifier\gems"
$env:GEM_PATH = "$env:TEMP\verifier\gems"
$env:GEM_CACHE = "$env:TEMP\verifier\gems\cache"
$ruby = "$env:systemdrive\opscode\chef\embedded\bin\ruby.exe"
$gem = "$env:systemdrive\opscode\chef\embedded\bin\gem"
$version = "busser"
$gem_install_args = "busser --no-rdoc --no-ri --no-format-executable -n $env:TEMP\verifier\bin --no-user-install"
$busser = "$env:TEMP\verifier\bin\busser.bat"
$plugins = "busser-serverspec"

if ((& "$ruby" "$gem" list busser -i) -ne "true") {
  Write-Host "-----> Installing Busser ($version)`n"
  & "$ruby" "$gem" install $gem_install_args.Split() 2>&1
} else {
  Write-Host "-----> Busser installation detected ($version)`n"
}

if (-Not (Test-Path "$busser")) {
  $gem_bindir = & "$ruby" -rrubygems -e "puts Gem.bindir.dup.gsub('/', '\\')"
  & "$ruby" "$gem_bindir\busser" setup --type bat 2>&1
}

Write-Host "       Installing Busser plugins: $plugins`n"
& "$busser" plugin install $plugins.Split() 2>&1