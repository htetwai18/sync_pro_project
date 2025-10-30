import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';

class UserListItem extends StatelessWidget {
  final UserModel item;
  final VoidCallback? onTap;

  const UserListItem({super.key, required this.item, this.onTap});

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return AppColor.greenStatusInner;
      case 'engineer':
        return AppColor.blueStatusInner;
      case 'manager':
        return AppColor.orangeStatusInner;
      default:
        return AppColor.blueField;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: Measurement.generalSize16.horizontalPadding,
        padding: const EdgeInsets.symmetric(
          horizontal: Measurement.generalSize16,
          vertical: Measurement.generalSize12,
        ),
        decoration: BoxDecoration(
            color: AppColor.blueField,
            borderRadius: Measurement.generalSize8.allRadius),
        child: Row(
          children: [
            CircleAvatar(
              radius: Measurement.generalSize20,
              backgroundColor: AppColor.greyStatusOuter,
              child: const Icon(Icons.person, color: AppColor.white, size: 18),
            ),
            Measurement.generalSize12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name).mediumBold(AppColor.white),
                  Measurement.generalSize4.height,
                  Text(item.email).smallNormal(AppColor.grey),
                ],
              ),
            ),
            Container(
              padding: Measurement.generalSize8.horizontalIsToVertical,
              decoration: BoxDecoration(
                color: _getRoleColor(item.role),
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: Text(item.role).smallBold(AppColor.white),
            ),
            Measurement.generalSize8.width,
            const Icon(
              Icons.chevron_right,
              color: AppColor.grey,
              size: Measurement.generalSize20,
            ),
          ],
        ),
      ),
    );
  }
}
