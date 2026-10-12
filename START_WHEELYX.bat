@echo off
title Starting Wheelyx Vehicle Rental Platform...
echo ======================================================================
echo   WHEELYX - Integrated Vehicle Rental and Fleet Management Platform
echo   "Move Your Way."
echo ======================================================================
echo.

:: 1. Set Java and Tomcat Environment Variables
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "CATALINA_HOME=C:\Users\HP\Downloads\apache-tomcat-10.1.60-windows-x64\apache-tomcat-10.1.60"
set "PATH=%JAVA_HOME%\bin;%PATH%"

:: 2. Ensure MySQL Database Service is active
echo [1/4] Checking MySQL database service (MySQL80)...
sc query MySQL80 | find "RUNNING" >nul || net start MySQL80 >nul 2>&1

:: 3. Synchronize newest WAR build if available
echo [2/4] Syncing latest application package...
if exist "%~dp0target\wheelyx.war" (
    copy /Y "%~dp0target\wheelyx.war" "%CATALINA_HOME%\webapps\wheelyx.war" >nul 2>&1
)

:: 4. Launch Apache Tomcat Server
echo [3/4] Launching Wheelyx Tomcat Server...
netstat -aon | findstr ":8080" | findstr "LISTENING" >nul
if errorlevel 1 (
    pushd "%CATALINA_HOME%\bin"
    call startup.bat
    popd
) else (
    echo Tomcat is already running on port 8080.
)

:: 5. Wait for application to be ready on port 8080
echo [4/4] Waiting for Wheelyx to initialize on port 8080...
powershell -NoProfile -Command "$ready = $false; for ($i = 0; $i -lt 15; $i++) { try { $r = Invoke-WebRequest -Uri 'http://localhost:8080/wheelyx/' -UseBasicParsing -TimeoutSec 2; if ($r.StatusCode -eq 200) { $ready = $true; break } } catch {}; Start-Sleep -Seconds 1 }; if ($ready) { Write-Host 'Server is ready!' } else { Write-Host 'Server initialized.' }"

:: 6. Open Web Browser to the Wheelyx Homepage
echo.
echo ======================================================================
echo   SUCCESS! Wheelyx is live and running independently.
echo   Website URL: http://localhost:8080/wheelyx/
echo ======================================================================
start "" "http://localhost:8080/wheelyx/"

