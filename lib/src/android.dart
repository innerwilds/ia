import 'package:freezed_annotation/freezed_annotation.dart';

enum ApplicationCategory {
  accessibility(8),
  audio(1),
  game(0),
  image(3),
  maps(6),
  news(5),
  productivity(7),
  social(4),
  undefined(-1),
  video(2);

  // Private field to hold the numeric value
  final int _value;

  // Constructor to initialize the numeric value
  const ApplicationCategory(this._value);

  factory ApplicationCategory.fromValue(int value) =>
      ApplicationCategory.values.firstWhere((e) => e._value == value);
}

enum ApplicationFlag {
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

  const ApplicationFlag(this._value);

  static int toFlag(Set<ApplicationFlag> flags) =>
      flags.fold<int>(0, (acc, f) => f._value | acc);

  final int _value;

  @internal
  bool withIn(int flags) => (flags & _value) != 0;
}

enum ManifestPermission {
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
