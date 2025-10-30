import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/enum.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  UserRole? _selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.addNewUser, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.fullName).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _nameController,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.enterFullName,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.emailAddress).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.enterEmailAddress,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.role).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                hint: const Text(AppString.selectRole)
                    .mediumNormal(AppColor.grey),
                items: [
                  DropdownMenuItem(
                    value: UserRole.admin,
                    child:
                        Text(AppString.adminRole).mediumNormal(AppColor.white),
                  ),
                  DropdownMenuItem(
                    value: UserRole.engineer,
                    child: Text(AppString.engineerRole)
                        .mediumNormal(AppColor.white),
                  ),
                  DropdownMenuItem(
                    value: UserRole.manager,
                    child: Text(AppString.managerRole)
                        .mediumNormal(AppColor.white),
                  ),
                ],
                onChanged: (val) => setState(() => _selectedRole = val),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.password).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.enterPassword,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.confirmPassword).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.confirmNewPassword,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
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
                onPressed: () {},
                child:
                    const Text(AppString.createUser).mediumBold(AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final Widget child;
  const _Field({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: child,
    );
  }
}
