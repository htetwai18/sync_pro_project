import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/app_drawer.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _totalCustomers = 0;
  int _totalEngineers = 0;
  int _reportsToReview = 0;
  int _overdueTasks = 0;
  int _overdueInvoices = 0;
  int _taskOpen = 0;
  int _taskInProgress = 0;
  int _taskDone = 0;
  double _taskCompletionPercentage = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);

    try {
      // Load all data
      final customers = await MockApiService.instance.listCustomers();
      final engineers =
          await MockApiService.instance.listUsers(role: 'engineer');
      final allReports = await MockApiService.instance.listReports();
      final allTasks = await MockApiService.instance.listTasks();
      final allInvoices = await MockApiService.instance.listInvoices();

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Calculate metrics
      _totalCustomers = customers.length;
      _totalEngineers = engineers.length;

      // Reports to Review: status is 'submitted' or 'pending'
      _reportsToReview = allReports
          .where((r) =>
              r.status.toLowerCase() == 'submitted' ||
              r.status.toLowerCase() == 'pending')
          .length;

      // Overdue Tasks: status != 'completed' && scheduledDate < today
      _overdueTasks = allTasks.where((task) {
        if (task.status.toLowerCase() == 'completed' ||
            task.status.toLowerCase() == 'done') {
          return false;
        }
        if (task.scheduledDate == null) return false;
        final scheduled = DateTime(
          task.scheduledDate!.year,
          task.scheduledDate!.month,
          task.scheduledDate!.day,
        );
        return scheduled.isBefore(today);
      }).length;

      // Overdue Invoices: status != 'paid' && dueDate < today
      _overdueInvoices = allInvoices.where((invoice) {
        if (invoice.status.toLowerCase() == 'paid') return false;
        final dueDate = DateTime.tryParse(invoice.dueDate);
        if (dueDate == null) return false;
        final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
        return due.isBefore(today);
      }).length;

      // Task Status Breakdown
      _taskOpen = allTasks.where((task) {
        final status = task.status.toLowerCase();
        return status == 'open' || status == 'pending';
      }).length;

      _taskInProgress = allTasks.where((task) {
        return task.status.toLowerCase() == 'in_progress';
      }).length;

      _taskDone = allTasks.where((task) {
        final status = task.status.toLowerCase();
        return status == 'completed' || status == 'done';
      }).length;

      // Completion Percentage
      final totalTasks = allTasks.length;
      _taskCompletionPercentage =
          totalTasks > 0 ? (_taskDone / totalTasks) : 0.0;
    } catch (e) {
      // Handle error silently or show snackbar
      debugPrint('Dashboard load error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBarWithDrawer(context: context, title: AppString.dashboard),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                      children: [
                        _SummaryCard(
                          label: AppString.totalCustomers,
                          value: _totalCustomers.toString(),
                          color: AppColor.white,
                        ),
                        _SummaryCard(
                          label: AppString.totalEngineers,
                          value: _totalEngineers.toString(),
                          color: AppColor.white,
                        ),
                        _SummaryCard(
                          label: AppString.reportsToReview,
                          value: _reportsToReview.toString(),
                          color: AppColor.white,
                        ),
                        _SummaryCard(
                          label: AppString.overdueTasks,
                          value: _overdueTasks.toString(),
                          color: AppColor.white,
                        ),
                        _SummaryCard(
                          label: AppString.overdueInvoices,
                          value: _overdueInvoices.toString(),
                          color: AppColor.redStatusInner,
                        ),
                      ],
                    ),

                    Measurement.generalSize24.height,

                    // Task Status section
                    Text(AppString.taskStatus).mediumBold(AppColor.white),
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
                                      Text('${(_taskCompletionPercentage * 100).toStringAsFixed(0)}%')
                                          .xLargeBold(AppColor.white),
                                      Measurement.generalSize4.height,
                                      Text(AppString.completedStatus)
                                          .smallNormal(AppColor.white),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Measurement.generalSize120,
                                  height: Measurement.generalSize120,
                                  child: CircularProgressIndicator(
                                    value: _taskCompletionPercentage,
                                    strokeWidth: Measurement.generalSize12,
                                    strokeCap: StrokeCap.round,
                                    backgroundColor: AppColor.greyPercentCircle,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      AppColor.blueStatusInner,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Measurement.generalSize24.height,

                          // Task breakdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _TaskCount(
                                  label: AppString.openStatus,
                                  count: _taskOpen.toString()),
                              _TaskCount(
                                  label: AppString.inProgressStatus,
                                  count: _taskInProgress.toString()),
                              _TaskCount(
                                  label: AppString.doneStatus,
                                  count: _taskDone.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Measurement.generalSize24.height,

                    // Recent Activity
                    // Text(AppString.recentActivity).mediumBold(AppColor.white),
                    // Measurement.generalSize16.height,
                    // Container(
                    //   padding: Measurement.generalSize16.allPadding,
                    //   decoration: BoxDecoration(
                    //     color: AppColor.blueField,
                    //     borderRadius: Measurement.generalSize12.allRadius,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       _ActivityItem(
                    //         icon: Icons.add_circle,
                    //         iconColor: AppColor.blueStatusInner,
                    //         title: AppString.newTaskCreated,
                    //         subtitle: '${AppString.taskAssignedTo} Alex',
                    //       ),
                    //       Measurement.generalSize16.height,
                    //       _ActivityItem(
                    //         icon: Icons.warning,
                    //         iconColor: AppColor.redStatusInner,
                    //         title: AppString.invoiceOverdue,
                    //         subtitle: AppString.invoiceOverdueDesc,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
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
