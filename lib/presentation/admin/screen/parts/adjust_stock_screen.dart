import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';

class AdjustStockScreen extends StatefulWidget {
  final String partId;
  final String partName;
  final String partNumber;
  const AdjustStockScreen(
      {super.key,
      required this.partId,
      required this.partName,
      required this.partNumber});

  @override
  State<AdjustStockScreen> createState() => _AdjustStockScreenState();
}

class _AdjustStockScreenState extends State<AdjustStockScreen> {
  String? _warehouseId;
  final TextEditingController _newQtyController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  PartModel? _part;
  List<InventoryModel> _inventories = [];
  int _currentQty = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _newQtyController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _part = _part ??
        PartModel(
          id: widget.partId,
          name: widget.partName,
          number: widget.partNumber,
          manufacturer: '',
          unitPrice: 0,
          stockLevels: const [],
        );
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.adjustStock, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Part').mediumBold(AppColor.white),
                Measurement.generalSize12.height,
                Text('${widget.partNumber} ${widget.partName}')
                    .mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                Text('${AppString.currentQuantity}: $_currentQty')
                    .smallNormal(AppColor.grey),
              ],
            ),
            Measurement.generalSize24.height,
            const Text(AppString.location).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: DropdownButtonFormField<String>(
                value: _warehouseId,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                items: _inventories
                    .map((inv) => DropdownMenuItem<String>(
                          value: inv.id,
                          child: Text(inv.name).mediumNormal(AppColor.grey),
                        ))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    _warehouseId = v;
                    _recomputeQty();
                  });
                },
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.newQuantity).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              controller: _newQtyController,
              keyboardType: TextInputType.number,
              hint: AppString.hintNewQuantity,
              maxLines: 1,
            ),
            Measurement.generalSize16.height,
            const Text(AppString.reasonForAdjustment)
                .mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              controller: _reasonController,
              hint: AppString.hintReason,
              maxLines: 5,
            ),
            Measurement.generalSize24.height,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueStatusInner,
                  foregroundColor: AppColor.white,
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                ),
                onPressed: () async {
                  final qty = int.tryParse(_newQtyController.text.trim());
                  if (_warehouseId == null || qty == null) return;
                  await MockApiService.instance.setPartInventoryQuantity(
                    partId: widget.partId,
                    inventoryId: _warehouseId!,
                    quantity: qty,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppString.saveAdjustment),
                    ),
                  );
                  Navigator.pop(context, true);
                },
                child: const Text(AppString.saveAdjustment)
                    .mediumBold(AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _load() async {
    final parts = await MockApiService.instance.listParts();
    final part = parts.firstWhere(
      (p) => p.id == widget.partId,
      orElse: () => PartModel(
        id: widget.partId,
        name: widget.partName,
        number: widget.partNumber,
        manufacturer: '',
        unitPrice: 0,
        stockLevels: const [],
      ),
    );
    final locations = (part.stockLevels ?? const <PartInventoryModel>[])
        .map((e) => e.location)
        .toList();
    setState(() {
      _part = part;
      _inventories = locations;
      _warehouseId ??= _inventories.isNotEmpty ? _inventories.first.id : null;
      _recomputeQty();
    });
  }

  void _recomputeQty() {
    final levels = _part?.stockLevels ?? const <PartInventoryModel>[];
    final found = levels.firstWhere(
      (s) => s.location.id == _warehouseId,
      orElse: () => PartInventoryModel(
        quantityOnHand: 0,
        part: _part ??
            PartModel(
                id: '', name: '', number: '', manufacturer: '', unitPrice: 0),
        location: _inventories.isNotEmpty
            ? _inventories.first
            : InventoryModel(
                id: '',
                name: '',
                code: '',
                isActive: true,
                createdAt: DateTime.now()),
      ),
    );
    _currentQty = found.quantityOnHand;
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hint;
  final int maxLines;
  const _Field(
      {required this.controller,
      this.keyboardType,
      this.hint,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: Measurement.mediumFont
            .textStyle(AppColor.white, Measurement.font400),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Measurement.generalSize16,
            vertical: Measurement.generalSize14,
          ),
          hintText: controller.text.isEmpty ? hint : null,
          hintStyle: Measurement.generalSize14
              .textStyle(AppColor.grey, Measurement.font400),
        ),
      ),
    );
  }
}
