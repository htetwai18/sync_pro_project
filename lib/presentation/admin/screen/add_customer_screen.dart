import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerName = TextEditingController();
  final _contactPerson = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();

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
        title: AppString.addNewCustomer,
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
                  decoration: _decoration(hint: AppString.enterCustomerName),
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
                  decoration: _decoration(hint: AppString.enterContactPerson),
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
                  decoration: _decoration(hint: AppString.enterPhoneNumber),
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
                  decoration:
                      _decoration(hint: AppString.enterEmailAddressAdmin),
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
                  decoration: _decoration(hint: AppString.enterFullAddress),
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
        child: SizedBox(
          width: double.infinity,
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
            child:
                const Text(AppString.createCustomer).mediumBold(AppColor.white),
          ),
        ),
      ),
    );
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
