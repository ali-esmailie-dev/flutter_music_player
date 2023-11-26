import 'package:permission_handler/permission_handler.dart';

class AppPermissionHelper {
  static Future<bool> requestPermission(final Permission permission) async {
    final status = await permission.request();

    return status.isGranted;
  }

  static Future<bool> checkPermissionStatus(final Permission permission) async {
    final status = await permission.status;

    return status.isGranted;
  }

  static Future<PermissionStatus> getPermissionStatus(
    final Permission permission,
  ) {
    return permission.status;
  }

  static Future<bool> openAppSettings() async {
    return openAppSettings();
  }

  static Future<bool> openLocationSettings() async {
    return openLocationSettings();
  }
}
