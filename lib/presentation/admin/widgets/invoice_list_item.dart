import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';

class InvoiceListItem extends StatelessWidget {
  final InvoiceModel item;
  final VoidCallback? onTap;

  const InvoiceListItem({super.key, required this.item, this.onTap});

  String _statusLabel(String status) =>
      status.isEmpty ? '' : status[0].toUpperCase() + status.substring(1);
  Color _statusOuter(String status) {
    switch (status) {
      case 'paid':
        return AppColor.greenStatusOuter;
      case 'sent':
        return AppColor.blueStatusOuter;
      case 'draft':
        return AppColor.greyStatusOuter;
      case 'voided':
        return AppColor.redStatusOuter;
      case 'due':
        return AppColor.orangeStatusOuter;
      case 'overdue':
        return AppColor.redStatusOuter;
      default:
        return AppColor.blueField;
    }
  }

  Color _statusInner(String status) {
    switch (status) {
      case 'paid':
        return AppColor.greenStatusInner;
      case 'sent':
        return AppColor.blueStatusInner;
      case 'draft':
        return AppColor.greyStatusInner;
      case 'voided':
        return AppColor.redStatusInner;
      case 'due':
        return AppColor.orangeStatusInner;
      case 'overdue':
        return AppColor.redStatusInner;
      default:
        return AppColor.blueField;
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
                  Text(item.customer.name).smallNormal(AppColor.grey),
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
                    color: _statusOuter(item.status),
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _statusInner(item.status),
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
