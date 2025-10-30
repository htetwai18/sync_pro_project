import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
// enum.dart not used; models carry string values for status/type/priority
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';
import 'package:sync_pro/presentation/shared/mock.dart';
import 'package:sync_pro/presentation/customer/screen/request_service_screen.dart';

class CustomerServiceListScreen extends StatefulWidget {
  const CustomerServiceListScreen({super.key});

  @override
  State<CustomerServiceListScreen> createState() =>
      _CustomerServiceListScreenState();
}

class _CustomerServiceListScreenState extends State<CustomerServiceListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.serviceRequests,
        context: context,
        canBack: false,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: Measurement.generalSize16.allPadding,
            decoration: BoxDecoration(
              color: AppColor.blueField,
              borderRadius: Measurement.generalSize12.allRadius,
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColor.blueStatusInner,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              labelColor: AppColor.white,
              unselectedLabelColor: AppColor.grey,
              labelStyle: Measurement.mediumFont.textStyle(
                AppColor.white,
                Measurement.font600,
              ),
              unselectedLabelStyle: Measurement.mediumFont.textStyle(
                AppColor.grey,
                Measurement.font400,
              ),
              tabs: const [
                Tab(text: AppString.active),
                Tab(text: AppString.completed),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActiveRequestsTab(),
                _buildCompletedRequestsTab(),
              ],
            ),
          ),

          // Request New Service Button
          Container(
            padding: Measurement.generalSize16.allPadding,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestServiceScreen(),
                    ),
                  );
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
                child: const Text(AppString.requestNewService)
                    .mediumBold(AppColor.white),
              ),
            ),
          ),
          Measurement.generalSize16.height,
        ],
      ),
    );
  }

  Widget _buildActiveRequestsTab() {
    final activeRequests =
        mockTasks.where((request) => request.status != 'completed').toList();

    if (activeRequests.isEmpty) {
      return _buildEmptyState(AppString.noActiveRequests);
    }

    return ListView.separated(
      padding: Measurement.generalSize16.horizontalPadding,
      itemCount: activeRequests.length,
      separatorBuilder: (_, __) => Measurement.generalSize12.height,
      itemBuilder: (context, index) {
        final request = activeRequests[index];
        return _ServiceRequestCard(
          request: request,
          onTap: () => _showServiceRequestDetails(request),
        );
      },
    );
  }

  Widget _buildCompletedRequestsTab() {
    final completedRequests =
        mockTasks.where((request) => request.status == 'completed').toList();

    if (completedRequests.isEmpty) {
      return _buildEmptyState(AppString.noCompletedRequests);
    }

    return ListView.separated(
      padding: Measurement.generalSize16.horizontalPadding,
      itemCount: completedRequests.length,
      separatorBuilder: (_, __) => Measurement.generalSize12.height,
      itemBuilder: (context, index) {
        final request = completedRequests[index];
        return _ServiceRequestCard(
          request: request,
          onTap: () => _showServiceRequestDetails(request),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: Measurement.generalSize72,
            color: AppColor.grey,
          ),
          Measurement.generalSize16.height,
          Text(message).mediumNormal(AppColor.grey),
        ],
      ),
    );
  }

  void _showServiceRequestDetails(TaskOrRequestedServiceModel request) {
    showModalBottomSheet(
      elevation: 0.0,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: Measurement.generalSize20.allRadius,
      ),
      builder: (context) => _ServiceRequestDetailsSheet(request: request),
    );
  }
}

class _ServiceRequestCard extends StatelessWidget {
  final TaskOrRequestedServiceModel request;
  final VoidCallback? onTap;

  const _ServiceRequestCard({
    required this.request,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Measurement.generalSize16.allPadding,
        decoration: BoxDecoration(
          color: AppColor.blueCard,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Service Type Icon
                Container(
                  width: Measurement.generalSize40,
                  height: Measurement.generalSize40,
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status),
                    borderRadius: Measurement.generalSize8.allRadius,
                  ),
                  child: Icon(
                    _getServiceTypeIcon(request.type),
                    color: AppColor.white,
                    size: Measurement.generalSize20,
                  ),
                ),
                Measurement.generalSize12.width,

                // Title and Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.title).mediumBold(AppColor.white),
                      Measurement.generalSize4.height,
                      Text(
                        '${AppString.serviceRequestId}: ${request.id}',
                      ).smallNormal(AppColor.grey),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding: Measurement.generalSize4.horizontalPadding +
                      Measurement.generalSize2.verticalPadding,
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status),
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Text(_label(request.status)).smallBold(AppColor.white),
                ),
              ],
            ),

            Measurement.generalSize12.height,

            // Description
            Text(request.description).smallNormal(AppColor.grey),

            Measurement.generalSize12.height,

            // Details Row
            Row(
              children: [
                // Priority
                Container(
                  padding: Measurement.generalSize4.horizontalPadding +
                      Measurement.generalSize2.verticalPadding,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(request.priority),
                    borderRadius: Measurement.generalSize8.allRadius,
                  ),
                  child: Text(
                    _label(request.priority),
                  ).smallBold(AppColor.white),
                ),
                Measurement.generalSize8.width,

                // Service Type
                Container(
                  padding: Measurement.generalSize4.horizontalPadding +
                      Measurement.generalSize2.verticalPadding,
                  decoration: BoxDecoration(
                    color: AppColor.blueField,
                    borderRadius: Measurement.generalSize8.allRadius,
                  ),
                  child: Text(_label(request.type)).smallBold(AppColor.white),
                ),
              ],
            ),

            Measurement.generalSize12.height,

            // Footer Row
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: Measurement.generalSize16,
                  color: AppColor.grey,
                ),
                Measurement.generalSize4.width,
                Expanded(
                  child: Text(request.building.name).smallNormal(AppColor.grey),
                ),
                if (request.scheduledDate != null) ...[
                  Icon(
                    Icons.schedule,
                    size: Measurement.generalSize16,
                    color: AppColor.grey,
                  ),
                  Measurement.generalSize4.width,
                  Text(
                    '${request.scheduledDate!.day}/${request.scheduledDate!.month}/${request.scheduledDate!.year}',
                  ).smallNormal(AppColor.grey),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _label(String v) =>
      v.isEmpty ? '' : v[0].toUpperCase() + v.substring(1).replaceAll('_', ' ');

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColor.greyStatusInner;
      case 'scheduled':
      case 'in_progress':
        return AppColor.orangeStatusInner;
      case 'completed':
        return AppColor.greenStatusInner;
      case 'cancelled':
      case 'on_hold':
      case 'overdue':
        return AppColor.redStatusInner;
      default:
        return AppColor.blueField;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'low':
        return AppColor.greenStatusInner;
      case 'medium':
        return AppColor.blueStatusInner;
      case 'high':
        return AppColor.orangeStatusInner;
      case 'urgent':
        return AppColor.redStatusInner;
      default:
        return AppColor.blueField;
    }
  }

  IconData _getServiceTypeIcon(String type) {
    switch (type) {
      case 'maintenance':
        return Icons.build;
      case 'repair':
        return Icons.handyman;
      case 'installation':
        return Icons.install_desktop;
      case 'inspection':
        return Icons.search;
      case 'emergency':
        return Icons.warning;
      default:
        return Icons.miscellaneous_services;
    }
  }
}

class _ServiceRequestDetailsSheet extends StatelessWidget {
  final TaskOrRequestedServiceModel request;

  const _ServiceRequestDetailsSheet({required this.request});

  @override
  Widget build(BuildContext context) {
    String _labelLocal(String v) => v.isEmpty
        ? ''
        : v[0].toUpperCase() + v.substring(1).replaceAll('_', ' ');
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          color: AppColor.background,
          padding: Measurement.generalSize20.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: Measurement.generalSize40,
                  height: Measurement.generalSize4,
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: Measurement.generalSize2.allRadius,
                  ),
                ),
              ),
              Measurement.generalSize20.height,

              // Title
              const Text(AppString.serviceRequestDetails)
                  .largeBold(AppColor.white),
              Measurement.generalSize16.height,

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailRow(
                        label: AppString.serviceRequestId,
                        value: request.id,
                      ),
                      _DetailRow(
                        label: AppString.serviceType,
                        value: _labelLocal(request.type),
                      ),
                      _DetailRow(
                        label: AppString.priority,
                        value: _labelLocal(request.priority),
                      ),
                      _DetailRow(
                        label: AppString.status,
                        value: _labelLocal(request.status),
                      ),
                      _DetailRow(
                        label: AppString.building,
                        value: request.building.name,
                      ),
                      if (request.building.roomNumber != null)
                        _DetailRow(
                          label: AppString.room,
                          value: request.building.roomNumber!,
                        ),
                      if (request.asset.name.isNotEmpty)
                        _DetailRow(
                          label: AppString.asset,
                          value: request.asset.name,
                        ),
                      _DetailRow(
                        label: AppString.requestDate,
                        value:
                            '${request.requestDate.day}/${request.requestDate.month}/${request.requestDate.year}',
                      ),
                      if (request.scheduledDate != null)
                        _DetailRow(
                          label: AppString.scheduled,
                          value:
                              '${request.scheduledDate!.day}/${request.scheduledDate!.month}/${request.scheduledDate!.year}',
                        ),
                      if (request.assignedTo != null)
                        _DetailRow(
                          label: AppString.assignedEngineer,
                          value: request.assignedTo!.name,
                        ),
                      if (request.specialInstructions.isNotEmpty) ...[
                        Measurement.generalSize16.height,
                        Text(AppString.specialInstructions)
                            .mediumBold(AppColor.white),
                        Measurement.generalSize8.height,
                        Text(request.specialInstructions)
                            .smallNormal(AppColor.grey),
                      ],
                      if (request.notes.isNotEmpty) ...[
                        Measurement.generalSize16.height,
                        Text(AppString.notes).mediumBold(AppColor.white),
                        Measurement.generalSize8.height,
                        Text(request.notes).smallNormal(AppColor.grey),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measurement.generalSize8.verticalPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label).smallBold(AppColor.grey),
          ),
          Expanded(
            child: Text(value).smallNormal(AppColor.white),
          ),
        ],
      ),
    );
  }
}
