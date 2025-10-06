import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/app_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBarWithDrawer(context: context, title: AppString.dashboard),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Measurement.generalSize24.height,

            // Summary cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: Measurement.generalSize16,
              mainAxisSpacing: Measurement.generalSize16,
              children: const [
                _SummaryCard(
                  label: AppString.activeTasks,
                  value: '23',
                  color: AppColor.white,
                ),
                _SummaryCard(
                  label: AppString.pendingTasks,
                  value: '15',
                  color: AppColor.white,
                ),
                _SummaryCard(
                  label: AppString.reportsToReview,
                  value: '8',
                  color: AppColor.white,
                ),
                _SummaryCard(
                  label: AppString.pendingApprovals,
                  value: '5',
                  color: AppColor.white,
                ),
                _SummaryCard(
                  label: AppString.overdueInvoices,
                  value: '3',
                  color: AppColor.redStatusInner,
                ),
              ],
            ),

            Measurement.generalSize24.height,

            // Task Status section
            const Text(AppString.taskStatus).mediumBold(AppColor.white),
            Measurement.generalSize16.height,
            Container(
              padding: Measurement.generalSize24.allPadding,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: Column(
                children: [
                  // Circular progress chart
                  SizedBox(
                    width: Measurement.generalSize120,
                    height: Measurement.generalSize120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('65%').xLargeBold(AppColor.white),
                              Measurement.generalSize4.height,
                              const Text(AppString.completedStatus)
                                  .smallNormal(AppColor.white),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: Measurement.generalSize120,
                          height: Measurement.generalSize120,
                          child: CircularProgressIndicator(
                            value: 0.65,
                            strokeWidth: Measurement.generalSize12,
                            strokeCap: StrokeCap.round,
                            backgroundColor: AppColor.greyPercentCircle,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.blueStatusInner,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Measurement.generalSize24.height,

                  // Task breakdown
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _TaskCount(label: AppString.openStatus, count: '12'),
                      _TaskCount(label: AppString.inProgressStatus, count: '8'),
                      _TaskCount(label: AppString.doneStatus, count: '23'),
                    ],
                  ),
                ],
              ),
            ),

            Measurement.generalSize24.height,

            // Recent Activity
            const Text(AppString.recentActivity).mediumBold(AppColor.white),
            Measurement.generalSize16.height,
            Container(
              padding: Measurement.generalSize16.allPadding,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: Column(
                children: [
                  const _ActivityItem(
                    icon: Icons.add_circle,
                    iconColor: AppColor.blueStatusInner,
                    title: AppString.newTaskCreated,
                    subtitle: '${AppString.taskAssignedTo} Alex',
                  ),
                  Measurement.generalSize16.height,
                  const _ActivityItem(
                    icon: Icons.warning,
                    iconColor: AppColor.redStatusInner,
                    title: AppString.invoiceOverdue,
                    subtitle: AppString.invoiceOverdueDesc,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Measurement.generalSize16.allPadding,
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label).smallNormal(AppColor.grey),
          Measurement.generalSize8.height,
          Text(value).xLargeBold(color),
        ],
      ),
    );
  }
}

class _TaskCount extends StatelessWidget {
  final String label;
  final String count;

  const _TaskCount({
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count).largeBold(AppColor.white),
        Measurement.generalSize4.height,
        Text(label).smallNormal(AppColor.grey),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Measurement.generalSize40,
          height: Measurement.generalSize40,
          decoration: BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon,
              color: AppColor.white, size: Measurement.generalSize20),
        ),
        Measurement.generalSize12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title).mediumBold(AppColor.white),
              Measurement.generalSize4.height,
              Text(subtitle).smallNormal(AppColor.grey),
            ],
          ),
        ),
      ],
    );
  }
}
