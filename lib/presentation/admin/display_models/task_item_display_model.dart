import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';

// Re-export the unified mock data
export 'package:sync_pro/presentation/customer/display_models/task_display_model.dart'
    show mockTasks;

// Re-export the unified TaskDisplayModel for admin panels
typedef TaskItemDisplayModel = TaskDisplayModel;
