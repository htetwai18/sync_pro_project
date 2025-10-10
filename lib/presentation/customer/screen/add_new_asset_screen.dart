import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';

class AddNewAssetScreen extends StatefulWidget {
  const AddNewAssetScreen({super.key});

  @override
  State<AddNewAssetScreen> createState() => _AddNewAssetScreenState();
}

class _AddNewAssetScreenState extends State<AddNewAssetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _assetNameController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _modelController = TextEditingController();
  final _roomNumberController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedBuilding;
  DateTime? _selectedInstallationDate;

  final List<BuildingItemDisplayModel> _buildings = mockBuildings;

  @override
  void dispose() {
    _assetNameController.dispose();
    _manufacturerController.dispose();
    _modelController.dispose();
    _roomNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.addNewAsset,
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
              // Asset Name Field
              _FieldBlock(
                label: AppString.assetNameLabel,
                child: TextFormField(
                  controller: _assetNameController,
                  decoration: _decoration(hint: AppString.enterAssetName),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterAssetName
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Manufacturer Field
              _FieldBlock(
                label: AppString.manufacturerLabel,
                child: TextFormField(
                  controller: _manufacturerController,
                  decoration: _decoration(hint: AppString.enterManufacturer),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterManufacturer
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Model Field
              _FieldBlock(
                label: AppString.modelLabel,
                child: TextFormField(
                  controller: _modelController,
                  decoration: _decoration(hint: AppString.enterModel),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterModel
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Room Number Field (Optional)
              _FieldBlock(
                label: AppString.roomNumber,
                child: TextFormField(
                  controller: _roomNumberController,
                  decoration: _decoration(hint: AppString.addRoomNo),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                ),
              ),
              Measurement.generalSize20.height,

              // Building Selection Dropdown
              _FieldBlock(
                label: AppString.building,
                child: DropdownButtonFormField<String>(
                  value: _selectedBuilding,
                  decoration: _decoration(hint: AppString.selectBuilding),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  dropdownColor: AppColor.blueField,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.grey,
                  ),
                  items: _buildings.map((BuildingItemDisplayModel building) {
                    return DropdownMenuItem<String>(
                      value: building.id,
                      child: Text(building.name).mediumNormal(AppColor.white),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBuilding = newValue;
                    });
                  },
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseSelectBuilding
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Installation Date Field (Optional)
              _FieldBlock(
                label: AppString.installationDateLabel,
                child: InkWell(
                  onTap: _selectInstallationDate,
                  child: Container(
                    padding: Measurement.generalSize16.horizontalIsToVertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedInstallationDate != null
                                ? '${_selectedInstallationDate!.day}/${_selectedInstallationDate!.month}/${_selectedInstallationDate!.year}'
                                : AppString.selectInstallationDate,
                            style: Measurement.mediumFont.textStyle(
                              _selectedInstallationDate != null
                                  ? AppColor.white
                                  : AppColor.grey,
                              Measurement.font400,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: AppColor.grey,
                          size: Measurement.generalSize20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Measurement.generalSize20.height,

              // Notes Field (Optional)
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
            onPressed: _addAsset,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueStatusInner,
              foregroundColor: AppColor.white,
              padding: Measurement.generalSize16.verticalPadding,
              shape: RoundedRectangleBorder(
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              elevation: 0,
            ),
            child: const Text(AppString.addAsset).mediumBold(AppColor.white),
          ),
        ),
      ),
    );
  }

  Future<void> _selectInstallationDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedInstallationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.blueStatusInner,
              onPrimary: AppColor.white,
              surface: AppColor.blueField,
              onSurface: AppColor.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedInstallationDate) {
      setState(() {
        _selectedInstallationDate = picked;
      });
    }
  }

  void _addAsset() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual asset creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppString.assetAddedSuccessfully)
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
