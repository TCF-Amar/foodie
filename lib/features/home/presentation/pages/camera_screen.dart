import 'package:flutter/material.dart';
import 'package:foodie/core/utils/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  Future<void> _checkAndRequestCamera(BuildContext context) async {
    // Check if already granted
    if (await AppPermission.isGranted(Permission.camera)) {
      // Permission already granted – proceed
      _openCamera();
      return;
    }

    // Request permission
    final status = await AppPermission.requestPermission(Permission.camera);

    if (status.isGranted) {
      _openCamera();
    } else if (status.isPermanentlyDenied) {
      // Show dialog to open app settings
      _showSettingsDialog(context);
    } else {
      // Denied but not permanently – you can show a rationale
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera permission is required to take photos'),
        ),
      );
    }
  }

  void _openCamera() {
    // Navigate to camera or call camera plugin
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Camera permission is permanently denied. Please enable it from settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              AppPermission.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _checkAndRequestCamera(context),
          child: const Text('Take Photo'),
        ),
      ),
    );
  }
}
