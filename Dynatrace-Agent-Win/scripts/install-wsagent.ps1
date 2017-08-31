Import-Module WebAdministration
New-WebGlobalModule -Name IISmoduleX86 -Image "$env:DT_HOME\agent\lib\dtagent.dll" -Precondition "bitness32"
New-WebGlobalModule -Name IISmoduleX64 -Image "$env:DT_HOME\agent\lib64\dtagent.dll" -Precondition "bitness64"
Enable-WebGlobalModule -Name IISmoduleX86 -Precondition "bitness32"
Enable-WebGlobalModule -Name IISmoduleX64 -Precondition "bitness64"

New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "active" -Value "true"
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "path" -Value "*"
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\dynaTrace\Agent\Whitelist\1 -PropertyType String -Name "exec" -Value "w3wp.exe"