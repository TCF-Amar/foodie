import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:foodie/core/routes/app_routes.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionAndFetch();
  }

  Future<void> _checkPermissionAndFetch() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _fetchLocation();
    }
  }

  Future<void> _fetchLocation() async {
    setState(() => _isFetching = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Location permissions are permanently denied, please enable in settings',
              ),
            ),
          );
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      debugPrint(
        'Location fetched: ${position.latitude}, ${position.longitude}',
      );

      if (mounted) {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          context.goNamed(AppRoutes.home.name);
        } else {
          context.goNamed(AppRoutes.login.name);
        }
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isFetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Icon/Illustration or Loading Animation
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: _isFetching
                    ? SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          color: AppColors.primary,
                        ),
                      )
                    : Icon(
                        Icons.location_on_rounded,
                        size: 80,
                        color: AppColors.primary,
                      ),
              ),
              const SizedBox(height: 40),
              AppText.extraLarge(
                _isFetching
                    ? "Fetching Location..."
                    : "Find Delicious Food\nNear You!",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              const SizedBox(height: 16),
              AppText.medium(
                "We need your location to show you the best restaurants and offers in your neighborhood.",
                textAlign: TextAlign.center,
                color: AppColors.textSecondary,
                overflow: TextOverflow.clip,
              ),
              const Spacer(),
              AppButton(
                onPressed: _isFetching ? null : _fetchLocation,
                width: double.infinity,
                loading: _isFetching,
                child: const Text("Fetch Current Location"),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Fallback: Skip for now if you want
                  final session = Supabase.instance.client.auth.currentSession;
                  if (session != null) {
                    context.goNamed(AppRoutes.home.name);
                  } else {
                    context.goNamed(AppRoutes.login.name);
                  }
                },
                child: AppText.small("Not Now", color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
