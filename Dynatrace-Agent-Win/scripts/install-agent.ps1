Invoke-WebRequest -Uri $env:AGENT_INSTALLER_URL -OutFile "$env:TEMP\$env:AGENT_INSTALLER_NAME"
$process = Start-Process -FilePath msiexec -ArgumentList "/a $env:TEMP\$env:AGENT_INSTALLER_NAME /qn TARGETDIR=$env:DT_HOME" -Wait -PassThru
If ($process.ExitCode -ne 0) { throw "MSI export failed" }
Remove-Item -Path "$env:TEMP\$env:AGENT_INSTALLER_NAME" -Confirm:$False

$serviceinstall = Start-Process -FilePath "$env:DT_HOME\agent\lib\dtwsagent.exe" -ArgumentList "-service install" -Wait -PassThru
If ($serviceinstall.ExitCode -ne 0) { throw "Service install failed" }

Set-Service -ServiceName "Dynatrace Web Server Agent $env:VERSION" -StartupType Manual
Set-Service -ServiceName "W3SVC" -StartupType Manual