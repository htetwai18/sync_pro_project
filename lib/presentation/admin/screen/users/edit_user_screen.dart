import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class EditUserScreen extends StatefulWidget {
  final UserModel user;
  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  String _role = 'engineer';
  String _status = AppString.active;
  String? _department;
  String? _specialization;
  DateTime? _hireDate;

  final List<String> _roles = const ['admin', 'engineer'];
  final List<String> _departments = const [
    'Admin',
    'HVAC',
    'Electrical',
    'Plumbing',
    'Field Ops'
  ];
  final List<String> _specializations = const [
    'HVAC',
    'Electrical',
    'Plumbing',
    'General'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _role = widget.user.role;
    _status = 'Active';
    _department = widget.user.department;
    _specialization = widget.user.specialization;
    if (widget.user.hireDate != null && widget.user.hireDate!.isNotEmpty) {
      _hireDate = DateTime.tryParse(widget.user.hireDate!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.editUser, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.fullName).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _nameController,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  hintText: _nameController.text.isEmpty
                      ? AppString.hintFullName
                      : null,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.emailAddress).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  hintText: _emailController.text.isEmpty
                      ? AppString.hintEmail
                      : null,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.role).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                items: _roles
                    .map((r) => DropdownMenuItem<String>(
                          value: r,
                          child: Text(r),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _role = val ?? _role),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.phone).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  hintText:
                      _phoneController.text.isEmpty ? 'Enter phone' : null,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.department).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<String>(
                value: _department,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                hint:
                    const Text('Select department').mediumNormal(AppColor.grey),
                items: _departments
                    .map((d) => DropdownMenuItem<String>(
                          value: d,
                          child: Text(d),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _department = val),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.hireDate).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _hireDate ?? now,
                    firstDate: DateTime(now.year - 10),
                    lastDate: DateTime(now.year + 1),
                    builder: (context, child) => Theme(
                      data: ThemeData.dark(),
                      child: child!,
                    ),
                  );
                  if (picked != null) setState(() => _hireDate = picked);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _hireDate == null
                              ? 'mm/dd/yyyy'
                              : '${_hireDate!.month.toString().padLeft(2, '0')}/${_hireDate!.day.toString().padLeft(2, '0')}/${_hireDate!.year}',
                        ).mediumNormal(AppColor.white),
                      ),
                      const Icon(Icons.calendar_today, color: AppColor.grey),
                    ],
                  ),
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.specialization).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<String>(
                value: _specialization,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                hint: const Text('Select specialization')
                    .mediumNormal(AppColor.grey),
                items: _specializations
                    .map((s) => DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _specialization = val),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.statusUpper).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Measurement.generalSize16,
                      vertical: Measurement.generalSize8),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                items: [
                  DropdownMenuItem(
                    value: AppString.active,
                    child: const Text(AppString.active)
                        .mediumNormal(AppColor.white),
                  ),
                  DropdownMenuItem(
                    value: AppString.inactive,
                    child: const Text(AppString.inactive)
                        .mediumNormal(AppColor.white),
                  ),
                ],
                onChanged: (val) => setState(() => _status = val ?? _status),
              ),
            ),
            Measurement.generalSize16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('${AppString.lastUpdatedText}: 2 days ago')
                    .smallNormal(AppColor.grey),
                Container(
                  padding: Measurement.generalSize8.horizontalIsToVertical,
                  decoration: BoxDecoration(
                    color: _status == AppString.active
                        ? AppColor.greenStatusInner
                        : AppColor.redStatusInner,
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Text(_status).smallBold(AppColor.white),
                ),
              ],
            ),
            Measurement.generalSize24.height,
            Row(
              children: [
                Expanded(
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
                    child:
                        const Text(AppString.cancel).mediumBold(AppColor.white),
                  ),
                ),
                Measurement.generalSize16.width,
                Expanded(
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
                      final name = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      final phone = _phoneController.text.trim();
                      await MockApiService.instance.updateUser(
                        id: widget.user.id,
                        name: name.isEmpty ? null : name,
                        email: email.isEmpty ? null : email,
                        phone: phone.isEmpty ? null : phone,
                        role: _role,
                        department: _department,
                        specialization: _specialization,
                        hireDate: _hireDate == null
                            ? null
                            : '${_hireDate!.year.toString().padLeft(4, '0')}-${_hireDate!.month.toString().padLeft(2, '0')}-${_hireDate!.day.toString().padLeft(2, '0')}',
                      );
                      if (!mounted) return;
                      Navigator.pop(context, true);
                    },
                    child: const Text(AppString.saveChanges)
                        .mediumBold(AppColor.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final Widget child;
  const _Field({required this.child});

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
