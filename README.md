# Aura

Aura is a macOS screen saver with an animated gradient clock. It cycles through 16 color themes, with options to choose a theme or hide the clock.

![Aura screen saver](assets/aura-cover.jpg)

[Watch the 60-second demo](assets/aura-demo.mp4).

## Preview

| Orchid | Aqua | Blue theme |
| --- | --- | --- |
| ![Orchid theme](assets/preview-orchid.jpg) | ![Aqua theme](assets/preview-aqua.jpg) | ![Blue theme](assets/preview-dark-appearance.jpg) |

## Get Aura for free

This repository includes the source code. To install Aura:

1. Download the repository and open `aura.xcodeproj` in Xcode on a Mac.
2. Select the `aura` scheme and build the `aura.saver` product.
3. Double-click the built `aura.saver` and choose **Install for this user only**.
4. Open **System Settings → Screen Saver** and select **Aura**.

The project currently targets macOS 26.2. The build is not notarized, so macOS may show a security warning.

## Downloads

GitHub Releases do not currently include a prebuilt installer. The free download here is the source code; build it with Xcode using the steps above.

## License

Aura source code and original artwork are licensed under the [MIT License](LICENSE). The bundled Outfit and Instrument Serif font files are separately licensed under the SIL Open Font License 1.1; see [font license notices](licenses/FONTS-OFL.txt).

Questions and bug reports are welcome in [GitHub Issues](https://github.com/michelleecalderon/aura-screensaver/issues).
