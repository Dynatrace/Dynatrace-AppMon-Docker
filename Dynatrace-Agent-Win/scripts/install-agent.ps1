Invoke-WebRequest -Uri $env:AGENT_INSTALLER_URL -OutFile "$env:TEMP\$env:AGENT_INSTALLER_NAME"
$process = Start-Process -FilePath msiexec -ArgumentList "/a $env:TEMP\$env:AGENT_INSTALLER_NAME /qn TARGETDIR=$env:DT_HOME" -Wait -PassThru
If ($process.ExitCode -ne 0) { throw "MSI export failed" }
Remove-Item -Path "$env:TEMP\$env:AGENT_INSTALLER_NAME" -Confirm:$False
