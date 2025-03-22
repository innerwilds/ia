package ru.innerwilds.flutter.plugins.installed_apps

import android.Manifest
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.content.pm.PackageManager.NameNotFoundException
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.ByteArrayOutputStream

const val TAG = "InstalledAppsPlugin"

/// PackageManagerPlugin
class InstalledAppsPlugin : FlutterPlugin, InstalledAppsPigeon {
  private lateinit var methodChannel: MethodChannel

  private lateinit var context: Context
  private var pkgMgr: PackageManager? = null

  private fun setUp(messenger: BinaryMessenger, context: Context) {
    this.context = context
    try {
      InstalledAppsPigeon.setUp(messenger, this)
    } catch (ex: Exception) {
      Log.e(TAG, "Received exception while setting up PackageManagerPlugin", ex)
    }
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    pkgMgr = (binding.applicationContext as Context).packageManager

    setUp(binding.binaryMessenger, binding.applicationContext)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    InstalledAppsPigeon.setUp(binding.binaryMessenger, null)
    pkgMgr = null
  }

  private fun bitmapToByteArray(bitmap: Bitmap, quality: Int): ByteArray {
    val stream = ByteArrayOutputStream()
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        bitmap.compress(Bitmap.CompressFormat.WEBP_LOSSY, quality, stream)
      } else {
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
      }
      return stream.toByteArray()
  }

  private fun resizeBitmap(bitmap: Bitmap, width: Int, height: Int): Bitmap {
    return Bitmap.createScaledBitmap(bitmap, width, height, true)
  }

  private fun getBitmapFromDrawable(drawable: Drawable): Bitmap {
    if(Build.VERSION.SDK_INT <= Build.VERSION_CODES.N_MR1) return (drawable as BitmapDrawable).bitmap
    val bitmap = Bitmap.createBitmap(drawable.intrinsicWidth,drawable.intrinsicHeight,Bitmap.Config.ARGB_8888)
    val canvas = Canvas(bitmap)
    drawable.setBounds(0, 0, canvas.width, canvas.height)
    drawable.draw(canvas)
    return bitmap
  }

  private fun mapAppInfoToDto(it: ApplicationInfo): AndroidApplicationInfoDto {
    return AndroidApplicationInfoDto(
      packageName = it.packageName,
      maybeSystem = isProbablySystem(it),
      enabled = it.enabled,
      iconId = if (it.icon == 0) null else it.packageName,
      label = it.loadLabel(pkgMgr!!).toString(),
      name = it.name,
      flags = it.flags.toLong(),
      category = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        it.category.toLong() else null,
      uid = it.uid.toLong(),
      processName = it.processName,
      permissions = getApplicationInfoPermissions(it),
    )
  }

  private fun getApplicationInfoPermissions(app: ApplicationInfo): List<AndroidManifestPermissionDto> {
    val packageInfo = pkgMgr!!.getPackageInfo(app.packageName, PackageManager.GET_PERMISSIONS)
    val permissions = packageInfo.requestedPermissions ?: return emptyList()
    return permissions.mapNotNull { mapPermission(it) }
  }

  private fun mapPermission(permission: String): AndroidManifestPermissionDto? {
    return when (permission) {
      Manifest.permission.ACCESS_CHECKIN_PROPERTIES -> AndroidManifestPermissionDto.ACCESS_CHECKIN_PROPERTIES
      Manifest.permission.ACCESS_LOCATION_EXTRA_COMMANDS -> AndroidManifestPermissionDto.ACCESS_LOCATION_EXTRA_COMMANDS
      Manifest.permission.ACCESS_NETWORK_STATE -> AndroidManifestPermissionDto.ACCESS_NETWORK_STATE
      Manifest.permission.ACCESS_NOTIFICATION_POLICY -> AndroidManifestPermissionDto.ACCESS_NOTIFICATION_POLICY
      Manifest.permission.ACCESS_WIFI_STATE -> AndroidManifestPermissionDto.ACCESS_WIFI_STATE
      Manifest.permission.ACCOUNT_MANAGER -> AndroidManifestPermissionDto.ACCOUNT_MANAGER
      Manifest.permission.BATTERY_STATS -> AndroidManifestPermissionDto.BATTERY_STATS
      Manifest.permission.BIND_ACCESSIBILITY_SERVICE -> AndroidManifestPermissionDto.BIND_ACCESSIBILITY_SERVICE
      Manifest.permission.BIND_APPWIDGET -> AndroidManifestPermissionDto.BIND_APPWIDGET
      Manifest.permission.BIND_CARRIER_SERVICES -> AndroidManifestPermissionDto.BIND_CARRIER_SERVICES
      Manifest.permission.BIND_CONDITION_PROVIDER_SERVICE -> AndroidManifestPermissionDto.BIND_CONDITION_PROVIDER_SERVICE
      Manifest.permission.BIND_DEVICE_ADMIN -> AndroidManifestPermissionDto.BIND_DEVICE_ADMIN
      Manifest.permission.BIND_DREAM_SERVICE -> AndroidManifestPermissionDto.BIND_DREAM_SERVICE
      Manifest.permission.BIND_INCALL_SERVICE -> AndroidManifestPermissionDto.BIND_INCALL_SERVICE
      Manifest.permission.BIND_INPUT_METHOD -> AndroidManifestPermissionDto.BIND_INPUT_METHOD
      Manifest.permission.BIND_MIDI_DEVICE_SERVICE -> AndroidManifestPermissionDto.BIND_MIDI_DEVICE_SERVICE
      Manifest.permission.BIND_NFC_SERVICE -> AndroidManifestPermissionDto.BIND_NFC_SERVICE
      Manifest.permission.BIND_NOTIFICATION_LISTENER_SERVICE -> AndroidManifestPermissionDto.BIND_NOTIFICATION_LISTENER_SERVICE
      Manifest.permission.BIND_PRINT_SERVICE -> AndroidManifestPermissionDto.BIND_PRINT_SERVICE
      Manifest.permission.BIND_QUICK_SETTINGS_TILE -> AndroidManifestPermissionDto.BIND_QUICK_SETTINGS_TILE
      Manifest.permission.BIND_REMOTEVIEWS -> AndroidManifestPermissionDto.BIND_REMOTEVIEWS
      Manifest.permission.BIND_SCREENING_SERVICE -> AndroidManifestPermissionDto.BIND_SCREENING_SERVICE
      Manifest.permission.BIND_TELECOM_CONNECTION_SERVICE -> AndroidManifestPermissionDto.BIND_TELECOM_CONNECTION_SERVICE
      Manifest.permission.BIND_TEXT_SERVICE -> AndroidManifestPermissionDto.BIND_TEXT_SERVICE
      Manifest.permission.BIND_TV_INPUT -> AndroidManifestPermissionDto.BIND_TV_INPUT
      Manifest.permission.BIND_VOICE_INTERACTION -> AndroidManifestPermissionDto.BIND_VOICE_INTERACTION
      Manifest.permission.BIND_VPN_SERVICE -> AndroidManifestPermissionDto.BIND_VPN_SERVICE
      Manifest.permission.BIND_VR_LISTENER_SERVICE -> AndroidManifestPermissionDto.BIND_VR_LISTENER_SERVICE
      Manifest.permission.BIND_WALLPAPER -> AndroidManifestPermissionDto.BIND_WALLPAPER
      Manifest.permission.BLUETOOTH -> AndroidManifestPermissionDto.BLUETOOTH
      Manifest.permission.BLUETOOTH_ADMIN -> AndroidManifestPermissionDto.BLUETOOTH_ADMIN
      Manifest.permission.BLUETOOTH_PRIVILEGED -> AndroidManifestPermissionDto.BLUETOOTH_PRIVILEGED
      Manifest.permission.BROADCAST_PACKAGE_REMOVED -> AndroidManifestPermissionDto.BROADCAST_PACKAGE_REMOVED
      Manifest.permission.BROADCAST_SMS -> AndroidManifestPermissionDto.BROADCAST_SMS
      Manifest.permission.BROADCAST_STICKY -> AndroidManifestPermissionDto.BROADCAST_STICKY
      Manifest.permission.BROADCAST_WAP_PUSH -> AndroidManifestPermissionDto.BROADCAST_WAP_PUSH
      Manifest.permission.CALL_PRIVILEGED -> AndroidManifestPermissionDto.CALL_PRIVILEGED
      Manifest.permission.CAPTURE_AUDIO_OUTPUT -> AndroidManifestPermissionDto.CAPTURE_AUDIO_OUTPUT
      Manifest.permission.CHANGE_COMPONENT_ENABLED_STATE -> AndroidManifestPermissionDto.CHANGE_COMPONENT_ENABLED_STATE
      Manifest.permission.CHANGE_CONFIGURATION -> AndroidManifestPermissionDto.CHANGE_CONFIGURATION
      Manifest.permission.CHANGE_NETWORK_STATE -> AndroidManifestPermissionDto.CHANGE_NETWORK_STATE
      Manifest.permission.CHANGE_WIFI_MULTICAST_STATE -> AndroidManifestPermissionDto.CHANGE_WIFI_MULTICAST_STATE
      Manifest.permission.CHANGE_WIFI_STATE -> AndroidManifestPermissionDto.CHANGE_WIFI_STATE
      Manifest.permission.CLEAR_APP_CACHE -> AndroidManifestPermissionDto.CLEAR_APP_CACHE
      Manifest.permission.CONFIGURE_WIFI_DISPLAY -> AndroidManifestPermissionDto.CONFIGURE_WIFI_DISPLAY
      Manifest.permission.CONTROL_LOCATION_UPDATES -> AndroidManifestPermissionDto.CONTROL_LOCATION_UPDATES
      Manifest.permission.DELETE_CACHE_FILES -> AndroidManifestPermissionDto.DELETE_CACHE_FILES
      Manifest.permission.DELETE_PACKAGES -> AndroidManifestPermissionDto.DELETE_PACKAGES
      Manifest.permission.DIAGNOSTIC -> AndroidManifestPermissionDto.DIAGNOSTIC
      Manifest.permission.DISABLE_KEYGUARD -> AndroidManifestPermissionDto.DISABLE_KEYGUARD
      Manifest.permission.DUMP -> AndroidManifestPermissionDto.DUMP
      Manifest.permission.EXPAND_STATUS_BAR -> AndroidManifestPermissionDto.EXPAND_STATUS_BAR
      Manifest.permission.FACTORY_TEST -> AndroidManifestPermissionDto.FACTORY_TEST
      Manifest.permission.GET_ACCOUNTS_PRIVILEGED -> AndroidManifestPermissionDto.GET_ACCOUNTS_PRIVILEGED
      Manifest.permission.GET_PACKAGE_SIZE -> AndroidManifestPermissionDto.GET_PACKAGE_SIZE
      Manifest.permission.GLOBAL_SEARCH -> AndroidManifestPermissionDto.GLOBAL_SEARCH
      Manifest.permission.INSTALL_LOCATION_PROVIDER -> AndroidManifestPermissionDto.INSTALL_LOCATION_PROVIDER
      Manifest.permission.INSTALL_PACKAGES -> AndroidManifestPermissionDto.INSTALL_PACKAGES
      Manifest.permission.INTERNET -> AndroidManifestPermissionDto.INTERNET
      Manifest.permission.KILL_BACKGROUND_PROCESSES -> AndroidManifestPermissionDto.KILL_BACKGROUND_PROCESSES
      Manifest.permission.LOCATION_HARDWARE -> AndroidManifestPermissionDto.LOCATION_HARDWARE
      Manifest.permission.MANAGE_DOCUMENTS -> AndroidManifestPermissionDto.MANAGE_DOCUMENTS
      Manifest.permission.MASTER_CLEAR -> AndroidManifestPermissionDto.MASTER_CLEAR
      Manifest.permission.MEDIA_CONTENT_CONTROL -> AndroidManifestPermissionDto.MEDIA_CONTENT_CONTROL
      Manifest.permission.MODIFY_AUDIO_SETTINGS -> AndroidManifestPermissionDto.MODIFY_AUDIO_SETTINGS
      Manifest.permission.MODIFY_PHONE_STATE -> AndroidManifestPermissionDto.MODIFY_PHONE_STATE
      Manifest.permission.MOUNT_FORMAT_FILESYSTEMS -> AndroidManifestPermissionDto.MOUNT_FORMAT_FILESYSTEMS
      Manifest.permission.MOUNT_UNMOUNT_FILESYSTEMS -> AndroidManifestPermissionDto.MOUNT_UNMOUNT_FILESYSTEMS
      Manifest.permission.NFC -> AndroidManifestPermissionDto.NFC
      Manifest.permission.OVERRIDE_WIFI_CONFIG -> AndroidManifestPermissionDto.OVERRIDE_WIFI_CONFIG
      Manifest.permission.PACKAGE_USAGE_STATS -> AndroidManifestPermissionDto.PACKAGE_USAGE_STATS
      Manifest.permission.READ_LOGS -> AndroidManifestPermissionDto.READ_LOGS
      Manifest.permission.READ_PRECISE_PHONE_STATE -> AndroidManifestPermissionDto.READ_PRECISE_PHONE_STATE
      Manifest.permission.READ_SYNC_SETTINGS -> AndroidManifestPermissionDto.READ_SYNC_SETTINGS
      Manifest.permission.READ_SYNC_STATS -> AndroidManifestPermissionDto.READ_SYNC_STATS
      Manifest.permission.REBOOT -> AndroidManifestPermissionDto.REBOOT
      Manifest.permission.RECEIVE_BOOT_COMPLETED -> AndroidManifestPermissionDto.RECEIVE_BOOT_COMPLETED
      Manifest.permission.REORDER_TASKS -> AndroidManifestPermissionDto.REORDER_TASKS
      Manifest.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS -> AndroidManifestPermissionDto.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS
      Manifest.permission.REQUEST_INSTALL_PACKAGES -> AndroidManifestPermissionDto.REQUEST_INSTALL_PACKAGES
      Manifest.permission.SEND_RESPOND_VIA_MESSAGE -> AndroidManifestPermissionDto.SEND_RESPOND_VIA_MESSAGE
      Manifest.permission.SET_ALWAYS_FINISH -> AndroidManifestPermissionDto.SET_ALWAYS_FINISH
      Manifest.permission.SET_ANIMATION_SCALE -> AndroidManifestPermissionDto.SET_ANIMATION_SCALE
      Manifest.permission.SET_DEBUG_APP -> AndroidManifestPermissionDto.SET_DEBUG_APP
      Manifest.permission.SET_PROCESS_LIMIT -> AndroidManifestPermissionDto.SET_PROCESS_LIMIT
      Manifest.permission.SET_TIME -> AndroidManifestPermissionDto.SET_TIME
      Manifest.permission.SET_TIME_ZONE -> AndroidManifestPermissionDto.SET_TIME_ZONE
      Manifest.permission.SET_WALLPAPER -> AndroidManifestPermissionDto.SET_WALLPAPER
      Manifest.permission.SET_WALLPAPER_HINTS -> AndroidManifestPermissionDto.SET_WALLPAPER_HINTS
      Manifest.permission.SIGNAL_PERSISTENT_PROCESSES -> AndroidManifestPermissionDto.SIGNAL_PERSISTENT_PROCESSES
      Manifest.permission.STATUS_BAR -> AndroidManifestPermissionDto.STATUS_BAR
      Manifest.permission.SYSTEM_ALERT_WINDOW -> AndroidManifestPermissionDto.SYSTEM_ALERT_WINDOW
      Manifest.permission.TRANSMIT_IR -> AndroidManifestPermissionDto.TRANSMIT_IR
      Manifest.permission.UPDATE_DEVICE_STATS -> AndroidManifestPermissionDto.UPDATE_DEVICE_STATS
      Manifest.permission.VIBRATE -> AndroidManifestPermissionDto.VIBRATE
      Manifest.permission.WAKE_LOCK -> AndroidManifestPermissionDto.WAKE_LOCK
      Manifest.permission.WRITE_APN_SETTINGS -> AndroidManifestPermissionDto.WRITE_APN_SETTINGS
      Manifest.permission.WRITE_GSERVICES -> AndroidManifestPermissionDto.WRITE_GSERVICES
      Manifest.permission.WRITE_SECURE_SETTINGS -> AndroidManifestPermissionDto.WRITE_SECURE_SETTINGS
      Manifest.permission.WRITE_SETTINGS -> AndroidManifestPermissionDto.WRITE_SETTINGS
      Manifest.permission.WRITE_SYNC_SETTINGS -> AndroidManifestPermissionDto.WRITE_SYNC_SETTINGS
      else -> null
    }
  }

  private fun isProbablySystem(app: ApplicationInfo): Boolean {
    return isAppInSystemPartition(app.packageName) || isSignedBySystem(app.packageName);
  }

  /**
   * Check if an App is under /system or has been installed as an update to a built-in system application.
   */
  private fun isAppInSystemPartition(packageName: String): Boolean {
    try {
      val ai = pkgMgr!!.getApplicationInfo(packageName, 0)
      return ((ai.flags and (ApplicationInfo.FLAG_SYSTEM or ApplicationInfo.FLAG_UPDATED_SYSTEM_APP)) != 0)
    } catch (e: NameNotFoundException) {
      Log.d(TAG, "exception", e)
      return false
    }
  }

  /**
   * Check if an App is signed by system or not.
   */
  private fun isSignedBySystem(packageName: String): Boolean {
    try {
      return pkgMgr!!.checkSignatures(packageName, "android") >= 0
    } catch (e: NameNotFoundException) {
      Log.d(TAG, "exception", e)
      return false
    }
  }

  override fun getInstalledApplications(
    options: GetInstalledApplicationsPlatformOptionsDto?,
    callback: (Result<List<ApplicationInfoDto>>) -> Unit
  ) {
    val flag: Long = when (options) {
      null -> 0
      is GetInstalledApplicationsAndroidOptionsDto -> options.flag
    }

    CoroutineScope(Dispatchers.IO).launch {
      try {
        val isLongFlag = flag > Int.MAX_VALUE

        val apps: List<ApplicationInfo> = if (isLongFlag && Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
          pkgMgr!!.getInstalledApplications(PackageManager.ApplicationInfoFlags.of(flag))
        } else {
          pkgMgr!!.getInstalledApplications(flag.toInt())
        }

        callback(Result.success(
          apps.map {
            mapAppInfoToDto(it)
          }
        ))
      } catch (e: Throwable) {
        callback(Result.failure(e));
      }
    }
  }

  override fun getIcon(
    iconId: String,
    quality: Long?,
    size: IconSize?,
    callback: (Result<ByteArray?>) -> Unit
  ) {
    CoroutineScope(Dispatchers.IO).launch {
      try {
        val drawable = pkgMgr!!.getApplicationIcon(iconId)
        val bitmap = getBitmapFromDrawable(drawable)
        if (size != null) {
          resizeBitmap(bitmap, size.width.toInt(), size.height.toInt())
        }
        val icon = bitmapToByteArray(bitmap, quality?.toInt() ?: 90)
        callback(Result.success(icon))
      } catch (e: Throwable) {
        callback(Result.failure(e))
      }
    }
  }
}