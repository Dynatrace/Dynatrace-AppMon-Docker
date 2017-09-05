Import-Module WebAdministration
New-WebGlobalModule -Name "dynaTrace IIS Webserver Agent" -Image "$env:DT_HOME\agent\lib\dtagent.dll" -Precondition "bitness32"
New-WebGlobalModule -Name "dynaTrace IIS Webserver Agent (x64)" -Image "$env:DT_HOME\agent\lib64\dtagent.dll" -Precondition "bitness64"
Disable-WebGlobalModule -Name "dynaTrace IIS Webserver Agent"
Disable-WebGlobalModule -Name "dynaTrace IIS Webserver Agent (x64)"

New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "active" -Value "true"
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "path" -Value "*"
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "exec" -Value "w3wp.exe"