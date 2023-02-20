@setlocal

@echo off

set PatchesFolder="%~dp0Patches"
set QtBaseFolder="%~dp0qtbase"

pushd %QtBaseFolder%
git am %PatchesFolder%\wangwenx190-qtbase-tweaks.patch
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

@endlocal