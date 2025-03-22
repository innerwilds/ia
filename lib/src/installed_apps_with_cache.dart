import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:installed_apps/src/entities.dart';
import 'package:installed_apps/src/installed_apps.dart';

/// [InstalledApps] with cache.
///
/// Because there is two methods, this cache is simple, so there is no dart-side
/// filtration of cached apps by some options.
class InstalledAppsWithCache implements InstalledApps {
  InstalledAppsWithCache();

  static const _pm = InstalledApps();

  GetInstalledApplicationsPlatformOptions?
  _getInstalledApplicationsLastUsedOptions;
  List<ApplicationInfo> _cachedApps = [];
  Map<String, Uint8List> _cachedIcons = {};

  @override
  Future<List<ApplicationInfo>> getInstalledApplications({
    GetInstalledApplicationsPlatformOptions? options,
  }) async {
    if (_cachedApps.isEmpty ||
        options != _getInstalledApplicationsLastUsedOptions) {
      _cachedApps = await _pm.getInstalledApplications(options: options);
    }
    _getInstalledApplicationsLastUsedOptions = options;
    return _cachedApps;
  }

  /// Will cache first [quality] and [size], so future calls with different
  /// parameters will doesn't affect.
  ///
  /// The [quality] parameter affects image only when working >= API 30 on
  /// Android. Underlying plugin will use WEBP_LOSSY when >= API 30, otherwise
  /// PNG.
  ///
  /// You can evict [iconId] using [evictIcon].
  @override
  Future<Uint8List?> getIcon(String iconId, {int? quality, Size? size}) async {
    var cache = _cachedIcons[iconId];

    if (cache == null) {
      cache = await _pm.getIcon(iconId, quality: quality, size: size);
      if (cache != null) {
        _cachedIcons[iconId] = cache;
      }
    }

    return cache;
  }

  void evictIcon(String iconId) {
    _cachedIcons.remove(iconId);
  }

  /// Clears all cache.
  void clearCache() {
    _cachedApps.clear();
    _cachedIcons.clear();
  }
}
