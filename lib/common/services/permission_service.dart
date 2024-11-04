import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../logger/app_logger.dart';

/// [PermissionService] helper module for dealing with dynamic permissions.
class PermissionService {
  final _deviceInfo = DeviceInfoPlugin();

  /// Request a permission
  Future<bool> requestPermission(
    Permission permission, {
    bool isShowSetting = true,
    bool isShowAlert = true,
  }) async {
    var permissionRedirect = await _redirectPermission(permission);
    await permissionRedirect.request().then((value) {
      AppLogger.instance.d('Status ${permission.toString()}: $value');
      _handleActionPermissionBaseOnStatus(value,
          isShowSetting: isShowSetting, isShowAlert: isShowAlert);
    });
    return isCanAccessPermission(permissionRedirect);
  }

  /// Request list of permissions
  Future<bool> requestPermissions(
    List<Permission> permissions, {
    bool isShowSetting = true,
    bool isShowAlert = true,
  }) async {
    var permissionsRedirect = await Future.wait(
        permissions.map((e) => _redirectPermission(e)).toList());
    await permissionsRedirect.request().then((value) {
      value.forEach((key, value) {
        AppLogger.instance.d('Status permission ${key.toString()}: $value');
        _handleActionPermissionBaseOnStatus(
          value,
          isShowSetting: isShowSetting,
          isShowAlert: isShowAlert,
        );
      });
    });
    return isCanAccessPermissions(permissionsRedirect);
  }

  /// Checking a permission is granted or limited
  ///
  /// [permission] : Permission is needed request.
  ///
  /// True: if a permission is granted or limited
  Future<bool> isCanAccessPermission(Permission permission) async {
    return await permission.isGranted || await permission.isLimited;
  }

  /// Checking list of permissions are granted or limited
  ///
  /// [permissions] : List of permissions are needed request.
  ///
  /// True: if all permissions are granted or limited
  Future<bool> isCanAccessPermissions(
    List<Permission> permissions,
  ) async {
    var access = true;
    for (final e in permissions) {
      if (await isCanAccessPermission(e) == false) access = false;
    }
    return access;
  }

  /// Checking a permission is granted
  ///
  /// [permission] : Permission is needed request.
  ///
  /// True: if a permission is granted or limited
  Future<bool> isGrantedPermission(Permission permission) {
    return permission.isGranted;
  }

  /// Get permission status
  ///
  /// [permission] : Permission is need to get status.
  Future<PermissionStatus> statusPermission(
    Permission permission,
  ) async {
    return permission.status;
  }

  Future<PermissionStatus> _handleActionPermissionBaseOnStatus(
    PermissionStatus permissionStatus, {
    bool isShowSetting = true,
    bool isShowAlert = true,
  }) async {
    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        return permissionStatus;
      case PermissionStatus.provisional:
      case PermissionStatus.restricted:
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return permissionStatus;
    }
  }

  /// Redirect the type of permission requested based on the
  /// Android API or OS version of the device using the app.
  Future<Permission> _redirectPermission(Permission permission) async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      final sdkVersion = androidInfo.version.sdkInt;
      switch (permission) {
        case Permission.storage:
        case Permission.manageExternalStorage:
          if (sdkVersion >= 30) {
            return Permission.photos;
          }
          // Only below sdk version 30
          return Permission.storage;
      }
    }
    return permission;
  }
}
