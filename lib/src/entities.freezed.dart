// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationInfo implements DiagnosticableTreeMixin {

 String get packageName; bool get maybeSystem; bool get enabled; Set<ApplicationInfoFlag> get flags; String get processName; int get uid; List<AndroidManifestPermission> get permissions; String? get iconId; String? get name; String? get label; ApplicationCategory? get category;
/// Create a copy of ApplicationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationInfoCopyWith<ApplicationInfo> get copyWith => _$ApplicationInfoCopyWithImpl<ApplicationInfo>(this as ApplicationInfo, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ApplicationInfo'))
    ..add(DiagnosticsProperty('packageName', packageName))..add(DiagnosticsProperty('maybeSystem', maybeSystem))..add(DiagnosticsProperty('enabled', enabled))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('processName', processName))..add(DiagnosticsProperty('uid', uid))..add(DiagnosticsProperty('permissions', permissions))..add(DiagnosticsProperty('iconId', iconId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('label', label))..add(DiagnosticsProperty('category', category));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationInfo&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.maybeSystem, maybeSystem) || other.maybeSystem == maybeSystem)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.flags, flags)&&(identical(other.processName, processName) || other.processName == processName)&&(identical(other.uid, uid) || other.uid == uid)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.iconId, iconId) || other.iconId == iconId)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,packageName,maybeSystem,enabled,const DeepCollectionEquality().hash(flags),processName,uid,const DeepCollectionEquality().hash(permissions),iconId,name,label,category);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ApplicationInfo(packageName: $packageName, maybeSystem: $maybeSystem, enabled: $enabled, flags: $flags, processName: $processName, uid: $uid, permissions: $permissions, iconId: $iconId, name: $name, label: $label, category: $category)';
}


}

/// @nodoc
abstract mixin class $ApplicationInfoCopyWith<$Res>  {
  factory $ApplicationInfoCopyWith(ApplicationInfo value, $Res Function(ApplicationInfo) _then) = _$ApplicationInfoCopyWithImpl;
@useResult
$Res call({
 String packageName, bool maybeSystem, bool enabled, Set<ApplicationInfoFlag> flags, String processName, int uid, List<AndroidManifestPermission> permissions, String? iconId, String? name, String? label, ApplicationCategory? category
});




}
/// @nodoc
class _$ApplicationInfoCopyWithImpl<$Res>
    implements $ApplicationInfoCopyWith<$Res> {
  _$ApplicationInfoCopyWithImpl(this._self, this._then);

  final ApplicationInfo _self;
  final $Res Function(ApplicationInfo) _then;

/// Create a copy of ApplicationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packageName = null,Object? maybeSystem = null,Object? enabled = null,Object? flags = null,Object? processName = null,Object? uid = null,Object? permissions = null,Object? iconId = freezed,Object? name = freezed,Object? label = freezed,Object? category = freezed,}) {
  return _then(_self.copyWith(
packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,maybeSystem: null == maybeSystem ? _self.maybeSystem : maybeSystem // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as Set<ApplicationInfoFlag>,processName: null == processName ? _self.processName : processName // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<AndroidManifestPermission>,iconId: freezed == iconId ? _self.iconId : iconId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ApplicationCategory?,
  ));
}

}


/// @nodoc


class AndroidApplicationInfo with DiagnosticableTreeMixin implements ApplicationInfo {
  const AndroidApplicationInfo({required this.packageName, required this.maybeSystem, required this.enabled, required final  Set<ApplicationInfoFlag> flags, required this.processName, required this.uid, required final  List<AndroidManifestPermission> permissions, this.iconId, this.name, this.label, this.category}): _flags = flags,_permissions = permissions;
  

@override final  String packageName;
@override final  bool maybeSystem;
@override final  bool enabled;
 final  Set<ApplicationInfoFlag> _flags;
@override Set<ApplicationInfoFlag> get flags {
  if (_flags is EqualUnmodifiableSetView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_flags);
}

@override final  String processName;
@override final  int uid;
 final  List<AndroidManifestPermission> _permissions;
@override List<AndroidManifestPermission> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override final  String? iconId;
@override final  String? name;
@override final  String? label;
@override final  ApplicationCategory? category;

/// Create a copy of ApplicationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AndroidApplicationInfoCopyWith<AndroidApplicationInfo> get copyWith => _$AndroidApplicationInfoCopyWithImpl<AndroidApplicationInfo>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ApplicationInfo.android'))
    ..add(DiagnosticsProperty('packageName', packageName))..add(DiagnosticsProperty('maybeSystem', maybeSystem))..add(DiagnosticsProperty('enabled', enabled))..add(DiagnosticsProperty('flags', flags))..add(DiagnosticsProperty('processName', processName))..add(DiagnosticsProperty('uid', uid))..add(DiagnosticsProperty('permissions', permissions))..add(DiagnosticsProperty('iconId', iconId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('label', label))..add(DiagnosticsProperty('category', category));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AndroidApplicationInfo&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.maybeSystem, maybeSystem) || other.maybeSystem == maybeSystem)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._flags, _flags)&&(identical(other.processName, processName) || other.processName == processName)&&(identical(other.uid, uid) || other.uid == uid)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.iconId, iconId) || other.iconId == iconId)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,packageName,maybeSystem,enabled,const DeepCollectionEquality().hash(_flags),processName,uid,const DeepCollectionEquality().hash(_permissions),iconId,name,label,category);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ApplicationInfo.android(packageName: $packageName, maybeSystem: $maybeSystem, enabled: $enabled, flags: $flags, processName: $processName, uid: $uid, permissions: $permissions, iconId: $iconId, name: $name, label: $label, category: $category)';
}


}

/// @nodoc
abstract mixin class $AndroidApplicationInfoCopyWith<$Res> implements $ApplicationInfoCopyWith<$Res> {
  factory $AndroidApplicationInfoCopyWith(AndroidApplicationInfo value, $Res Function(AndroidApplicationInfo) _then) = _$AndroidApplicationInfoCopyWithImpl;
@override @useResult
$Res call({
 String packageName, bool maybeSystem, bool enabled, Set<ApplicationInfoFlag> flags, String processName, int uid, List<AndroidManifestPermission> permissions, String? iconId, String? name, String? label, ApplicationCategory? category
});




}
/// @nodoc
class _$AndroidApplicationInfoCopyWithImpl<$Res>
    implements $AndroidApplicationInfoCopyWith<$Res> {
  _$AndroidApplicationInfoCopyWithImpl(this._self, this._then);

  final AndroidApplicationInfo _self;
  final $Res Function(AndroidApplicationInfo) _then;

/// Create a copy of ApplicationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packageName = null,Object? maybeSystem = null,Object? enabled = null,Object? flags = null,Object? processName = null,Object? uid = null,Object? permissions = null,Object? iconId = freezed,Object? name = freezed,Object? label = freezed,Object? category = freezed,}) {
  return _then(AndroidApplicationInfo(
packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,maybeSystem: null == maybeSystem ? _self.maybeSystem : maybeSystem // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as Set<ApplicationInfoFlag>,processName: null == processName ? _self.processName : processName // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<AndroidManifestPermission>,iconId: freezed == iconId ? _self.iconId : iconId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ApplicationCategory?,
  ));
}


}

// dart format on
