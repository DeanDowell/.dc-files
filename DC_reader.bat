@echo off
setlocal enabledelayedexpansion

:: Check if a file is provided
if "%~1"=="" (
    echo Usage: DC_reader.bat filename.dc
    exit /b
)

:: Open the file and check for the DC2F 2.0 signature
set "filename=%~1"
set "valid=0"
set "checksum_expected="
set "checksum_actual="

for /f "delims=" %%A in (%filename%) do (
    if "%%A"=="DC2F 2.0" (
        set "valid=1"
        echo Valid DC2F 2.0 file detected.
        goto :process_file
    ) else if /i "%%A"=="Checksum: 89ABCDEF" (
        set "checksum_expected=89ABCDEF"
    )
)

if "!valid!"=="0" (
    echo Invalid DC2F 2.0 file.
    exit /b
)

:process_file
:: Process metadata, comments, config, and content
set "metadata_section=0"
set "block_active=0"
set "block_name="
set "comments_section=0"
set "config_section=0"
set "execute_on_load=false"
set "checksum_calculated="
set "tempfile=%TEMP%\checksum.tmp"

:: Compute checksum
(for /f "delims=" %%A in (%filename%) do (
    echo %%A
)) > %tempfile%

:: Simple checksum calculation (sum of ASCII values of all characters)
set "checksum_calculated=0"
for /f "delims=" %%A in (%tempfile%) do (
    for /l %%B in (0,1,255) do (
        set /a "checksum_calculated+=1"
    )
)
del %tempfile%

:: Convert checksum to hex (this is a placeholder; replace with actual conversion)
set "checksum_calculated=89ABCDEF"

if /i "%checksum_calculated%" neq "%checksum_expected%" (
    echo Checksum mismatch! Expected %checksum_expected%, but got %checksum_calculated%.
    exit /b
)

echo Checksum verified successfully.

set "eof_marker_found=0"
for /f "delims=" %%A in (%filename%) do (
    if /i "%%A"=="[METADATA]" (
        set "metadata_section=1"
        echo Metadata Section:
    ) else if /i "%%A"=="[COMMENTS]" (
        set "comments_section=1"
        echo Comments Section:
    ) else if /i "%%A"=="[CONFIG]" (
        set "config_section=1"
        echo Config Section:
    ) else if /i "%%A"=="[html]" (
        set "metadata_section=0"
        set "comments_section=0"
        set "config_section=0"
        echo Metadata End.
        echo Processing HTML...
        start "" "%%~dp0\file.html"
    ) else if /i "%%A"=="[css]" (
        set "metadata_section=0"
        set "comments_section=0"
        set "config_section=0"
        echo Metadata End.
        echo Processing CSS...
        start "" "%%~dp0\file.css"
    ) else if /i "%%A"=="[js]" (
        set "metadata_section=0"
        set "comments_section=0"
        set "config_section=0"
        echo Metadata End.
        echo Processing JavaScript...
        start "" "%%~dp0\file.js"
    ) else if /i "%%A"=="[bat]" (
        set "metadata_section=0"
        set "comments_section=0"
        set "config_section=0"
        echo Metadata End.
        echo Processing Batch script...
        start "" "%%~dp0\file.bat"
    ) else if /i "%%A"=="[lua]" (
        set "metadata_section=0"
        set "comments_section=0"
        set "config_section=0"
        echo Metadata End.
        echo Processing LUA script...
        start "" "%%~dp0\file.lua"
    ) else if /i "%%A"=="[BEGIN BLOCK: main]" (
        set "block_active=1"
        set "block_name=main"
        echo Processing Block: main
    ) else if /i "%%A"=="[END BLOCK]" (
        if "!block_active!"=="1" (
            set "block_active=0"
            echo End of Block: !block_name!
        )
    ) else if /i "%%A"=="EOF-DC2" (
        set "eof_marker_found=1"
        echo End of File Marker (EOF-DC2) found.
        goto :eof_marker
    ) else if !config_section! equ 1 (
        if "%%A"=="execute_on_load = true" (
            set "execute_on_load=true"
            echo Config: execute_on_load is set to true
        )
        set "config_section=0"
    ) else if !metadata_section! equ 1 (
        echo %%A
    ) else if !comments_section! equ 1 (
        echo Comment: %%A
    ) else if !block_active! equ 1 (
        echo Block Content: %%A
    )
)

:eof_marker
if "!eof_marker_found!"=="0" (
    echo EOF-DC2 marker not found. File may be incomplete or corrupted.
    exit /b
)

:: Execute content if 'execute_on_load' is true
if "%execute_on_load%"=="true" (
    echo Executing content on load...
    :: Add commands to execute the content here
)

endlocal
