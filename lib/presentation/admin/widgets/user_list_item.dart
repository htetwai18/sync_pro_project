import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/enum.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';

class UserListItem extends StatelessWidget {
  final UserItemDisplayModel item;
  final VoidCallback? onTap;

  const UserListItem({super.key, required this.item, this.onTap});

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return AppColor.greenStatusInner;
      case UserRole.engineer:
        return AppColor.blueStatusInner;
      case UserRole.manager:
        return AppColor.orangeStatusInner;
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
              backgroundImage: NetworkImage(item.avatarUrl),
              backgroundColor: AppColor.greyStatusOuter,
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
              child: Text(item.roleLabel).smallBold(AppColor.white),
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
