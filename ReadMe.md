# Mile.Qt

Customized version of Qt 6.

## Features

- Support Windows 7 with Service Pack 1 (Build 7601) with Yuhang Zhao's patch.
- Use [VC-LTL 5.x](https://github.com/Chuyu-Team/VC-LTL5) toolchain to make the
  binary size smaller.
- Use [YY-Thunks](https://github.com/Chuyu-Team/YY-Thunks) toolchain to achieve
  the Windows Vista RTM (Build 6000) support.

## Usage

Please set the YYTHUNKS_INSTALL_DIR environment variable the to path of
[the latest YY-Thunks binaries](https://github.com/Chuyu-Team/YY-Thunks/releases/latest)
without double quotation mark before compile x86 and x64 targets of Mile.Qt.

After set the environment variable, run onekey-build-*.bat which you want.

## System Requirements

- Supported OS: Windows Vista RTM (Build 6000) or later
- Supported Platforms: x86, x86-64(AMD64) and ARM64.

## Documents

- [License](License.md)

## Credits

Note: This list sort in alphabetical order.

- Kenji Mouri, https://github.com/MouriNaruto
- Yuhang Zhao, https://github.com/wangwenx190
