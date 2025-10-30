import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class EditCustomerScreen extends StatefulWidget {
  final String name;
  final String contactPerson;
  final String phone;
  final String email;
  final String address;

  const EditCustomerScreen({
    super.key,
    required this.name,
    required this.contactPerson,
    required this.phone,
    required this.email,
    required this.address,
  });

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _customerName;
  late final TextEditingController _contactPerson;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _address;

  @override
  void initState() {
    super.initState();
    _customerName = TextEditingController(text: widget.name);
    _contactPerson = TextEditingController(text: widget.contactPerson);
    _phone = TextEditingController(text: widget.phone);
    _email = TextEditingController(text: widget.email);
    _address = TextEditingController(text: widget.address);
  }

  @override
  void dispose() {
    _customerName.dispose();
    _contactPerson.dispose();
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.editCustomer,
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
              _FieldBlock(
                label: AppString.customerNameLabel,
                child: TextFormField(
                  controller: _customerName,
                  decoration: _decoration(),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Please enter customer name'
                      : null,
                ),
              ),
              Measurement.generalSize20.height,
              _FieldBlock(
                label: AppString.contactPersonLabel,
                child: TextFormField(
                  controller: _contactPerson,
                  decoration: _decoration(),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Please enter contact person'
                      : null,
                ),
              ),
              Measurement.generalSize20.height,
              _FieldBlock(
                label: AppString.phoneNumberLabelAdmin,
                child: TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: _decoration(),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Please enter phone number'
                      : null,
                ),
              ),
              Measurement.generalSize20.height,
              _FieldBlock(
                label: AppString.emailAddress,
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decoration(),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter email';
                    if (!v.contains('@')) return 'Please enter a valid email';
                    return null;
                  },
                ),
              ),
              Measurement.generalSize20.height,
              _FieldBlock(
                label: AppString.addressLabelAdmin,
                child: TextFormField(
                  controller: _address,
                  maxLines: 4,
                  decoration: _decoration(),
                  style: Measurement.mediumFont
                      .textStyle(AppColor.white, Measurement.font400),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Please enter address' : null,
                ),
              ),
              Measurement.generalSize24.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Measurement.generalSize16.allPadding,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueField,
                  foregroundColor: AppColor.white,
                  padding: Measurement.generalSize16.verticalPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  elevation: 0,
                ),
                child: const Text(AppString.cancel).mediumBold(AppColor.white),
              ),
            ),
            Measurement.generalSize12.width,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, true);
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
                child: const Text(AppString.saveChanges)
                    .mediumBold(AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
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
