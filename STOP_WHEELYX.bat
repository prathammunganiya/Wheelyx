@echo off
title Stopping Wheelyx Vehicle Rental Platform...
echo ======================================================================
echo   WHEELYX - Stopping Server
echo ======================================================================
echo.

set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "CATALINA_HOME=C:\Users\HP\Downloads\apache-tomcat-10.1.60-windows-x64\apache-tomcat-10.1.60"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo [1/2] Gracefully shutting down Apache Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat" >nul 2>&1

echo [2/2] Ensuring port 8080 is released...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8080" ^| findstr "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

echo.
echo ======================================================================
echo   Wheelyx server has been stopped.
echo ======================================================================
powershell -NoProfile -Command "Start-Sleep -Seconds 2"
