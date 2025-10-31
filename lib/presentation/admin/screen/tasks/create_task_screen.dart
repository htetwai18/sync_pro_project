import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _dueDate;

  // Service-backed cascading dropdowns
  List<CustomerModel> _customers = [];
  List<BuildingModel> _buildings = [];
  List<AssetModel> _assets = [];
  List<UserModel> _engineerUsers = [];

  String? _selectedCustomer; // id
  String? _selectedBuilding; // id
  String? _selectedAsset; // id
  String? _selectedEngineer; // id
  String? _selectedPriority;
  final List<String> _priorities = const ['low', 'medium', 'high'];
  String? _selectedType;
  final List<String> _taskTypes = const [
    'repair',
    'maintenance',
    'installation',
    'inspection',
    'emergency',
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomers();
    _loadEngineers();
  }

  Future<void> _loadCustomers() async {
    final list = await MockApiService.instance.listCustomers();
    setState(() {
      _customers = list;
      _selectedCustomer = _customers.isNotEmpty ? _customers.first.id : null;
    });
    if (_selectedCustomer != null) await _loadBuildings(_selectedCustomer!);
  }

  Future<void> _loadBuildings(String customerId) async {
    final list = await MockApiService.instance.listBuildings(customerId);
    setState(() {
      _buildings = list;
      _selectedBuilding = _buildings.isNotEmpty ? _buildings.first.id : null;
    });
    if (_selectedBuilding != null) await _loadAssets(_selectedBuilding!);
  }

  Future<void> _loadAssets(String buildingId) async {
    final list = await MockApiService.instance.listAssets(buildingId);
    setState(() {
      _assets = list;
      _selectedAsset = _assets.isNotEmpty ? _assets.first.id : null;
    });
  }

  Future<void> _loadEngineers() async {
    final list = await MockApiService.instance.listUsers(role: 'engineer');
    setState(() {
      _engineerUsers = list;
      _selectedEngineer =
          _engineerUsers.isNotEmpty ? _engineerUsers.first.id : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.createNewTask, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.taskTitle).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _FieldContainer(
              child: TextField(
                controller: _titleController,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppString.titlePlaceholder,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),

            Measurement.generalSize16.height,
            const Text(AppString.description).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _FieldContainer(
              child: TextField(
                controller: _descController,
                minLines: 4,
                maxLines: 6,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppString.descriptionPlaceholder,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),

            Measurement.generalSize24.height,
            // Customer -> Building -> Room -> Asset
            const Text(AppString.customerLower).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _DropdownField<String>(
              value: _selectedCustomer,
              hint: AppString.selectCustomer,
              items: _customers.map((c) => c.id).toList(),
              onChanged: (val) async {
                setState(() {
                  _selectedCustomer = val;
                  _selectedBuilding = null;
                  _selectedAsset = null;
                });
                if (val != null) await _loadBuildings(val);
              },
            ),

            if (_selectedCustomer != null) ...[
              Measurement.generalSize16.height,
              const Text(AppString.building).mediumBold(AppColor.grey),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedBuilding,
                hint: AppString.selectBuilding,
                items: _buildings.map((b) => b.id).toList(),
                onChanged: (val) async {
                  setState(() {
                    _selectedBuilding = val;
                    _selectedAsset = null;
                  });
                  if (val != null) await _loadAssets(val);
                },
              ),
            ],

            if (_selectedBuilding != null) ...[
              Measurement.generalSize16.height,
              const Text(AppString.asset).mediumBold(AppColor.grey),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedAsset,
                hint: AppString.selectAsset,
                items: _assets.map((a) => a.id).toList(),
                onChanged: (val) => setState(() => _selectedAsset = val),
              ),
            ],

            Measurement.generalSize24.height,
            const Text(AppString.assignedEngineer).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _DropdownField<String>(
              value: _selectedEngineer,
              hint: AppString.selectEngineer,
              items: _engineerUsers.map((u) => u.id).toList(),
              onChanged: (val) => setState(() => _selectedEngineer = val),
            ),

            Measurement.generalSize24.height,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppString.dueDate).mediumBold(AppColor.grey),
                      Measurement.generalSize8.height,
                      _FieldContainer(
                        child: InkWell(
                          onTap: () async {
                            final now = DateTime.now();
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _dueDate ?? now,
                              firstDate: DateTime(now.year - 1),
                              lastDate: DateTime(now.year + 3),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.dark(),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() => _dueDate = picked);
                            }
                          },
                          child: Padding(
                            padding: Measurement
                                .generalSize16.horizontalIsToVertical,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _dueDate == null
                                        ? 'mm/dd/yyyy'
                                        : '${_dueDate!.month.toString().padLeft(2, '0')}/${_dueDate!.day.toString().padLeft(2, '0')}/${_dueDate!.year}',
                                  ).mediumNormal(AppColor.white),
                                ),
                                const Icon(Icons.calendar_today,
                                    color: AppColor.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Measurement.generalSize16.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppString.priority).mediumBold(AppColor.grey),
                      Measurement.generalSize8.height,
                      _DropdownField<String>(
                        value: _selectedPriority,
                        hint: AppString.selectPriority,
                        items: _priorities,
                        onChanged: (val) =>
                            setState(() => _selectedPriority = val),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Measurement.generalSize24.height,
            Text('Task Type').mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _DropdownField<String>(
              value: _selectedType,
              hint: 'Select task type',
              items: _taskTypes,
              onChanged: (val) => setState(() => _selectedType = val),
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
                  // Minimal payload using seeds
                  if (_titleController.text.trim().isEmpty ||
                      _descController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter title and description.')),
                    );
                    return;
                  }
                  if (_selectedCustomer == null ||
                      _selectedBuilding == null ||
                      _selectedAsset == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Please select customer, building, and asset.')),
                    );
                    return;
                  }
                  await MockApiService.instance.createTask(
                    customerId: _selectedCustomer!,
                    buildingId: _selectedBuilding!,
                    assetId: _selectedAsset!,
                    title: _titleController.text.trim(),
                    description: _descController.text.trim(),
                    type: (_selectedType ?? 'repair'),
                    priority: (_selectedPriority ?? 'medium').toLowerCase(),
                    requestDate: DateTime.now(),
                    assignedToId: _selectedEngineer,
                    scheduledDate: _dueDate,
                  );
                  if (!mounted) return;
                  Navigator.pop(context, true);
                },
                child:
                    const Text(AppString.createTask).mediumBold(AppColor.white),
              ),
            ),
          ],
        ),
      ),
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
