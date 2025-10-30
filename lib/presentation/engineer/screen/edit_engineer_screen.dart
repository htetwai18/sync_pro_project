import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/enum.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';

class EditEngineerScreen extends StatefulWidget {
  final UserModel user;
  const EditEngineerScreen({super.key, required this.user});

  @override
  State<EditEngineerScreen> createState() => _EditEngineerScreenState();
}

class _EditEngineerScreenState extends State<EditEngineerScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  UserRole _role = UserRole.engineer;
  String _status = AppString.active;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _role = widget.user.role;
    _status = widget.user.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.editProfile, context: context),
      body: Padding(
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
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  hintText: _nameController.text.isEmpty
                      ? AppString.hintFullName
                      : null,
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
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  hintText: _emailController.text.isEmpty
                      ? AppString.hintEmail
                      : null,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.phone).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  hintText:
                      _phoneController.text.isEmpty ? 'Enter phone' : null,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.role).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<UserRole>(
                value: _role,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                items: [
                  DropdownMenuItem(
                    value: UserRole.engineer,
                    child: const Text(AppString.engineerRole)
                        .mediumNormal(AppColor.white),
                  ),
                ],
                onChanged: (val) => setState(() => _role = val ?? _role),
              ),
            ),
            Measurement.generalSize16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('${AppString.lastUpdatedText}: 2 days ago')
                    .smallNormal(AppColor.grey),
                Container(
                  padding: Measurement.generalSize8.horizontalIsToVertical,
                  decoration: BoxDecoration(
                    color: _status == AppString.active
                        ? AppColor.greenStatusInner
                        : AppColor.redStatusInner,
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Text(_status).smallBold(AppColor.white),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.greyPercentCircle),
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.blueField,
                      padding: Measurement.generalSize16.horizontalIsToVertical,
                      shape: RoundedRectangleBorder(
                        borderRadius: Measurement.generalSize12.allRadius,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child:
                        const Text(AppString.cancel).mediumBold(AppColor.white),
                  ),
                ),
                Measurement.generalSize16.width,
                Expanded(
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
                    child: const Text(AppString.saveChanges)
                        .mediumBold(AppColor.white),
                  ),
                ),
              ],
            ),
            Measurement.generalSize16.height,
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
