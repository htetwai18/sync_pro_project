import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/engineer/screen/edit_engineer_screen.dart';

class EngineerDetailScreen extends StatelessWidget {
  final UserModel user;

  const EngineerDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:
          getAppBar(title: AppString.profile, context: context, canBack: false),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150'),
            ),
            Measurement.generalSize16.height,
            Text(user.name).xLargeBold(AppColor.white),
            Measurement.generalSize8.height,
            Text(user.role).mediumNormal(AppColor.grey),
            Measurement.generalSize8.height,
            Text('${AppString.id}: ${user.id}').smallNormal(AppColor.grey),
            Measurement.generalSize24.height,
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
                    onPressed: () {
                      Routing.transition(
                        context,
                        EditEngineerScreen(user: user),
                      );
                    },
                    child:
                        const Text(AppString.edit).mediumBold(AppColor.white),
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
                    child:
                        const Text(AppString.logout).mediumBold(AppColor.white),
                  ),
                ),
              ],
            ),
            Measurement.generalSize24.height,
            _DetailRow(label: AppString.emailAddress, value: user.email),
            _Divider(),
            _DetailRow(label: AppString.phone, value: user.phone),
            _Divider(),
            _DetailRow(label: AppString.role, value: user.role),
            _Divider(),
            _DetailRow(label: AppString.department, value: user.department??''),
            _Divider(),
            _DetailRow(label: AppString.statusUpper, value: 'Active'),
            _Divider(),
            _DetailRow(label: AppString.locationLabel, value: 'All'),
            // _Divider(),
            // _DetailRow(label: AppString.hireDate, value: user.hireDate),
            // _Divider(),
            // _DetailRow(label: AppString.lastLogin, value: user.lastLogin),
          ],
        ),
      ),

    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Measurement.generalSize14,
      ),
      child: Row(
        children: [
          Expanded(child: Text(label).smallNormal(AppColor.grey)),
          Text(value).mediumBold(AppColor.white),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColor.greyPercentCircle.withOpacity(0.2),
    );
  }
}
