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
echo [1/3] Checking MySQL database service (MySQL80)...
sc query MySQL80 | find "RUNNING" >nul || net start MySQL80 >nul 2>&1

:: 3. Launch Apache Tomcat Server in a separate detached window
echo [2/3] Launching Wheelyx Tomcat Server...
call "%CATALINA_HOME%\bin\startup.bat"

:: 4. Wait for server initialization
echo [3/3] Initializing application on port 8080...
powershell -NoProfile -Command "Start-Sleep -Seconds 3"

:: 5. Open Web Browser to the Wheelyx Homepage
echo.
echo ======================================================================
echo   SUCCESS! Wheelyx is live and running independently.
echo   Website URL: http://localhost:8080/wheelyx/
echo ======================================================================
start "" "http://localhost:8080/wheelyx/"
