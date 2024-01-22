# Mile.Qt

Customized version of Qt 6.

## Features

- Support Windows Vista RTM (Build 6000) with Yuhang Zhao's patch.
- Use [VC-LTL 5.x](https://github.com/Chuyu-Team/VC-LTL5) toolchain to make the
  binary size smaller.
- Use [YY-Thunks](https://github.com/Chuyu-Team/YY-Thunks) toolchain to achieve
  the Windows Vista RTM (Build 6000) support.
- Use [qtbase patch 507057](https://codereview.qt-project.org/c/qt/qtbase/+/507057)
  for solving Qt Widgets margin issue in Windows.

## Usage

Please set the YYTHUNKS_INSTALL_DIR environment variable the to path of
[the latest YY-Thunks binaries](https://github.com/Chuyu-Team/YY-Thunks/releases/latest)
without double quotation mark before compile x86 and x64 targets of Mile.Qt.

After set the environment variable, run onekey-build-*.bat which you want.

Here is the simple command line example in Command Prompt:

```
set YYTHUNKS_INSTALL_DIR=D:\Tools\YY-Thunks
onekey-build-x64.bat
```

## System Requirements

- Supported OS: Windows Vista RTM (Build 6000) or later
- Supported Platforms: x86, x86-64(AMD64) and ARM64.

## Documents

- [License](License.md)

## Credits

Note: This list sort in alphabetical order.

- Kenji Mouri, https://github.com/MouriNaruto
- Yuhang Zhao, https://github.com/wangwenx190
