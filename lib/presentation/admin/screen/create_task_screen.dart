import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _dueDate;

  // Mock data for cascading dropdowns
  final List<String> _customers = const [
    'Tech Solutions Inc.',
    'DataStream Corp.',
  ];
  final Map<String, List<String>> _customerToBuildings = const {
    'Tech Solutions Inc.': ['HQ', 'West Campus'],
    'DataStream Corp.': ['Main Office'],
  };
  final Map<String, List<String>> _buildingToRooms = const {
    'HQ': ['1402', '1403'],
    'West Campus': ['B12', 'B13'],
    'Main Office': ['201', '202'],
  };
  final Map<String, List<String>> _roomToAssets = const {
    '1402': ['HVAC Unit', 'Router'],
    '1403': ['Switch'],
    'B12': ['Projector'],
    'B13': ['Printer'],
    '201': ['Server Rack'],
    '202': ['UPS'],
  };

  String? _selectedCustomer;
  String? _selectedBuilding;
  String? _selectedRoom;
  String? _selectedAsset;
  String? _selectedEngineer;
  String? _selectedPriority;

  final List<String> _engineers = const [
    'Alex Johnson',
    'Maria Garcia',
    'Emily White',
  ];
  final List<String> _priorities = const ['Low', 'Medium', 'High'];

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
              items: _customers,
              onChanged: (val) {
                setState(() {
                  _selectedCustomer = val;
                  _selectedBuilding = null;
                  _selectedRoom = null;
                  _selectedAsset = null;
                });
              },
            ),

            if (_selectedCustomer != null) ...[
              Measurement.generalSize16.height,
              const Text(AppString.building).mediumBold(AppColor.grey),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedBuilding,
                hint: AppString.selectBuilding,
                items: _customerToBuildings[_selectedCustomer] ?? const [],
                onChanged: (val) {
                  setState(() {
                    _selectedBuilding = val;
                    _selectedRoom = null;
                    _selectedAsset = null;
                  });
                },
              ),
            ],

            if (_selectedBuilding != null) ...[
              Measurement.generalSize16.height,
              const Text(AppString.room).mediumBold(AppColor.grey),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedRoom,
                hint: AppString.selectRoom,
                items: _buildingToRooms[_selectedBuilding] ?? const [],
                onChanged: (val) {
                  setState(() {
                    _selectedRoom = val;
                    _selectedAsset = null;
                  });
                },
              ),
            ],

            if (_selectedRoom != null) ...[
              Measurement.generalSize16.height,
              const Text(AppString.asset).mediumBold(AppColor.grey),
              Measurement.generalSize8.height,
              _DropdownField<String>(
                value: _selectedAsset,
                hint: AppString.selectAsset,
                items: _roomToAssets[_selectedRoom] ?? const [],
                onChanged: (val) => setState(() => _selectedAsset = val),
              ),
            ],

            Measurement.generalSize24.height,
            const Text(AppString.assignedEngineer).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _DropdownField<String>(
              value: _selectedEngineer,
              hint: AppString.selectEngineer,
              items: _engineers,
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
