import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/service_request_display_model.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  ServiceRequestType? _selectedServiceType;
  ServiceRequestPriority? _selectedPriority;
  String? _selectedBuilding;
  String? _selectedRoom;
  String? _selectedAsset;
  DateTime? _selectedPreferredDate;
  String? _selectedPreferredTime;

  final List<BuildingItemDisplayModel> _buildings = mockBuildings;
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contactPersonController.dispose();
    _contactPhoneController.dispose();
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
              _FieldBlock(
                label: AppString.serviceType,
                child: DropdownButtonFormField<ServiceRequestType>(
                  value: _selectedServiceType,
                  decoration: _decoration(hint: AppString.selectServiceType),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  dropdownColor: AppColor.blueField,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.grey,
                  ),
                  items:
                      ServiceRequestType.values.map((ServiceRequestType type) {
                    return DropdownMenuItem<ServiceRequestType>(
                      value: type,
                      child: Text(getServiceRequestTypeText(type))
                          .mediumNormal(AppColor.white),
                    );
                  }).toList(),
                  onChanged: (ServiceRequestType? newValue) {
                    setState(() {
                      _selectedServiceType = newValue;
                    });
                  },
                  validator: (v) =>
                      (v == null) ? AppString.pleaseSelectServiceType : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Priority Field
              _FieldBlock(
                label: AppString.priority,
                child: DropdownButtonFormField<ServiceRequestPriority>(
                  value: _selectedPriority,
                  decoration: _decoration(hint: AppString.selectPriority),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  dropdownColor: AppColor.blueField,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.grey,
                  ),
                  items: ServiceRequestPriority.values
                      .map((ServiceRequestPriority priority) {
                    return DropdownMenuItem<ServiceRequestPriority>(
                      value: priority,
                      child: Text(getServiceRequestPriorityText(priority))
                          .mediumNormal(AppColor.white),
                    );
                  }).toList(),
                  onChanged: (ServiceRequestPriority? newValue) {
                    setState(() {
                      _selectedPriority = newValue;
                    });
                  },
                  validator: (v) =>
                      (v == null) ? AppString.pleaseSelectPriority : null,
                ),
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
                      _selectedRoom = null;
                      _selectedAsset = null;
                    });
                  },
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseSelectBuilding
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Room Number Field (Optional)
              _FieldBlock(
                label: AppString.roomNumber,
                child: TextFormField(
                  controller: TextEditingController(text: _selectedRoom ?? ''),
                  decoration: _decoration(hint: AppString.addRoomNo),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  onChanged: (value) {
                    _selectedRoom = value;
                  },
                ),
              ),
              Measurement.generalSize20.height,

              // Asset Field (Optional)
              _FieldBlock(
                label: AppString.asset,
                child: TextFormField(
                  controller: TextEditingController(text: _selectedAsset ?? ''),
                  decoration: _decoration(hint: AppString.enterAssetName),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  onChanged: (value) {
                    _selectedAsset = value;
                  },
                ),
              ),
              Measurement.generalSize20.height,

              // Contact Person Field
              _FieldBlock(
                label: AppString.contactPerson,
                child: TextFormField(
                  controller: _contactPersonController,
                  decoration: _decoration(hint: AppString.enterContactPerson),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterContactPerson
                      : null,
                ),
              ),
              Measurement.generalSize20.height,

              // Contact Phone Field
              _FieldBlock(
                label: AppString.contactPhone,
                child: TextFormField(
                  controller: _contactPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _decoration(hint: AppString.enterContactPhone),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? AppString.pleaseEnterContactPhone
                      : null,
                ),
              ),
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
              _FieldBlock(
                label: AppString.preferredTime,
                child: DropdownButtonFormField<String>(
                  value: _selectedPreferredTime,
                  decoration: _decoration(hint: AppString.selectPreferredTime),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  dropdownColor: AppColor.blueField,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.grey,
                  ),
                  items: _timeSlots.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time).mediumNormal(AppColor.white),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPreferredTime = newValue;
                    });
                  },
                ),
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
