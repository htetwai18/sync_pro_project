import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';

class EditPartScreen extends StatefulWidget {
  final PartModel part;
  const EditPartScreen({super.key, required this.part});

  @override
  State<EditPartScreen> createState() => _EditPartScreenState();
}

class _EditPartScreenState extends State<EditPartScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  late final TextEditingController _manufacturerController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.part.name);
    _numberController = TextEditingController(text: widget.part.number);
    _manufacturerController =
        TextEditingController(text: widget.part.manufacturer);
    _priceController =
        TextEditingController(text: widget.part.unitPrice.toStringAsFixed(2));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _manufacturerController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.editPartDetails, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.partName).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(controller: _nameController, hint: AppString.hintPartName),
            Measurement.generalSize16.height,
            const Text(AppString.partNumber).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
                controller: _numberController, hint: AppString.hintPartNumber),
            Measurement.generalSize16.height,
            const Text(AppString.manufacturer).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
                controller: _manufacturerController,
                hint: AppString.hintManufacturer),
            Measurement.generalSize16.height,
            const Text(AppString.unitPrice).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
                controller: _priceController,
                keyboardType: TextInputType.number,
                hint: AppString.hintUnitPrice),
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
                child: const Text(AppString.saveChangesAction)
                    .mediumBold(AppColor.white),
              ),
            ),
            Measurement.generalSize16.height,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColor.greyPercentCircle),
                  foregroundColor: AppColor.white,
                  backgroundColor: AppColor.blueField,
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(AppString.cancelAction)
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
  const _Field({required this.controller, this.keyboardType, this.hint});

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
        style: Measurement.mediumFont
            .textStyle(AppColor.white, Measurement.font400),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Measurement.generalSize16,
            vertical: Measurement.generalSize14,
          ),
          hintText: controller.text.isEmpty ? hint : null,
        ),
      ),
    );
  }
}
