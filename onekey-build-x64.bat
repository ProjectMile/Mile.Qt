@setlocal

@echo off

rem Remove the output folder for a fresh compile.
rd /s /q "%~dp0Output"

set VisualStudioInstallerFolder="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer"
if %PROCESSOR_ARCHITECTURE%==x86 set VisualStudioInstallerFolder="%ProgramFiles%\Microsoft Visual Studio\Installer"

pushd %VisualStudioInstallerFolder%
for /f "usebackq tokens=*" %%i in (`vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
  set VisualStudioInstallDir=%%i
)
popd

call "%VisualStudioInstallDir%\VC\Auxiliary\Build\vcvarsall.bat" amd64

set ObjectFolder="%~dp0Output\Objects\x64"
set BinaryFolder="%~dp0Output\Binaries\x64"
mkdir %BinaryFolder%

set PATH=%~dp0qtbase\bin;%PATH%

set CommonOptions=-DBUILD_SHARED_LIBS=ON -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF

mkdir %ObjectFolder%\qtbase
pushd %ObjectFolder%\qtbase
cmake -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% -G "Ninja Multi-Config" -DCMAKE_CONFIGURATION_TYPES=Release;Debug -DFEATURE_optimize_size=ON -DINPUT_openssl=no -DFEATURE_schannel=ON -DINPUT_opengl=no -DFEATURE_dbus=OFF -DFEATURE_freetype=OFF -DFEATURE_system_freetype=OFF -DFEATURE_harfbuzz=OFF -DFEATURE_system_harfbuzz=OFF -DFEATURE_system_zlib=OFF ../../../../qtbase
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

@endlocal