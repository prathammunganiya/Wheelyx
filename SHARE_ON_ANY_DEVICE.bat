@echo off
title Wheelyx - Share On Any Device (Public Tunnel)
echo ======================================================================
echo   WHEELYX - PUBLIC ACCESS TUNNEL
echo   Generate a secure link to access Wheelyx from ANY phone or device!
echo ======================================================================
echo.

:: 1. Ensure Tomcat is running
echo [1/2] Checking if Wheelyx is running on port 8080...
netstat -aon | findstr ":8080" | findstr "LISTENING" >nul
if errorlevel 1 (
    echo.
    echo Wheelyx is not currently running!
    echo Starting Wheelyx first...
    call "%~dp0START_WHEELYX.bat"
    timeout /t 3 >nul
)

:: 2. Launch Cloudflare Tunnel
echo [2/2] Creating instant secure public link...
echo.
echo ======================================================================
echo   Look for the URL ending with '.trycloudflare.com' below!
echo   Example: https://xxxx-xxxx.trycloudflare.com/wheelyx/
echo.
echo   Open that URL on ANY phone, tablet, or PC anywhere in the world!
echo   (Keep this window open while using the website on other devices)
echo ======================================================================
echo.

"%~dp0cloudflared.exe" tunnel --url http://localhost:8080
