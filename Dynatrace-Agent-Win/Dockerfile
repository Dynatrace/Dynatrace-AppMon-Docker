#DOCKERFILE FOR DYNATRACE AGENT ON WINDOWS
FROM microsoft/iis

ARG DT_HOME
ARG DT_BUILD_VERSION
ARG DT_VERSION

ENV AGENT_INSTALLER_NAME=dynatrace-agent-${BUILD_VERSION}-x86.msi
ENV AGENT_INSTALLER_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${AGENT_INSTALLER_NAME}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]
COPY ["./Scripts","/Scripts"]
RUN	C:\Scripts\install-agent.ps1
RUN	C:\Scripts\install-wsagent.ps1

ENTRYPOINT ["C:\\Scripts\\StartScript.cmd"]
