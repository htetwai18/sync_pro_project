import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';

import 'package:sync_pro/presentation/admin/screen/parts/edit_part_screen.dart';
import 'package:sync_pro/presentation/admin/screen/parts/adjust_stock_screen.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class PartDetailScreen extends StatefulWidget {
  final PartModel part;
  const PartDetailScreen({super.key, required this.part});

  @override
  State<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends State<PartDetailScreen> {
  late PartModel _part;

  @override
  void initState() {
    super.initState();
    _part = widget.part;
  }

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
                        onPressed: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditPartScreen(part: _part),
                            ),
                          );
                          if (updated == true) {
                            await _reload();
                            if (!mounted) return;
                            // bubble up that something changed
                            // we'll pop(true) when user goes back
                          }
                        },
                        icon: const Icon(Icons.edit, color: AppColor.white),
                        label: const Text(AppString.editAction)
                            .smallBold(AppColor.white),
                      )
                    ],
                  ),
                  Measurement.generalSize8.height,
                  _KV(k: AppString.partName, v: _part.name),
                  _Divider(),
                  _KV(k: AppString.partNumber, v: _part.number),
                  _Divider(),
                  _KV(k: AppString.manufacturer, v: _part.manufacturer),
                  _Divider(),
                  _KV(
                      k: AppString.unitPrice,
                      v: '\$${_part.unitPrice.toStringAsFixed(2)}'),
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
                        onPressed: () async {
                          final changed = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdjustStockScreen(
                                partId: _part.id,
                                partName: _part.name,
                                partNumber: _part.number,
                              ),
                            ),
                          );
                          if (changed == true) {
                            await _reload();
                            if (!mounted) return;
                            // Let parent list refresh when this detail is popped
                          }
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
                  ..._stockForPart(_part).map((s) => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s.location.name)
                                        .mediumBold(AppColor.white),
                                    Measurement.generalSize8.height,
                                    Row(
                                      children: [
                                        const Text('Quantity: ')
                                            .smallNormal(AppColor.grey),
                                        Text(s.quantityOnHand.toString())
                                            .smallBold(AppColor.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (s != _stockForPart(_part).last)
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

  List<PartInventoryModel> _stockForPart(PartModel p) {
    return p.stockLevels ?? const [];
  }

  Future<void> _reload() async {
    final list = await MockApiService.instance.listParts();
    final latest =
        list.firstWhere((e) => e.id == _part.id, orElse: () => _part);
    setState(() {
      _part = latest;
    });
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
