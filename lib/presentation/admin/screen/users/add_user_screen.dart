import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _selectedRole;
  final List<String> _roles = const ['admin', 'engineer'];
  String? _selectedDepartment;
  final List<String> _departments = const [
    'Admin',
    'HVAC',
    'Electrical',
    'Plumbing',
    'Field Ops'
  ];
  String? _selectedSpecialization;
  final List<String> _specializations = const [
    'HVAC',
    'Electrical',
    'Plumbing',
    'General'
  ];
  DateTime? _hireDate;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.addNewUser, context: context),
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
                  hintText: AppString.enterFullName,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
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
                  hintText: AppString.enterEmailAddress,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
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
                  hintText: 'Enter phone',
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.role).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                hint: const Text(AppString.selectRole)
                    .mediumNormal(AppColor.grey),
                items: _roles
                    .map((r) => DropdownMenuItem<String>(
                          value: r,
                          child: Text(r).mediumNormal(AppColor.white),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.department).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: DropdownButtonFormField<String>(
                value: _selectedDepartment,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
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
                          child: Text(d).mediumNormal(AppColor.white),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedDepartment = val),
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
                  padding: Measurement.generalSize16.horizontalIsToVertical,
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
                value: _selectedSpecialization,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
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
                          child: Text(s).mediumNormal(AppColor.white),
                        ))
                    .toList(),
                onChanged: (val) =>
                    setState(() => _selectedSpecialization = val),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.password).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.enterPassword,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.confirmPassword).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            _Field(
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.confirmNewPassword,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  border: InputBorder.none,
                  contentPadding:
                      Measurement.generalSize16.horizontalIsToVertical,
                ),
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
                onPressed: () async {
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final role = _selectedRole;
                  if (name.isEmpty || email.isEmpty || role == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill name, email and role'),
                      ),
                    );
                    return;
                  }
                  await MockApiService.instance.createUser(
                    name: name,
                    email: email,
                    phone: _phoneController.text.trim().isEmpty
                        ? null
                        : _phoneController.text.trim(),
                    role: role,
                    department: _selectedDepartment,
                    specialization: _selectedSpecialization,
                    hireDate: _hireDate == null
                        ? null
                        : '${_hireDate!.year.toString().padLeft(4, '0')}-${_hireDate!.month.toString().padLeft(2, '0')}-${_hireDate!.day.toString().padLeft(2, '0')}',
                  );
                  if (!mounted) return;
                  Navigator.pop(context, true);
                },
                child:
                    const Text(AppString.createUser).mediumBold(AppColor.white),
              ),
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
