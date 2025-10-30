import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_task_detail_screen.dart';
import 'package:sync_pro/presentation/engineer/widgets/engineer_task_card.dart';
import 'package:sync_pro/presentation/shared/mock.dart';

class EngineerTasksScreen extends StatefulWidget {
  const EngineerTasksScreen({super.key});

  @override
  State<EngineerTasksScreen> createState() => _EngineerTasksScreenState();
}

class _EngineerTasksScreenState extends State<EngineerTasksScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<TaskItemDisplayModel> _filterByTab(int tab) {
    final now = DateTime.now();
    return mockTasks.where((t) {
      if (tab == 0) {
        return (t.scheduledDate?.year == now.year) &&
            (t.scheduledDate?.month == now.month) &&
            (t.scheduledDate?.day == now.day);
      } else if (tab == 1) {
        return (t.status != 'completed') &&
            (t.scheduledDate?.isAfter(now) ?? false);
      } else {
        return t.status == 'completed';
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.grey,
            indicatorColor: AppColor.blueStatusInner,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed')
            ],
            onTap: (_) => setState(() {}),
          ),
          Measurement.generalSize12.height,
          Expanded(
            child: Padding(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              child: ListView.separated(
                itemCount: _filterByTab(_tabController.index).length,
                separatorBuilder: (_, __) => Measurement.generalSize12.height,
                itemBuilder: (context, index) {
                  final task = _filterByTab(_tabController.index)[index];
                  return EngineerTaskCard(
                    task: task,
                    onTap: () {
                      Routing.transition(
                        context,
                        EngineerTaskDetailScreen(
                          asset: task.asset.id,
                          assetName: task.asset.name,
                          title: task.title,
                          status: task.status,
                          description: task.description.isNotEmpty
                              ? task.description
                              : 'Task detail description for ${task.title}.',
                          locationName: task.customer.name,
                          address: task.building.address,
                          priority: task.priority,
                          scheduledAt: task.scheduledDate,
                          assignedAt: task.assignedDate,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
