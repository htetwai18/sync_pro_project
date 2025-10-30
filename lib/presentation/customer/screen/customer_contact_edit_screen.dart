import 'package:sync_pro/presentation/customer/display_models/contact_display_model.dart';
import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class CustomerEditContactScreen extends StatefulWidget {
  final ContactModel contact;
  const CustomerEditContactScreen({super.key, required this.contact});

  @override
  State<CustomerEditContactScreen> createState() =>
      _CustomerEditContactScreenState();
}

class _CustomerEditContactScreenState extends State<CustomerEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  String? _selectedRole;

  final List<String> _roles = [
    AppString.manager,
    AppString.engineerContact,
    AppString.technician,
    AppString.administrator,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _emailController = TextEditingController(text: widget.contact.email);
    _phoneController = TextEditingController(text: widget.contact.phone);
    _selectedRole = widget.contact.role;
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
      appBar: getAppBar(
          title: AppString.editContactDetails, context: context, canBack: true),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.pleaseEnterName;
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.pleaseEnterEmail;
                        }
                        if (!value.contains('@')) {
                          return AppString.pleaseEnterValidEmail;
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.pleaseEnterPhoneNumber;
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

            // Action Buttons
            Container(
              padding: Measurement.generalSize16.allPadding,
              child: Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.blueField,
                        foregroundColor: AppColor.white,
                        padding: Measurement.generalSize16.verticalPadding,
                        shape: RoundedRectangleBorder(
                          borderRadius: Measurement.generalSize12.allRadius,
                        ),
                        elevation: 0,
                      ),
                      child: const Text(AppString.cancelButton)
                          .mediumBold(AppColor.white),
                    ),
                  ),
                  Measurement.generalSize12.width,

                  // Save Changes Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Save the contact changes
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text(AppString.contactUpdatedSuccessfully),
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
                      child: const Text(AppString.saveChangesButton)
                          .mediumBold(AppColor.white),
                    ),
                  ),
                ],
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
        _DropdownField<String>(
          value: _selectedRole,
          hint: AppString.selectRoleLabel,
          items: _roles,
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
            });
          },
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
