If (!($env:DT_HOME)) { $env:DT_HOME = "c:\dynatrace" }
If (!($env:DT_AGENT_NAME)) { $env:DT_AGENT_NAME = "dtagent" }
If (!($env:DT_AGENT_LOG_LEVEL)) { $env:DT_AGENT_LOG_LEVEL = "info" }

# Attempt to auto-discover the Dynatrace Collector through the environment when
# the container has been --linked to a 'dynatrace/collector' container instance
# with a link alias 'dtcollector'.
#
# Example: docker run --link dtcollector-1:dtcollector httpd
#
# Auto-discovery can be overridden by providing the $COLLECTOR variable through
# the environment.
If (!($env:DT_COLLECTOR_NAME)) { $env:DT_COLLECTOR_NAME = "dtcollector" }
If (!($env:APPMON_COLLECTOR_PORT)) { $env:APPMON_COLLECTOR_PORT = "9998" }
$COLLECTOR = $env:DT_COLLECTOR_NAME + ":" + $env:APPMON_COLLECTOR_PORT

$WSAGENT_INI = $env:DT_HOME + "\agent\conf\dtwsagent.ini"

$dtwsagent = Get-Content $WSAGENT_INI
$dtwsagent = $dtwsagent -replace "Name dtwsagent","Name $env:DT_AGENT_NAME"
$dtwsagent = $dtwsagent -replace "Server localhost","Server $COLLECTOR"
$dtwsagent = $dtwsagent -replace "Loglevel info","Loglevel $env:DT_AGENT_LOG_LEVEL"
$dtwsagent | Out-File $WSAGENT_INI -Encoding UTF8

New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "name" -Value "$env:DT_AGENT_NAME"
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "server" -Value "$env:DT_COLLECTOR_NAME"
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "port" -Value "$env:APPMON_COLLECTOR_PORT"

Import-Module WebAdministration
Enable-WebGlobalModule -Name "dynaTrace IIS Webserver Agent"
Enable-WebGlobalModule -Name "dynaTrace IIS Webserver Agent (x64)"

Start-Service -Name "Dynatrace Web Server Agent $env:VERSION"