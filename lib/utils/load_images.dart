import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:kedasrd_windows/utils/images.dart';

Future<List<void>> preLoadAllImages() async {
  return await Future.wait([
    loadImage(const AssetImage(Images.storeBG)),
    loadImage(const AssetImage(Images.kedasLogoS)),
    loadImage(const AssetImage(Images.kedasLogo)),
    loadImage(const AssetImage(Images.qrCode)),
    loadImage(const AssetImage(Images.placeholder)),
    loadImage(const AssetImage(Images.hamberger)),
    loadImage(const AssetImage(Images.nachitos)),
    loadImage(const AssetImage(Images.pastelitos)),
    loadImage(const AssetImage(Images.bolitas)),
    loadImage(const AssetImage(Images.regular)),
    loadImage(const AssetImage(Images.restaurant)),
    loadImage(const AssetImage(Images.fastFood)),
    loadImage(const AssetImage(Images.superMarket)),
    loadImage(const AssetImage(Images.onlineOrder)),
    loadImage(const AssetImage(Images.newOrder)),
    loadImage(const AssetImage(Images.activeOrder)),
    loadImage(const AssetImage(Images.kitchen)),
    loadImage(const AssetImage(Images.dineIn)),
    loadImage(const AssetImage(Images.delivery)),
    loadImage(const AssetImage(Images.pickUp)),
  ]);
}

Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    debugPrint("Image ${image.debugLabel} finished loading");
    completer.complete();
    stream.removeListener(listener);
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}
