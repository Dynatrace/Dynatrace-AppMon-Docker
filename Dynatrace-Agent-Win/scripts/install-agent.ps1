Invoke-WebRequest -Uri $env:AGENT_INSTALLER_URL -OutFile "$env:TEMP\$env:AGENT_INSTALLER_NAME"
$process = Start-Process -FilePath msiexec -ArgumentList "/a $env:TEMP\$env:AGENT_INSTALLER_NAME /qn /l* $env:TEMP\dynatrace-agent.log TARGETDIR=$env:DT_HOME" -Wait -PassThru
If ($process.ExitCode -ne 0) {
	$MSIlog = Get-Content "$env:TEMP\dynatrace-agent.log"
	$MSIlog
	throw "MSI install failed"
}
Remove-Item -Path "$env:TEMP\$env:AGENT_INSTALLER_NAME" -Confirm:$False

$serviceinstall = Start-Process -FilePath "$env:DT_HOME\agent\lib\dtwsagent.exe" -ArgumentList "-service install" -Wait -PassThru
If ($serviceinstall.ExitCode -ne 0) { throw "Service install failed" }

Set-Service -ServiceName "Dynatrace Web Server Agent $env:DT_VERSION" -StartupType Manual
Set-Service -ServiceName "W3SVC" -StartupType Manual