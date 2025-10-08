import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class CustomerDashboardScreen extends StatelessWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Measurement.generalSize16.horizontalIsToVertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const Text(AppString.customerDashboard).largeBold(AppColor.grey),
              Measurement.generalSize16.height,

              // Dashboard Header Card
              Container(
                padding: Measurement.generalSize20.allPadding,
                decoration: BoxDecoration(
                  color: AppColor.blueCard,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Row(
                  children: [
                    // Profile Picture
                    Container(
                      width: Measurement.generalSize48,
                      height: Measurement.generalSize48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.grey,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColor.white,
                        size: Measurement.generalSize24,
                      ),
                    ),
                    Measurement.generalSize16.width,

                    // Welcome Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(AppString.dashboard)
                              .largeBold(AppColor.white),
                          Measurement.generalSize4.height,
                          const Text(AppString.welcomeBack)
                              .mediumNormal(AppColor.white),
                        ],
                      ),
                    ),

                    // Notification Bell
                    Container(
                      width: Measurement.generalSize40,
                      height: Measurement.generalSize40,
                      decoration: BoxDecoration(
                        color: AppColor.blueField,
                        borderRadius: Measurement.generalSize8.allRadius,
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: AppColor.white,
                        size: Measurement.generalSize20,
                      ),
                    ),
                  ],
                ),
              ),

              Measurement.generalSize24.height,

              // Key Metrics Cards
              const _MetricCard(
                title: AppString.activeServiceRequests,
                value: "3",
              ),
              Measurement.generalSize16.height,

              const _MetricCard(
                title: AppString.assetsUnderManagement,
                value: "12",
              ),
              Measurement.generalSize16.height,

              const _MetricCard(
                title: AppString.unpaidInvoices,
                value: "2",
              ),

              Measurement.generalSize24.height,

              // Recent Activity Section
              const Text(AppString.recentActivity).largeBold(AppColor.white),
              Measurement.generalSize16.height,

              Container(
                padding: Measurement.generalSize16.allPadding,
                decoration: BoxDecoration(
                  color: AppColor.blueCard,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Column(
                  children: [
                    const _ActivityItem(
                      icon: Icons.settings,
                      title: AppString.serviceRequestUpdated,
                      timestamp: AppString.twoHoursAgo,
                    ),
                    Measurement.generalSize16.height,
                    const _ActivityItem(
                      icon: Icons.receipt,
                      title: AppString.invoiceSent,
                      timestamp: AppString.yesterday,
                    ),
                    Measurement.generalSize16.height,
                    const _ActivityItem(
                      icon: Icons.add_box,
                      title: AppString.newAssetAdded,
                      timestamp: AppString.threeDaysAgo,
                    ),
                  ],
                ),
              ),

              Measurement.generalSize24.height,

              // Call to Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to request new service screen
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, size: Measurement.generalSize20),
                      Measurement.generalSize8.width,
                      const Text(AppString.requestNewService)
                          .mediumBold(AppColor.white),
                    ],
                  ),
                ),
              ),

              Measurement.generalSize24.height,
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const _MetricCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Measurement.generalSize20.allPadding,
      decoration: BoxDecoration(
        color: AppColor.blueCard,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title).mediumNormal(AppColor.grey),
          Measurement.generalSize8.height,
          Text(value).xLargeBold(AppColor.white),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String timestamp;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Measurement.generalSize40,
          height: Measurement.generalSize40,
          decoration: const BoxDecoration(
            color: AppColor.grey,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColor.blueStatusInner,
            size: Measurement.generalSize20,
          ),
        ),
        Measurement.generalSize12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title).mediumNormal(AppColor.white),
              Measurement.generalSize4.height,
              Text(timestamp).smallNormal(AppColor.grey),
            ],
          ),
        ),
      ],
    );
  }
}
