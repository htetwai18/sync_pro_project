import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_stock_display_model.dart';

class WarehouseDetailScreen extends StatefulWidget {
  final WarehouseDisplayModel warehouse;
  const WarehouseDetailScreen({super.key, required this.warehouse});

  @override
  State<WarehouseDetailScreen> createState() => _WarehouseDetailScreenState();
}

class _WarehouseDetailScreenState extends State<WarehouseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final stocks = mockWarehouseStocks
        .where((s) => s.warehouseId == widget.warehouse.id)
        .toList();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: widget.warehouse.name, context: context),
      body: Padding(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            Measurement.generalSize16.height,
            const Text('Inventory Stock').mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Expanded(
              child: ListView.separated(
                itemCount: stocks.length,
                separatorBuilder: (_, __) => Measurement.generalSize8.height,
                itemBuilder: (_, i) => _StockTile(
                  stock: stocks[i],
                  onAdjust: () => _openAdjustDialog(stocks[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    final w = widget.warehouse;
    return Container(
      padding: Measurement.generalSize16.horizontalIsToVertical,
      decoration: BoxDecoration(
        color: AppColor.blueCard,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(w.name).mediumBold(AppColor.white),
          Measurement.generalSize4.height,
          Text(w.code).smallNormal(AppColor.grey),
          if (w.location != null) ...[
            Measurement.generalSize8.height,
            Text(w.location!).smallNormal(AppColor.grey),
          ],
        ],
      ),
    );
  }

  Future<void> _openAdjustDialog(WarehouseStockDisplayModel stock) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.background,
        shape: RoundedRectangleBorder(
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        title: const Text(AppString.adjustStock).mediumBold(AppColor.white),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppString.adjustStock).mediumBold(AppColor.white),
              Measurement.generalSize8.height,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Measurement.generalSize16.horizontalIsToVertical,
                  ),
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    if (n == null)
                      return 'Enter a number (negative to decrease)';
                    if (stock.quantity + n < 0) return 'Insufficient stock';
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppString.cancelAction),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueStatusInner,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, int.parse(controller.text.trim()));
              }
            },
            child: const Text(AppString.saveAdjustment),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        final idx = mockWarehouseStocks.indexWhere((s) =>
            s.warehouseId == stock.warehouseId && s.partId == stock.partId);
        if (idx != -1) {
          final current = mockWarehouseStocks[idx];
          mockWarehouseStocks[idx] =
              current.copyWith(quantity: current.quantity + result);
        }
      });
    }
  }
}

class _StockTile extends StatelessWidget {
  final WarehouseStockDisplayModel stock;
  final VoidCallback onAdjust;
  const _StockTile({required this.stock, required this.onAdjust});

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
                Text(stock.partName).mediumBold(AppColor.white),
                Measurement.generalSize4.height,
                Text('${AppString.quantity}: ${stock.quantity}')
                    .smallNormal(AppColor.grey),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onAdjust,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueStatusInner,
              foregroundColor: AppColor.white,
              padding: Measurement.generalSize8.horizontalIsToVertical,
              shape: RoundedRectangleBorder(
                borderRadius: Measurement.generalSize8.allRadius,
              ),
              elevation: 0,
            ),
            child: const Text(AppString.adjust).smallBold(AppColor.white),
          ),
        ],
      ),
    );
  }
}
