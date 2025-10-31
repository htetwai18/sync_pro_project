import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class CreateEditWarehouseScreen extends StatefulWidget {
  final InventoryModel? warehouse;
  const CreateEditWarehouseScreen({super.key, this.warehouse});

  @override
  State<CreateEditWarehouseScreen> createState() =>
      _CreateEditWarehouseScreenState();
}

class _CreateEditWarehouseScreenState extends State<CreateEditWarehouseScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _code;
  late final TextEditingController _location;
  late final TextEditingController _contactName;
  late final TextEditingController _contactPhone;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    final w = widget.warehouse;
    _name = TextEditingController(text: w?.name ?? '');
    _code = TextEditingController(text: w?.code ?? '');
    _location = TextEditingController(text: '');
    _contactName = TextEditingController(text: w?.contactName ?? '');
    _contactPhone = TextEditingController(text: w?.contactPhone ?? '');
    _isActive = w?.isActive ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _code.dispose();
    _location.dispose();
    _contactName.dispose();
    _contactPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.warehouse != null;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
          title: isEdit ? 'Edit Warehouse' : 'Add Warehouse', context: context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: Measurement.generalSize16.horizontalIsToVertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('Name'),
              _field(TextFormField(
                decoration: InputDecoration(
                    hintText: AppString.hintWarehouseName,
                    hintStyle: Measurement.mediumFont
                        .textStyle(AppColor.grey, Measurement.font400),
                    contentPadding: Measurement.generalSize8.horizontalPadding),
                style: TextStyle(color: AppColor.white),
                controller: _name,
                validator: (v) =>
                    (v == null || v.isEmpty) ? AppString.pleaseEnterName : null,
              )),
              Measurement.generalSize16.height,
              _label('Code'),
              _field(TextFormField(
                decoration: InputDecoration(
                    hintText: AppString.hintWarehouseCode,
                    hintStyle: Measurement.mediumFont
                        .textStyle(AppColor.grey, Measurement.font400),
                    contentPadding: Measurement.generalSize8.horizontalPadding),
                style: TextStyle(color: AppColor.white),
                controller: _code,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Please enter code' : null,
              )),
              Measurement.generalSize16.height,
              _label('Location (optional)'),
              _field(TextFormField(
                decoration: InputDecoration(
                    hintText: AppString.hintWarehouseLocation,
                    hintStyle: Measurement.mediumFont
                        .textStyle(AppColor.grey, Measurement.font400),
                    contentPadding: Measurement.generalSize8.horizontalPadding),
                style: TextStyle(color: AppColor.white),
                controller: _location,
              )),
              Measurement.generalSize16.height,
              _label('Contact Name (optional)'),
              _field(TextFormField(
                  decoration: InputDecoration(
                      hintText: AppString.hintContactNameOptional,
                      hintStyle: Measurement.mediumFont
                          .textStyle(AppColor.grey, Measurement.font400),
                      contentPadding:
                          Measurement.generalSize8.horizontalPadding),
                  style: TextStyle(color: AppColor.white),
                  controller: _contactName)),
              Measurement.generalSize16.height,
              _label('Contact Phone (optional)'),
              _field(TextFormField(
                  decoration: InputDecoration(
                      hintText: AppString.hintContactPhoneOptional,
                      hintStyle: Measurement.mediumFont
                          .textStyle(AppColor.grey, Measurement.font400),
                      contentPadding:
                          Measurement.generalSize8.horizontalPadding),
                  style: TextStyle(color: AppColor.white),
                  controller: _contactPhone,
                  keyboardType: TextInputType.phone)),
              Measurement.generalSize16.height,
              Row(
                children: [
                  Switch(
                    value: _isActive,
                    onChanged: (v) => setState(() => _isActive = v),
                    activeColor: AppColor.blueStatusInner,
                  ),
                  const Text('Active').mediumBold(AppColor.white),
                ],
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
                  onPressed: _save,
                  child: Text(isEdit
                          ? AppString.saveChangesAction
                          : 'Add Warehouse')
                      .mediumBold(AppColor.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text).mediumBold(AppColor.white);

  Widget _field(Widget child) => Container(
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: child,
      );

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final isEdit = widget.warehouse != null;
    if (isEdit) {
      await MockApiService.instance.updateInventory(
        id: widget.warehouse!.id,
        name: _name.text.trim(),
        code: _code.text.trim(),
        contactName:
            _contactName.text.trim().isEmpty ? null : _contactName.text.trim(),
        contactPhone: _contactPhone.text.trim().isEmpty
            ? null
            : _contactPhone.text.trim(),
        isActive: _isActive,
      );
    } else {
      await MockApiService.instance.createInventory(
        name: _name.text.trim(),
        code: _code.text.trim(),
        contactName:
            _contactName.text.trim().isEmpty ? null : _contactName.text.trim(),
        contactPhone: _contactPhone.text.trim().isEmpty
            ? null
            : _contactPhone.text.trim(),
        isActive: _isActive,
      );
    }
    if (!mounted) return;
    Navigator.pop(context, true);
  }
}
