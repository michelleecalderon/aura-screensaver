# Aura

Aura is a macOS screen saver with an animated gradient clock. It cycles through 16 color themes, with options to choose a theme or hide the clock.

![Aura screen saver](assets/aura-cover.jpg)

[Watch the 60-second demo](assets/aura-demo.mp4).

## Preview

| Orchid | Aqua | Dark appearance |
| --- | --- | --- |
| ![Orchid theme](assets/preview-orchid.jpg) | ![Aqua theme](assets/preview-aqua.jpg) | ![Blue theme](assets/preview-dark-appearance.jpg) |

## Build and install from source

1. Open `aura.xcodeproj` in Xcode on a Mac.
2. Select the `aura` scheme and build the `aura.saver` product.
3. In Xcode, use **Product → Show Build Folder in Finder** and locate `aura.saver` under `Products/Debug`.
4. Copy `aura.saver` to `~/Library/Screen Savers/`.
5. Open **System Settings → Screen Saver** and select Aura.

The project’s current Xcode build setting targets macOS 26.2. The shared project has no developer-team setting; select your own signing team in Xcode if you want to sign your build.

## Downloads

A ready-to-install download is not available yet. The existing local build is Apple Silicon only and failed macOS signature trust assessment, so it is not attached as a public release. A future GitHub Release should include a signed and notarized `.saver` archive and list its supported Mac architectures and macOS versions. For now, use the source build instructions above.

## License

Aura source code and original artwork are licensed under the [MIT License](LICENSE). The bundled Outfit and Instrument Serif font files are separately licensed under the SIL Open Font License 1.1; see [font license notices](licenses/FONTS-OFL.txt).

Questions and bug reports are welcome in [GitHub Issues](https://github.com/michelleecalderon/aura-screensaver/issues).
