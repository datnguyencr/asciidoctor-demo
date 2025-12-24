@echo off
setlocal EnableDelayedExpansion

echo Fetching tags...
git fetch --tags

REM === Check if HEAD already has a tag ===
git describe --tags --exact-match HEAD >nul 2>&1
if %errorlevel%==0 (
    echo HEAD already tagged. Skipping tag creation.
    goto COMMIT
)

REM === Get latest semantic version tag ===
for /f %%i in ('git tag --list "v*" --sort=-v:refname') do (
    set LAST_TAG=%%i
    goto FOUND
)

:FOUND
if not defined LAST_TAG (
    echo No existing tag found. Starting at v1.0.0
    set NEW_TAG=v1.0.0
    goto TAG
)

echo Last tag: %LAST_TAG%

REM === Parse version vX.Y.Z ===
for /f "tokens=1-3 delims=." %%a in ("%LAST_TAG:~1%") do (
    set MAJOR=%%a
    set MINOR=%%b
    set PATCH=%%c
)

set /a PATCH+=1
set NEW_TAG=v%MAJOR%.%MINOR%.%PATCH%

:TAG
echo Creating new tag: %NEW_TAG%
git tag %NEW_TAG%

:COMMIT
echo.
echo Adding files...
git add .

echo Committing...
git commit -m "updated"
if errorlevel 1 (
    echo Nothing to commit.
)

echo Pushing main branch...
git push origin main

echo Pushing tag %NEW_TAG%...
git push origin %NEW_TAG%

echo Done.
