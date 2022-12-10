@setlocal

@echo off

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

rem Remove the output folder for a fresh compile.
rd /s /q %ObjectFolder%
rd /s /q %BinaryFolder%

mkdir %BinaryFolder%

set PATH=%~dp0qtbase\bin;%PATH%

set CommonOptions=-G "Ninja Multi-Config" -DCMAKE_CONFIGURATION_TYPES=Release;Debug -DBUILD_SHARED_LIBS=ON -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF

mkdir %ObjectFolder%\qtbase
pushd %ObjectFolder%\qtbase
cmake -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% -DFEATURE_optimize_size=ON -DINPUT_openssl=no -DFEATURE_schannel=ON -DINPUT_opengl=no -DFEATURE_dbus=OFF -DFEATURE_freetype=OFF -DFEATURE_system_freetype=OFF -DFEATURE_harfbuzz=OFF -DFEATURE_system_harfbuzz=OFF -DFEATURE_system_zlib=OFF ../../../../qtbase
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
cmake --build . --parallel
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

mkdir %ObjectFolder%\qtactiveqt
pushd %ObjectFolder%\qtactiveqt
cmake -DCMAKE_PREFIX_PATH=%BinaryFolder% -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% ../../../../qtactiveqt
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
cmake --build . --parallel
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

mkdir %ObjectFolder%\qtsvg
pushd %ObjectFolder%\qtsvg
cmake -DCMAKE_PREFIX_PATH=%BinaryFolder% -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% ../../../../qtsvg
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
cmake --build . --parallel
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

mkdir %ObjectFolder%\qtimageformats
pushd %ObjectFolder%\qtimageformats
cmake -DCMAKE_PREFIX_PATH=%BinaryFolder% -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% ../../../../qtimageformats
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
cmake --build . --parallel
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

mkdir %ObjectFolder%\qttools
pushd %ObjectFolder%\qttools
cmake -DCMAKE_PREFIX_PATH=%BinaryFolder% -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% ../../../../qttools
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
cmake --build . --parallel
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

mkdir %ObjectFolder%\qttranslations
pushd %ObjectFolder%\qttranslations
cmake -DCMAKE_PREFIX_PATH=%BinaryFolder% -DCMAKE_INSTALL_PREFIX=%BinaryFolder% %CommonOptions% ../../../../qttranslations
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
cmake --build . --parallel
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
ninja install
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

@endlocal