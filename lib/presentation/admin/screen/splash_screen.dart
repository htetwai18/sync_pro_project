import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Padding(
          padding: Measurement.generalSize24.horizontalIsToVertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Measurement.generalSize72,
                height: Measurement.generalSize72,
                decoration: BoxDecoration(
                  color: AppColor.blueStatusInner,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: const Icon(
                  Icons.safety_check,
                  color: AppColor.white,
                  size: Measurement.generalSize48,
                ),
              ),
              Measurement.generalSize24.height,
              const Text(AppString.welcomeTo).largeBold(AppColor.white),
              Measurement.generalSize12.height,
              const Text(AppString.welcomeSubtitle).smallNormal(AppColor.grey),
              Measurement.generalSize24.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blueStatusInner,
                    foregroundColor: AppColor.white,
                    padding: Measurement.generalSize16.horizontalIsToVertical,
                    shape: RoundedRectangleBorder(
                      borderRadius: Measurement.generalSize12.allRadius,
                    ),
                  ),
                  onPressed: () {
                    Routing.transition(context, const LoginScreen());
                  },
                  child: const Text(AppString.getStarted)
                      .mediumBold(AppColor.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
