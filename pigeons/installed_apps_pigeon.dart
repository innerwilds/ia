import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    input: 'pigeons/messages.dart',
    kotlinOut:
        'android/src/main/kotlin/ru/innerwilds/flutter/plugins/installed_apps/InstalledAppsPigeon.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'ru.innerwilds.flutter.plugins.installed_apps',
      errorClassName: 'InstalledAppsPigeonError',
    ),
    dartOut: 'lib/src/installed_apps_pigeon.g.dart',
  ),
)
@HostApi()
abstract class InstalledAppsPigeon {
  @async
  @TaskQueue(type: TaskQueueType.serialBackgroundThread)
  List<ApplicationInfoDto> getInstalledApplications({
    GetInstalledApplicationsPlatformOptionsDto? options,
  });

  @async
  @TaskQueue(type: TaskQueueType.serialBackgroundThread)
  Uint8List? getIcon(String iconId, {
    int? quality,
    IconSize? size,
  });
}

class IconSize {
  const IconSize(this.width, this.height);
  final int width;
  final int height;
}

sealed class GetInstalledApplicationsPlatformOptionsDto {}

class GetInstalledApplicationsAndroidOptionsDto
    implements GetInstalledApplicationsPlatformOptionsDto {
  const GetInstalledApplicationsAndroidOptionsDto({this.flag = 0});
  final int flag;
}

sealed class ApplicationInfoDto {}

final class AndroidApplicationInfoDto implements ApplicationInfoDto {
  final String packageName;
  final bool maybeSystem;
  final String? iconId;
  final String? name;
  final String? label;
  final bool enabled;
  final int flags;
  final int? category;
  final String processName;
  final int uid;
  final List<AndroidManifestPermissionDto> permissions;

  const AndroidApplicationInfoDto({
    required this.packageName,
    required this.maybeSystem,
    required this.enabled,
    required this.name,
    required this.label,
    required this.flags,
    required this.uid,
    required this.processName,
    required this.permissions,
    this.category,
    this.iconId,
  });
}

/// Must be same as in platform interface package
enum AndroidManifestPermissionDto {
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
