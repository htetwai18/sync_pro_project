import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class AddPartScreen extends StatefulWidget {
  const AddPartScreen({super.key});

  @override
  State<AddPartScreen> createState() => _AddPartScreenState();
}

class _AddPartScreenState extends State<AddPartScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String? _warehouse;

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _manufacturerController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.addNewPart, context: context),
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
            Measurement.generalSize16.height,
            const Text(AppString.quantity).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                hint: AppString.hintQuantity),
            Measurement.generalSize16.height,
            const Text(AppString.selectWarehouse).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: DropdownButtonFormField<String>(
                value: _warehouse,
                style: TextStyle(color: AppColor.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                hint: const Text(AppString.hintWarehouse)
                    .mediumNormal(AppColor.grey),
                items: const [
                  DropdownMenuItem(
                      value: 'Warehouse A', child: Text('Warehouse A')),
                  DropdownMenuItem(
                      value: 'Engineer Van 5', child: Text('Engineer Van 5')),
                ],
                onChanged: (v) => setState(() => _warehouse = v),
              ),
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
                child: const Text(AppString.addNewPart)
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Measurement.generalSize16,
              vertical: Measurement.generalSize14,
            ),
            hintText: controller.text.isEmpty ? hint : null,
            hintStyle: Measurement.generalSize14
                .textStyle(AppColor.grey, Measurement.font400)),
      ),
    );
  }
}
