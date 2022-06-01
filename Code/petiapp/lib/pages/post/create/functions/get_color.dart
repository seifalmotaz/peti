import 'package:flutter/cupertino.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color> getColor(ImageProvider<Object> imageProvider) async {
  PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
    imageProvider,
    timeout: const Duration(seconds: 10),
  );
  if (paletteGenerator.darkMutedColor != null) {
    return paletteGenerator.darkMutedColor!.color;
  }
  if (paletteGenerator.darkVibrantColor != null) {
    return paletteGenerator.darkVibrantColor!.color;
  }
  if (paletteGenerator.dominantColor != null) {
    return paletteGenerator.dominantColor!.color;
  }
  if (paletteGenerator.lightMutedColor != null) {
    return paletteGenerator.lightMutedColor!.color;
  } else {
    return paletteGenerator.lightVibrantColor!.color;
  }
}
