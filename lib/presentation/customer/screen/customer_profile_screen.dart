import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.myAccount,
        context: context,
        canBack: false,
      ),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Measurement.generalSize24.height,

            // Company Information Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppString.companyInformation)
                    .largeBold(AppColor.white),
                // Request Changes Button
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to request changes screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blueStatusInner,
                    foregroundColor: AppColor.white,
                    padding: Measurement.generalSize12.verticalPadding +
                        Measurement.generalSize16.horizontalPadding,
                    shape: RoundedRectangleBorder(
                      borderRadius: Measurement.generalSize8.allRadius,
                    ),
                    elevation: 0,
                  ),
                  child: const Text(AppString.requestChanges)
                      .smallBold(AppColor.white),
                ),
              ],
            ),
            Measurement.generalSize16.height,

            Container(
              width: double.infinity,
              padding: Measurement.generalSize20.allPadding,
              decoration: BoxDecoration(
                color: AppColor.blueCard,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Name
                  const _InfoField(
                    label: AppString.companyName,
                    value: AppString.acmeCorp,
                  ),
                  Measurement.generalSize16.height,

                  // Phone
                  const _InfoField(
                    label: AppString.phoneLabel,
                    value: AppString.phoneNumber,
                  ),
                  Measurement.generalSize16.height,

                  // Email
                  const _InfoField(
                    label: AppString.emailLabel,
                    value: AppString.supportEmail,
                  ),
                  Measurement.generalSize16.width,
                ],
              ),
            ),

            Measurement.generalSize28.height,

            // Contacts List Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppString.contactsList).largeBold(AppColor.white),

                // Add Contact Button
                FloatingActionButton(
                  onPressed: () {
                    // TODO: Navigate to add contact screen
                  },
                  backgroundColor: AppColor.blueStatusInner,
                  mini: true,
                  child: const Icon(
                    Icons.add,
                    color: AppColor.white,
                    size: Measurement.generalSize20,
                  ),
                ),
              ],
            ),
            Measurement.generalSize16.height,

            // Contact Cards
            const _ContactCard(
              name: AppString.aliceJohnson,
              role: AppString.manager,
            ),
            Measurement.generalSize12.height,

            const _ContactCard(
              name: AppString.bobWilliams,
              role: AppString.engineerContact,
            ),
            Measurement.generalSize12.height,

            const _ContactCard(
              name: AppString.charlieDavis,
              role: AppString.technician,
            ),

            Measurement.generalSize24.height,
          ],
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  final String label;
  final String value;

  const _InfoField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).smallNormal(AppColor.grey),
        Measurement.generalSize4.height,
        Text(value).mediumBold(AppColor.white),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final String name;
  final String role;

  const _ContactCard({
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Measurement.generalSize16.allPadding,
      decoration: BoxDecoration(
        color: AppColor.blueCard,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name).mediumBold(AppColor.white),
                Measurement.generalSize4.height,
                Text(role).smallNormal(AppColor.grey),
              ],
            ),
          ),

          // Edit Icon
          GestureDetector(
            onTap: () {
              // TODO: Navigate to edit contact screen
            },
            child: Container(
              width: Measurement.generalSize28,
              height: Measurement.generalSize28,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize8.allRadius,
              ),
              child: const Icon(
                Icons.edit,
                color: AppColor.grey,
                size: Measurement.generalSize16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
