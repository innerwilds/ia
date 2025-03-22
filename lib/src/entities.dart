import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entities.freezed.dart';

@freezed
sealed class ApplicationInfo with _$ApplicationInfo {
  const factory ApplicationInfo.android({
    required String packageName,
    required bool maybeSystem,
    required bool enabled,
    required Set<ApplicationInfoFlag> flags,
    required String processName,
    required int uid,
    required List<AndroidManifestPermission> permissions,
    String? iconId,
    String? name,
    String? label,
    ApplicationCategory? category,
  }) = AndroidApplicationInfo;
}

enum AndroidManifestPermission {
  accessCheckinProperties,
  accessLocationExtraCommands,
  accessNetworkState,
  accessNotificationPolicy,
  accessWifiState,
  accountManager,
  batteryStats,
  bindAccessibilityService,
  bindAppwidget,
  bindCarrierServices,
  bindConditionProviderService,
  bindDeviceAdmin,
  bindDreamService,
  bindIncallService,
  bindInputMethod,
  bindMidiDeviceService,
  bindNfcService,
  bindNotificationListenerService,
  bindPrintService,
  bindQuickSettingsTile,
  bindRemoteviews,
  bindScreeningService,
  bindTelecomConnectionService,
  bindTextService,
  bindTvInput,
  bindVoiceInteraction,
  bindVpnService,
  bindVrListenerService,
  bindWallpaper,
  bluetooth,
  bluetoothAdmin,
  bluetoothPrivileged,
  broadcastPackageRemoved,
  broadcastSms,
  broadcastSticky,
  broadcastWapPush,
  callPrivileged,
  captureAudioOutput,
  changeComponentEnabledState,
  changeConfiguration,
  changeNetworkState,
  changeWifiMulticastState,
  changeWifiState,
  clearAppCache,
  configureWifiDisplay,
  controlLocationUpdates,
  deleteCacheFiles,
  deletePackages,
  diagnostic,
  disableKeyguard,
  dump,
  expandStatusBar,
  factoryTest,
  getAccountsPrivileged,
  getPackageSize,
  globalSearch,
  installLocationProvider,
  installPackages,
  internet,
  killBackgroundProcesses,
  locationHardware,
  manageDocuments,
  masterClear,
  mediaContentControl,
  modifyAudioSettings,
  modifyPhoneState,
  mountFormatFilesystems,
  mountUnmountFilesystems,
  nfc,
  overrideWifiConfig,
  packageUsageStats,
  readLogs,
  readPrecisePhoneState,
  readSyncSettings,
  readSyncStats,
  reboot,
  receiveBootCompleted,
  reorderTasks,
  requestIgnoreBatteryOptimizations,
  requestInstallPackages,
  sendRespondViaMessage,
  setAlwaysFinish,
  setAnimationScale,
  setDebugApp,
  setProcessLimit,
  setTime,
  setTimeZone,
  setWallpaper,
  setWallpaperHints,
  signalPersistentProcesses,
  statusBar,
  systemAlertWindow,
  transmitIr,
  updateDeviceStats,
  vibrate,
  wakeLock,
  writeApnSettings,
  writeGservices,
  writeSecureSettings,
  writeSettings,
  writeSyncSettings,
}

sealed class GetInstalledApplicationsPlatformOptions {}

class GetInstalledApplicationsAndroidOptions
    implements GetInstalledApplicationsPlatformOptions {
  const GetInstalledApplicationsAndroidOptions({this.flags = const {}});

  final Set<ApplicationInfoFlag> flags;

  @internal
  int get flag => flags.fold<int>(0, (acc, f) => f._value | acc);

  @override
  bool operator ==(Object other) {
    return other is GetInstalledApplicationsAndroidOptions && other.flag != flag;
  }
}

/// Android-only.
enum ApplicationInfoFlag {
  @Deprecated(
    'This constant was deprecated in API level 31. The platform does not '
    'support getting IntentFilters for the package. ',
  )
  getIntentFilters(0x00000020),
  @Deprecated(
    'This constant was deprecated in API level 28. Use GET_SIGNING_CERTIFICATES'
    ' instead ',
  )
  getSignatures(0x00000040),

  getActivities(0x00000001),
  getAttributions(0x0000000080000000),
  getConfigurations(0x00004000),
  getGids(0x00000100),
  getInstrumentation(0x00000010),
  getMetaData(0x00000080),
  getPermissions(0x00001000),
  getProviders(0x00000008),
  getReceivers(0x00000002),
  getServices(0x00000004),
  getSharedLibraryFiles(0x00000400),
  getSigningCertificates(0x08000000),
  getUriPermissionPatterns(0x00000800),
  all(0x00020000),
  apex(0x40000000),
  archivedPackages(0x0000000100000000),
  defaultOnly(0x00010000),
  directBootAuto(0x10000000),
  directBootAware(0x00080000),
  directBootUnaware(0x00040000),
  disabledComponents(0x00000200),
  disabledUntilUsedComponents(0x00008000),
  systemOnly(0x00100000),
  uninstalledPackages(0x00002000);

  const ApplicationInfoFlag(this._value);

  final int _value;

  @internal
  bool withIn(int flags) => (flags & _value) != 0;
}

enum ApplicationCategory {
  accessibility,
  audio,
  game,
  image,
  maps,
  news,
  productivity,
  social,
  undefined,
  video;

  const ApplicationCategory();
}

@internal
ApplicationCategory getApplicationCategoryForAndroid(int value) =>
    switch (value) {
      8 => ApplicationCategory.accessibility,
      1 => ApplicationCategory.audio,
      0 => ApplicationCategory.game,
      3 => ApplicationCategory.image,
      6 => ApplicationCategory.maps,
      5 => ApplicationCategory.news,
      7 => ApplicationCategory.productivity,
      4 => ApplicationCategory.social,
      -1 => ApplicationCategory.undefined,
      2 => ApplicationCategory.video,
      _ => ApplicationCategory.undefined,
    };
