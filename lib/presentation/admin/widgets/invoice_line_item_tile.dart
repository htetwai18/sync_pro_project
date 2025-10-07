import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';

class InvoiceLineItemTile extends StatelessWidget {
  final InvoiceLineItem item;
  final VoidCallback? onEdit;
  const InvoiceLineItemTile({super.key, required this.item, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Measurement.generalSize16.horizontalIsToVertical,
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name).mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                Text('1 x \$${item.unitPrice.toStringAsFixed(2)}')
                    .smallNormal(AppColor.grey),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}
