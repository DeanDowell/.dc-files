@echo off
title Dean's Console 3

:MENU
cls
echo *** Dean's Console 3 ***
echo.
echo 1. Open .dc file
echo 2. Run .html file
echo 3. Code (Edit a file)
echo 4. Open a URL
echo 5. Exit
echo.
set /p choice=Choose an option (1, 2, 3, 4, or 5):

if "%choice%"=="1" goto OPEN_DC_FILE
if "%choice%"=="2" goto RUN_HTML_FILE
if "%choice%"=="3" goto CODE_FILE
if "%choice%"=="4" goto OPEN_URL
if "%choice%"=="5" exit
goto MENU

:OPEN_DC_FILE
cls
echo Enter the path of the .dc file to open:
set /p dc_filepath=

REM Check if the .dc file exists
if exist "%dc_filepath%" (
    notepad "%dc_filepath%"
) else (
    echo File not found: "%dc_filepath%"
)
pause
goto MENU

:RUN_HTML_FILE
cls
echo Enter the path of the .html file to run:
set /p html_filepath=

REM Check if the .html file exists
if exist "%html_filepath%" (
    start "" "%html_filepath%"
) else (
    echo File not found: "%html_filepath%"
)
pause
goto MENU

:CODE_FILE
cls
echo Enter the path of the file you want to code (edit):
set /p code_filepath=

REM Check if the file exists
if exist "%code_filepath%" (
    notepad "%code_filepath%"
) else (
    echo File not found: "%code_filepath%"
)
pause
goto MENU

:OPEN_URL
cls
echo Enter the URL to open:
set /p url=

REM Open the URL in the default browser
start "" "%url%"
pause
goto MENU
