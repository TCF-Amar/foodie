import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Utility class to handle runtime permissions.
class AppPermission {
  // Private constructor
  AppPermission._();

  /// Check if a specific permission is granted.
  static Future<bool> isGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// Check if a specific permission is permanently denied.
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }

  /// Request a single permission and return the resulting status.
  static Future<PermissionStatus> requestPermission(
    Permission permission,
  ) async {
    final status = await permission.request();
    return status;
  }

  /// Request multiple permissions at once.
  /// Returns a map of permission -> status.
  static Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> permissions,
  ) async {
    final Map<Permission, PermissionStatus> results = {};
    for (final permission in permissions) {
      results[permission] = await permission.request();
    }
    return results;
  }

  /// Open app settings (usually called when permission is permanently denied).
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }

  // ---------- Common Permission Helpers ----------

  /// Request camera permission.
  /// Returns true if granted.
  static Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Request storage permission (for Android 12 and below).
  /// On Android 13+, use photos/media permissions separately.
  static Future<bool> requestStorage() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Request photos permission (Android 13+ only).
  static Future<bool> requestPhotos() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Request location permission (when in use).
  static Future<bool> requestLocationWhenInUse() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  /// Request location permission (always).
  static Future<bool> requestLocationAlways() async {
    final status = await Permission.locationAlways.request();
    return status.isGranted;
  }

  /// Request notification permission (Android 13+, iOS).
  static Future<bool> requestNotifications() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Request microphone permission.
  static Future<bool> requestMicrophone() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Request contacts permission.
  static Future<bool> requestContacts() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  /// Request calendar permission.
  static Future<bool> requestCalendar() async {
    final status = await Permission.calendarFullAccess.request();
    return status.isGranted;
  }

  /// Request SMS permission.
  static Future<bool> requestSms() async {
    final status = await Permission.sms.request();
    return status.isGranted;
  }

  /// Request phone permission.
  static Future<bool> requestPhone() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }

  /// Request bluetooth permission (Android 12+).
  static Future<bool> requestBluetooth() async {
    final status = await Permission.bluetooth.request();
    return status.isGranted;
  }

  /// Request ignore battery optimizations.
  static Future<bool> requestIgnoreBatteryOptimizations() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    return status.isGranted;
  }

  // ---------- Combined Checks ----------

  /// Check if all required permissions are granted.
  static Future<bool> hasAllPermissions(List<Permission> permissions) async {
    for (final permission in permissions) {
      if (!await isGranted(permission)) {
        return false;
      }
    }
    return true;
  }

  /// Request multiple permissions and return true if all granted.
  static Future<bool> requestAllPermissions(
    List<Permission> permissions,
  ) async {
    final results = await requestPermissions(permissions);
    return results.values.every((status) => status.isGranted);
  }

  /// Show rationale dialog (optional, implement with your own UI).
  /// This is just a placeholder – you should show a custom dialog explaining why the permission is needed.
  static Future<bool> showRationaleDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    // Implement using showDialog or your custom dialog widget.
    // Return true if user accepts, false otherwise.
    // Example:
    // final result = await showDialog<bool>(...);
    // return result ?? false;
    return true; // Placeholder
  }
}
