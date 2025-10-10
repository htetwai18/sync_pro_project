import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class CustomerRequestChangeScreen extends StatefulWidget {
  const CustomerRequestChangeScreen({super.key});

  @override
  State<CustomerRequestChangeScreen> createState() =>
      _CustomerRequestChangeScreenState();
}

class _CustomerRequestChangeScreenState
    extends State<CustomerRequestChangeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController =
      TextEditingController(text: AppString.syncProInc);
  final _addressController =
      TextEditingController(text: AppString.innovationDrive);
  final _phoneController = TextEditingController(text: AppString.phoneNumber);
  final _emailController = TextEditingController(text: AppString.contactEmail);
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.requestChange,
        context: context,
        canBack: true,
      ),
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

                    // Company Name Field
                    _buildTextField(
                      label: AppString.companyNameLabel,
                      controller: _companyNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.pleaseEnterCompanyName;
                        }
                        return null;
                      },
                    ),
                    Measurement.generalSize20.height,

                    // Address Field
                    _buildTextField(
                      label: AppString.addressLabel,
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.pleaseEnterAddress;
                        }
                        return null;
                      },
                    ),
                    Measurement.generalSize20.height,

                    // Phone Number Field
                    _buildTextField(
                      label: AppString.phoneNumberLabel,
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

                    // Reason for Change Field
                    _buildTextField(
                      label: AppString.reasonForChange,
                      controller: _reasonController,
                      maxLines: 4,
                      hintText: AppString.reasonForChangePlaceholder,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.pleaseProvideReason;
                        }
                        return null;
                      },
                    ),

                    Measurement.generalSize24.height,
                  ],
                ),
              ),
            ),

            // Submit Button
            Container(
              padding: Measurement.generalSize16.allPadding,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Submit the request
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppString.requestSubmittedSuccessfully),
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
                  child: const Text(AppString.submitRequest)
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
    int maxLines = 1,
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
            maxLines: maxLines,
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
