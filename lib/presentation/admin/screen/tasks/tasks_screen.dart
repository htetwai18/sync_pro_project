import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/app_drawer.dart';

import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/admin/widgets/task_list_item.dart';
import 'package:sync_pro/presentation/admin/screen/tasks/create_task_screen.dart';
import 'package:sync_pro/presentation/admin/screen/tasks/task_detail_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskItemDisplayModel> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await MockApiService.instance.listTasks();
    setState(() => _items = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: Measurement.generalSize0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColor.white),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: const Text(AppString.tasks),
        actions: [
          IconButton(
            onPressed: () async {
              final created = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
              );
              if (created == true) await _load();
            },
            icon: const Icon(Icons.add, color: AppColor.white),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.separated(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        itemCount: _items.length,
        separatorBuilder: (_, __) => Measurement.generalSize16.height,
        itemBuilder: (context, index) {
          final item = _items[index];
          return TaskListItem(
            item: item,
            onTap: () async {
              final changed = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TaskDetailScreen(item: item),
                ),
              );
              if (changed == true) await _load();
            },
          );
        },
      ),
    );
  }
}
