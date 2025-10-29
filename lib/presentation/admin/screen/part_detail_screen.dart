import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/screen/edit_part_screen.dart';
import 'package:sync_pro/presentation/admin/screen/adjust_stock_screen.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_stock_display_model.dart';

class PartDetailScreen extends StatelessWidget {
  final PartItemDisplayModel part;
  const PartDetailScreen({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.partDetails, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(AppString.partDetails)
                          .mediumBold(AppColor.white),
                      TextButton.icon(
                        onPressed: () {
                          Routing.transition(
                            context,
                            EditPartScreen(part: part),
                          );
                        },
                        icon: const Icon(Icons.edit, color: AppColor.white),
                        label: const Text(AppString.editAction)
                            .smallBold(AppColor.white),
                      )
                    ],
                  ),
                  Measurement.generalSize8.height,
                  _KV(k: AppString.partName, v: part.name),
                  _Divider(),
                  _KV(k: AppString.partNumber, v: part.number),
                  _Divider(),
                  _KV(k: AppString.manufacturer, v: part.manufacturer),
                  _Divider(),
                  _KV(
                      k: AppString.unitPrice,
                      v: '\$${part.unitPrice.toStringAsFixed(2)}'),
                ],
              ),
            ),
            Measurement.generalSize16.height,
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(AppString.inventoryStock)
                          .largeBold(AppColor.white),
                      TextButton(
                        onPressed: () {
                          Routing.transition(
                            context,
                            AdjustStockScreen(
                              partName: part.name,
                              partNumber: part.number,
                              currentQty: part.onHand,
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.blueStatusOuter,
                          foregroundColor: AppColor.blueStatusInner,
                          padding:
                              Measurement.generalSize12.horizontalIsToVertical,
                          shape: RoundedRectangleBorder(
                            borderRadius: Measurement.generalSize12.allRadius,
                          ),
                        ),
                        child: const Text(AppString.adjust)
                            .smallBold(AppColor.blueStatusInner),
                      )
                    ],
                  ),
                  Measurement.generalSize12.height,
                  ..._stockForPart(part.id).map((s) => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s.warehouseName)
                                        .mediumBold(AppColor.white),
                                    Measurement.generalSize8.height,
                                    Row(
                                      children: [
                                        const Text('Quantity: ')
                                            .smallNormal(AppColor.grey),
                                        Text(s.quantity.toString())
                                            .smallBold(AppColor.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (s != _stockForPart(part.id).last)
                            Divider(
                              height: Measurement.generalSize24,
                              color:
                                  AppColor.greyPercentCircle.withOpacity(0.2),
                            ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<WarehouseStockDisplayModel> _stockForPart(String partId) {
    final fromWarehouse =
        mockWarehouseStocks.where((s) => s.partId == partId).toList();
    if (fromWarehouse.isNotEmpty) return fromWarehouse;
    // Fallback to existing embedded stock if no warehouse data present
    // Create compatible display models for rendering
    return [];
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Measurement.generalSize16.horizontalIsToVertical,
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: child,
    );
  }
}

class _KV extends StatelessWidget {
  final String k;
  final String v;
  const _KV({required this.k, required this.v});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Measurement.generalSize14,
      ),
      child: Row(
        children: [
          Expanded(child: Text(k).smallNormal(AppColor.grey)),
          Text(v).mediumBold(AppColor.white),
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
