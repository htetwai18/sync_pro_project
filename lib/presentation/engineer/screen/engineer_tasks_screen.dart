import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_task_detail_screen.dart';
import 'package:sync_pro/presentation/engineer/widgets/engineer_task_card.dart';

class EngineerTasksScreen extends StatefulWidget {
  final String engineerId;
  const EngineerTasksScreen({super.key, required this.engineerId});

  @override
  State<EngineerTasksScreen> createState() => _EngineerTasksScreenState();
}

class _EngineerTasksScreenState extends State<EngineerTasksScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<TaskOrRequestedServiceModel> _items = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() => _load());
    _load();
  }

  Future<void> _load() async {
    final scope = _tabController.index == 0
        ? 'today'
        : _tabController.index == 1
            ? 'upcoming'
            : _tabController.index == 2
                ? 'overdue'
                : 'completed';
    final list = await MockApiService.instance
        .listEngineerTasks(engineerId: widget.engineerId, scope: scope);
    setState(() => _items = list);
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
              Tab(text: 'Overdue'),
              Tab(text: 'Done')
            ],
            onTap: (_) => setState(() {}),
          ),
          Measurement.generalSize12.height,
          Expanded(
            child: Padding(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (_, __) => Measurement.generalSize12.height,
                itemBuilder: (context, index) {
                  final task = _items[index];
                  return EngineerTaskCard(
                    task: task,
                    onTap: () async {
                      final changed = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EngineerTaskDetailScreen(taskId: task.id),
                        ),
                      );
                      if (changed == true) await _load();
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
