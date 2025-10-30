import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';
import 'package:sync_pro/presentation/shared/mock.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  String? _selectedServiceType;
  String? _selectedPriority;
  String? _selectedBuilding;
  String? _selectedAsset;
  DateTime? _selectedPreferredDate;
  String? _selectedPreferredTime;

  final List<BuildingModel> _buildings = mockBuildings;
  final List<AssetModel> _assets = mockAssets;
  final List<String> _serviceTypes = const [
    'maintenance',
    'repair',
    'installation',
    'inspection',
    'emergency',
    'other'
  ];
  final List<String> _priorities = const ['low', 'medium', 'high', 'urgent'];
  final List<String> _timeSlots = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  // Get assets for selected building
  List<AssetModel> get _selectedBuildingAssets {
    if (_selectedBuilding == null) return [];
    return _assets
        .where((asset) => asset.building.id == _selectedBuilding)
        .toList();
  }

  String _getDisplayText<T>(T item) {
    if (item is String) {
      // For building IDs, get the building name
      if (item.startsWith('B')) {
        try {
          final building = _buildings.firstWhere((b) => b.id == item);
          return building.name;
        } catch (e) {
          return item;
        }
      }
      // For asset IDs, get the asset name
      if (item.startsWith('A')) {
        try {
          final asset = _assets.firstWhere((a) => a.id == item);
          return asset.name;
        } catch (e) {
          return item;
        }
      }
      return item;
    }
    return item.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.requestNewService,
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
              // Service Type Field
              Text(AppString.serviceType).mediumBold(AppColor.white),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedServiceType,
                hint: AppString.selectServiceType,
                items: _serviceTypes,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedServiceType = newValue;
                  });
                },
              ),
              Measurement.generalSize20.height,

              // Priority Field
              Text(AppString.priority).mediumBold(AppColor.white),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedPriority,
                hint: AppString.selectPriority,
                items: _priorities,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPriority = newValue;
                  });
                },
              ),
              Measurement.generalSize20.height,

              // Title Field
              _FieldBlock(
                label: AppString.taskTitle,
                child: TextFormField(
                  controller: _titleController,
                  decoration: _decoration(hint: AppString.titlePlaceholder),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterAssetName
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Description Field
              _FieldBlock(
                label: AppString.serviceDescription,
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration:
                      _decoration(hint: AppString.enterServiceDescription),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterServiceDescription
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Building Selection
              Text(AppString.building).mediumBold(AppColor.white),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedBuilding,
                hint: AppString.selectBuilding,
                items: _buildings.map((building) => building.id).toList(),
                displayText: (item) => _getDisplayText(item),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBuilding = newValue;
                    _selectedAsset = null;
                  });
                },
              ),
              Measurement.generalSize20.height,

              Measurement.generalSize20.height,

              // Asset Field (Optional) - Only show when building is selected
              if (_selectedBuilding != null) ...[
                Text(AppString.asset).mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                _DropdownField<String>(
                  value: _selectedAsset,
                  hint: AppString.selectAsset,
                  items:
                      _selectedBuildingAssets.map((asset) => asset.id).toList(),
                  displayText: (item) => _getDisplayText(item),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAsset = newValue;
                    });
                  },
                ),
                Measurement.generalSize20.height,
              ],
              Measurement.generalSize20.height,

              // Preferred Date Field
              _FieldBlock(
                label: AppString.preferredDate,
                child: InkWell(
                  onTap: _selectPreferredDate,
                  child: Container(
                    padding: Measurement.generalSize16.horizontalIsToVertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedPreferredDate != null
                                ? '${_selectedPreferredDate!.day}/${_selectedPreferredDate!.month}/${_selectedPreferredDate!.year}'
                                : AppString.selectPreferredDate,
                            style: Measurement.mediumFont.textStyle(
                              _selectedPreferredDate != null
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

              // Preferred Time Field
              Text(AppString.preferredTime).mediumBold(AppColor.white),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedPreferredTime,
                hint: AppString.selectPreferredTime,
                items: _timeSlots,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPreferredTime = newValue;
                  });
                },
              ),
              Measurement.generalSize20.height,

              // Special Instructions Field (Optional)
              _FieldBlock(
                label: AppString.specialInstructions,
                child: TextFormField(
                  controller: _specialInstructionsController,
                  maxLines: 3,
                  decoration:
                      _decoration(hint: AppString.enterSpecialInstructions),
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
            onPressed: _submitServiceRequest,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueStatusInner,
              foregroundColor: AppColor.white,
              padding: Measurement.generalSize16.verticalPadding,
              shape: RoundedRectangleBorder(
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              elevation: 0,
            ),
            child: const Text(AppString.submitServiceRequest)
                .mediumBold(AppColor.white),
          ),
        ),
      ),
    );
  }

  Future<void> _selectPreferredDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedPreferredDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
    if (picked != null && picked != _selectedPreferredDate) {
      setState(() {
        _selectedPreferredDate = picked;
      });
    }
  }

  void _submitServiceRequest() {
    if (_formKey.currentState!.validate()) {
      // Validate required fields
      if (_selectedServiceType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppString.pleaseSelectServiceType)
                .mediumNormal(AppColor.white),
            backgroundColor: AppColor.redStatusInner,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: Measurement.generalSize8.allRadius,
            ),
          ),
        );
        return;
      }

      if (_selectedPriority == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppString.pleaseSelectPriority)
                .mediumNormal(AppColor.white),
            backgroundColor: AppColor.redStatusInner,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: Measurement.generalSize8.allRadius,
            ),
          ),
        );
        return;
      }

      // TODO: Implement actual service request submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppString.serviceRequestSubmitted)
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
  final String Function(T)? displayText;

  const _DropdownField({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.displayText,
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
                  child: Text(displayText?.call(e) ?? e.toString())
                      .mediumNormal(AppColor.white),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
