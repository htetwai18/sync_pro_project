import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class NewBuildingRequestScreen extends StatefulWidget {
  const NewBuildingRequestScreen({super.key});

  @override
  State<NewBuildingRequestScreen> createState() =>
      _NewBuildingRequestScreenState();
}

class _NewBuildingRequestScreenState extends State<NewBuildingRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _buildingNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedBuildingType;

  final List<String> _buildingTypes = [
    'Office Building',
    'Warehouse',
    'Data Center',
    'Retail Space',
    'Manufacturing Facility',
    'Healthcare Facility',
    'Educational Institution',
    'Residential Complex',
    'Other'
  ];

  @override
  void dispose() {
    _buildingNameController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.newBuildingRequest,
        context: context,
        canBack: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: Measurement.generalSize16.horizontalIsToVertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Building Name Field
              _FieldBlock(
                label: AppString.buildingName,
                child: TextFormField(
                  controller: _buildingNameController,
                  decoration: _decoration(hint: AppString.enterBuildingName),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterBuildingName
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              Measurement.generalSize20.height,
              // Address Field
              _FieldBlock(
                label: AppString.addressLabel,
                child: TextFormField(
                  controller: _addressController,
                  decoration: _decoration(hint: AppString.enterBuildingAddress),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterBuildingAddress
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Building Type Dropdown
              Text(AppString.buildingType).mediumBold(AppColor.white),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedBuildingType,
                hint: AppString.selectBuildingType,
                items: _buildingTypes,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBuildingType = newValue;
                  });
                },
              ),
              Measurement.generalSize20.height,

              // Notes Field
              _FieldBlock(
                label: AppString.notes,
                child: TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: _decoration(hint: AppString.addSpecificNotes),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                ),
              ),
              Measurement.generalSize24.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Measurement.generalSize16.allPadding,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitRequest,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueStatusInner,
              foregroundColor: AppColor.white,
              padding: Measurement.generalSize16.verticalPadding,
              shape: RoundedRectangleBorder(
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              elevation: 0,
            ),
            child:
                const Text(AppString.submitRequest).mediumBold(AppColor.white),
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppString.buildingRequestSubmittedSuccessfully)
              .mediumNormal(AppColor.white),
          backgroundColor: AppColor.greenStatusInner,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: Measurement.generalSize8.allRadius,
          ),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  InputDecoration _decoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          Measurement.mediumFont.textStyle(AppColor.grey, Measurement.font400),
      border: InputBorder.none,
      contentPadding: Measurement.generalSize16.horizontalIsToVertical,
    );
  }
}

class _FieldBlock extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldBlock({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).mediumBold(AppColor.white),
        Measurement.generalSize8.height,
        Container(
          decoration: BoxDecoration(
            color: AppColor.blueField,
            borderRadius: Measurement.generalSize12.allRadius,
          ),
          child: child,
        ),
      ],
    );
  }
}

class _FieldContainer extends StatelessWidget {
  final Widget child;

  const _FieldContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: child,
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const _DropdownField({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _FieldContainer(
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: Measurement.generalSize16.horizontalIsToVertical,
        ),
        dropdownColor: AppColor.blueField,
        iconEnabledColor: AppColor.grey,
        style: Measurement.mediumFont
            .textStyle(AppColor.white, Measurement.font400),
        hint: Text(hint).mediumNormal(AppColor.grey),
        items: items
            .map((e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text('$e').mediumNormal(AppColor.white),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
