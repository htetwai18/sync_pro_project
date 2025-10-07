import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';

class CustomerListItem extends StatelessWidget {
  final CustomerItemDisplayModel item;
  final VoidCallback? onTap;

  const CustomerListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Measurement.generalSize16,
          vertical: Measurement.generalSize16,
        ),
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: Measurement.generalSize20,
              backgroundColor: AppColor.greenStatusOuter,
              child: const Icon(Icons.apartment, color: AppColor.white),
            ),
            Measurement.generalSize12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name).mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Text(item.phone).smallNormal(AppColor.grey),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}
