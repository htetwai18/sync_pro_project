import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/enum.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';

class InvoiceListItem extends StatelessWidget {
  final InvoiceItemDisplayModel item;
  final VoidCallback? onTap;

  const InvoiceListItem({super.key, required this.item, this.onTap});

  String _statusLabel(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.paid:
        return AppString.paid;
      case InvoiceStatus.due:
        return AppString.due;
      case InvoiceStatus.overdue:
        return AppString.overdue;
      case InvoiceStatus.sent:
        return AppString.sent;
      case InvoiceStatus.voided:
        return AppString.voided;
      case InvoiceStatus.draft:
        return AppString.draft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: Measurement.generalSize4.verticalPadding,
        padding: const EdgeInsets.symmetric(
          horizontal: Measurement.generalSize16,
          vertical: Measurement.generalSize16,
        ),
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${AppString.invoice} #${item.id}')
                      .mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Text(item.customer).smallNormal(AppColor.grey),
                  Measurement.generalSize4.height,
                  Text('${AppString.due}: ${item.dueDate}')
                      .smallNormal(AppColor.grey),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${item.amount.toStringAsFixed(2)}',
                ).largeBold(AppColor.white),
                Measurement.generalSize8.height,
                Container(
                  padding: Measurement.generalSize8.horizontalIsToVertical,
                  decoration: BoxDecoration(
                    color: getInvoiceStatusOuterColor(item.status),
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: getInvoiceStatusInnerColor(item.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Measurement.generalSize8.width,
                      Text(_statusLabel(item.status)).smallBold(AppColor.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
