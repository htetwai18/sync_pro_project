import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class CustomerAddContactScreen extends StatefulWidget {
  const CustomerAddContactScreen({super.key});

  @override
  State<CustomerAddContactScreen> createState() =>
      _CustomerAddContactScreenState();
}

class _CustomerAddContactScreenState extends State<CustomerAddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedRole;

  final List<String> _roles = [
    AppString.manager,
    AppString.engineerContact,
    AppString.technician,
  ];

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
      appBar: getAppBar(
          title: AppString.addNewContact, context: context, canBack: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: Measurement.generalSize16.horizontalIsToVertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Measurement.generalSize24.height,

                    // Name Field
                    _buildTextField(
                      label: AppString.nameLabel,
                      controller: _nameController,
                      hintText: AppString.enterName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    Measurement.generalSize20.height,

                    // Email Field
                    _buildTextField(
                      label: AppString.emailLabel,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppString.enterEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    Measurement.generalSize20.height,

                    // Phone Field
                    _buildTextField(
                      label: AppString.phoneLabel,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: AppString.enterPhone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    Measurement.generalSize20.height,

                    // Role Dropdown
                    _buildRoleDropdown(),

                    Measurement.generalSize24.height,
                  ],
                ),
              ),
            ),

            // Add Contact Button
            Container(
              padding: Measurement.generalSize16.allPadding,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Add the contact
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact added successfully'),
                          backgroundColor: AppColor.greenStatusInner,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blueStatusInner,
                    foregroundColor: AppColor.white,
                    padding: Measurement.generalSize16.verticalPadding,
                    shape: RoundedRectangleBorder(
                      borderRadius: Measurement.generalSize12.allRadius,
                    ),
                    elevation: 0,
                  ),
                  child: const Text(AppString.addContact)
                      .mediumBold(AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).mediumBold(AppColor.white),
        Measurement.generalSize8.height,
        _Field(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: Measurement.mediumFont
                .textStyle(AppColor.white, Measurement.font400),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Measurement.mediumFont
                  .textStyle(AppColor.grey, Measurement.font400),
              border: InputBorder.none,
              contentPadding: Measurement.generalSize16.horizontalIsToVertical,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppString.roleLabel).mediumBold(AppColor.white),
        Measurement.generalSize8.height,
        _Field(
          child: DropdownButtonFormField<String>(
            value: _selectedRole,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: Measurement.generalSize16.horizontalIsToVertical,
            ),
            dropdownColor: AppColor.blueField,
            iconEnabledColor: AppColor.grey,
            style: Measurement.mediumFont
                .textStyle(AppColor.white, Measurement.font400),
            hint: const Text(AppString.selectRoleLabel)
                .mediumNormal(AppColor.grey),
            items: _roles.map((String role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role).mediumNormal(AppColor.white),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a role';
              }
              return null;
            },
          ),
        ),
      ],
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
