import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:installed_apps/installed_apps.dart';

@immutable
class InstalledAppImage extends ImageProvider<InstalledAppImageKey> {
  /// Creates an object that fetches the image at the given URL.
  const InstalledAppImage(this.iconId, {this.scale = 1.0});

  final String iconId;
  final double scale;

  @override
  Future<InstalledAppImageKey> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<InstalledAppImageKey>(
      InstalledAppImageKey(
        iconId: iconId,
        scale: scale,
        size: configuration.size,
      ),
    );
  }

  @override
  ImageStreamCompleter loadImage(
    InstalledAppImageKey key,
    ImageDecoderCallback decode,
  ) {
    InformationCollector? collector;
    assert(() {
      collector =
          () => <DiagnosticsNode>[
            DiagnosticsProperty<ImageProvider>('Image provider', this),
            DiagnosticsProperty<InstalledAppImageKey>('Image key', key),
          ];
      return true;
    }());
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode: decode),
      scale: key.scale,
      debugLabel: key.iconId,
      informationCollector: collector,
    );
  }

  /// Converts a key into an [ImageStreamCompleter], and begins fetching the
  /// image.
  @override
  ImageStreamCompleter loadBuffer(
    InstalledAppImageKey key,
    DecoderBufferCallback decode,
  ) {
    InformationCollector? collector;
    assert(() {
      collector =
          () => <DiagnosticsNode>[
            DiagnosticsProperty<ImageProvider>('Image provider', this),
            DiagnosticsProperty<InstalledAppImageKey>('Image key', key),
          ];
      return true;
    }());
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode: decode),
      scale: key.scale,
      debugLabel: key.iconId,
      informationCollector: collector,
    );
  }

  /// Fetches the image from the asset bundle, decodes it, and returns a
  /// corresponding [ImageInfo] object.
  ///
  /// This function is used by [loadImage].
  @protected
  Future<ui.Codec> _loadAsync(
    InstalledAppImageKey key, {
    required Future<ui.Codec> Function(ui.ImmutableBuffer) decode,
  }) async {
    final ui.ImmutableBuffer buffer;
    // Hot reload/restart could change whether an asset bundle or key in a
    // bundle are available, or if it is a network backed bundle.
    try {
      final bytes = await InstalledAppsWithCache().getIcon(
        key.iconId,
        size: key.size,
      );
      if (bytes == null) {
        throw ArgumentError('No icon for iconId: ${key.iconId}');
      }
      buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    } on FlutterError {
      PaintingBinding.instance.imageCache.evict(key);
      rethrow;
    }
    return decode(buffer);
  }
}

class InstalledAppImageKey {
  InstalledAppImageKey({
    required this.iconId,
    required this.scale,
    required this.size,
  });

  final String iconId;
  final double scale;
  final Size? size;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is InstalledAppImageKey &&
        other.iconId == iconId &&
        other.size == size &&
        other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(iconId, scale, size);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'InstalledAppImageKey')}(iconId: $iconId, scale: $scale, size: $size)';
}
