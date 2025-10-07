import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class AdjustStockScreen extends StatefulWidget {
  final String partName;
  final String partNumber;
  final int currentQty;
  const AdjustStockScreen(
      {super.key,
      required this.partName,
      required this.partNumber,
      required this.currentQty});

  @override
  State<AdjustStockScreen> createState() => _AdjustStockScreenState();
}

class _AdjustStockScreenState extends State<AdjustStockScreen> {
  String? _location = 'Warehouse A';
  final TextEditingController _newQtyController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _newQtyController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Text('${AppString.currentQuantity}: ${widget.currentQty}')
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
                value: _location,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                items: [
                  DropdownMenuItem(
                    value: 'Warehouse A',
                    child:
                        const Text('Warehouse A').mediumNormal(AppColor.grey),
                  ),
                  DropdownMenuItem(
                    value: 'Engineer Van 5',
                    child: const Text('Engineer Van 5')
                        .mediumNormal(AppColor.grey),
                  ),
                ],
                onChanged: (v) => setState(() => _location = v),
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
                onPressed: () {},
                child: const Text(AppString.saveAdjustment)
                    .mediumBold(AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
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
