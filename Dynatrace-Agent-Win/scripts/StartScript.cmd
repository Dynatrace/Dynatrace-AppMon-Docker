@ECHO OFF
IF [%DT_ENABLE_AGENT%] == [True] (
	powershell -File C:\Scripts\run-wsagent.ps1
)
net start w3svc
C:\ServiceMonitor.exe w3svc