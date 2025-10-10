import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/screen/dashboard_screen.dart';
import 'package:sync_pro/presentation/customer/screen/bottom_navigation_customer.dart';
import 'package:sync_pro/presentation/engineer/screen/bottom_navigation_engineer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Padding(
          padding: Measurement.generalSize16.horizontalPadding,
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
              const Text(AppString.logIn).largeBold(AppColor.grey),
              Measurement.generalSize48.height,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: TextField(
                  controller: _usernameController,
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  decoration: InputDecoration(
                    hintText: AppString.usernameOrEmail,
                    hintStyle: Measurement.mediumFont
                        .textStyle(AppColor.grey, Measurement.font400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize14,
                    ),
                  ),
                ),
              ),
              Measurement.generalSize16.height,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  decoration: InputDecoration(
                    hintText: AppString.passwordLabel,
                    hintStyle: Measurement.mediumFont
                        .textStyle(AppColor.grey, Measurement.font400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize14,
                    ),
                  ),
                ),
              ),
              Measurement.generalSize8.height,
              Align(
                alignment: Alignment.centerRight,
                child: const Text(AppString.forgotPassword)
                    .smallNormal(AppColor.grey),
              ),
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
                    //Routing.transition(context, const DashboardScreen());
                    Routing.transition(
                        context, const BottomNavigationCustomer());
                  },
                  child: const Text(AppString.logIn).mediumBold(AppColor.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
