import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:installed_apps/src/entities.dart';
import 'package:installed_apps/src/installed_apps_pigeon.g.dart';

class InstalledApps {
  const InstalledApps();

  static InstalledAppsPigeon? _pigeon;
  static InstalledAppsPigeon get _effectivePigeon =>
      _pigeon ??= InstalledAppsPigeon();

  /// Gets platform installed apps.
  ///
  /// Platform-specific docs:
  ///   1. Android. Here we use [InstalledApps].
  Future<List<ApplicationInfo>> getInstalledApplications({
    GetInstalledApplicationsPlatformOptions? options,
  }) async {
    return (await _effectivePigeon.getInstalledApplications(
      options: switch (options) {
        null => null,
        GetInstalledApplicationsAndroidOptions() =>
          GetInstalledApplicationsAndroidOptionsDto(flag: options.flag),
      },
    )).map((e) => e._undto).toList();
  }

  /// Gets icon by an icon id.
  ///
  /// An icon id can be obtained from:
  ///  - [AndroidApplicationInfo.iconId].
  Future<Uint8List?> getIcon(String iconId, {int? quality, Size? size}) {
    return _effectivePigeon.getIcon(
      iconId,
      quality: quality,
      size:
          size != null
              ? IconSize(width: size.width.toInt(), height: size.height.toInt())
              : null,
    );
  }
}

extension on ApplicationInfoDto {
  ApplicationInfo get _undto {
    final self = this;
    return switch (self) {
      AndroidApplicationInfoDto() => AndroidApplicationInfo(
        packageName: self.packageName,
        maybeSystem: self.maybeSystem,
        enabled: self.enabled,
        flags: {
          for (final flag in ApplicationInfoFlag.values)
            if (flag.withIn(self.flags)) flag,
        },
        processName: self.processName,
        uid: self.uid,
        iconId: self.iconId,
        name: self.name,
        label: self.label,
        category:
            self.category == null
                ? null
                : getApplicationCategoryForAndroid(self.category!),
        permissions: [
          for (final perm in self.permissions)
            AndroidManifestPermission.values.byName(perm.name),
        ],
      ),
    };
  }
}
