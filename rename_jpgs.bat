@echo off
REM This script renames all .jpg files in the current directory and its subdirectories.
REM It adds an underscore between the prefix (all but the last 2 characters) and the suffix (the last 2 characters) of the filename.

REM Enable delayed variable expansion
setlocal enabledelayedexpansion

REM Set the directory to the current directory
set "directory=."
REM Loop through all .jpg files in the directory and its subdirectories
for /r "%directory%" %%a in (*.jpg) do (
  REM Get the filename without the extension
  set "filename=%%~na"
  REM Check if the filename already contains an underscore
  echo "!filename!" | findstr /c:"_" >nul
  if errorlevel 1 (
    REM Get the file extension
    set "extension=%%~xa"
    REM Extract the prefix of the filename (all but the last 2 characters)
    set "fileprefix=!filename:~0,-2!"
    REM Extract the suffix of the filename (the last 2 characters)
    set "filesuffix=!filename:~-2!"
    REM Create the new filename with an underscore between the prefix and suffix
    set "newname=!fileprefix!_!filesuffix!!extension!"
    REM Display the renaming action
    echo Renaming "%%a" to "!newname!"
    REM Rename the file
    ren "%%a" "!newname!"
  ) else (
    REM Display a message if the filename already contains an underscore
    echo Skipping "%%a" as it already contains an underscore
  )
)
REM End the local environment changes
endlocal
REM Pause the script to keep the command prompt open
pause