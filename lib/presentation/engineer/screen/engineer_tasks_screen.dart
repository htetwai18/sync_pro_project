import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/enum.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_task_detail_screen.dart';
import 'package:sync_pro/presentation/engineer/widgets/engineer_task_card.dart';

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
        return (t.scheduledAt.year == now.year) &&
            (t.scheduledAt.month == now.month) &&
            (t.scheduledAt.day == now.day);
      } else if (tab == 1) {
        return (t.status != TaskStatus.completed) &&
            (t.scheduledAt.isAfter(now));
      } else {
        return t.status == TaskStatus.completed;
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
                          title: task.title,
                          status: task.status,
                          description: task.description.isNotEmpty
                              ? task.description
                              : 'Task detail description for ${task.title}.',
                          locationName: task.customer,
                          address: task.address,
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
