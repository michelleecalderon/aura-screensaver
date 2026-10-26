# Aura

Aura is a macOS screen saver with an animated gradient clock. It cycles through 16 color themes, with options to choose a theme or hide the clock.

![Aura screen saver](assets/aura-cover.jpg)

[Watch the 60-second demo](assets/aura-demo.mp4).

## Preview

| Orchid | Aqua | Dark appearance |
| --- | --- | --- |
| ![Orchid theme](assets/preview-orchid.jpg) | ![Aqua theme](assets/preview-aqua.jpg) | ![Blue theme](assets/preview-dark-appearance.jpg) |

## Install the Gumroad download

1. Download and unzip **Aura Screensaver** from Gumroad.
2. Double-click `aura.saver` and choose **Install for this user only**.
3. Open **System Settings → Screen Saver** and select **Aura**.

The Gumroad build requires macOS 13 or later and runs on Apple Silicon Macs. It is not notarized, so macOS may show a security warning. Install it only if you trust the download.

## Build from source

1. Open `aura.xcodeproj` in Xcode on a Mac.
2. Select the `aura` scheme and build the `aura.saver` product.
3. In Xcode, choose **Product → Show Build Folder in Finder** and locate `aura.saver` under `Products/Debug`.
4. Double-click the built `aura.saver` to install it, then select **Aura** in **System Settings → Screen Saver**.

The project’s current Xcode build setting targets macOS 26.2. The shared project has no developer-team setting; select your own signing team in Xcode if you want to sign your build.

## GitHub downloads

GitHub Releases do not currently include a prebuilt installer. The Gumroad download is distributed separately.

## License

Aura source code and original artwork are licensed under the [MIT License](LICENSE). The bundled Outfit and Instrument Serif font files are separately licensed under the SIL Open Font License 1.1; see [font license notices](licenses/FONTS-OFL.txt).

Questions and bug reports are welcome in [GitHub Issues](https://github.com/michelleecalderon/aura-screensaver/issues).
