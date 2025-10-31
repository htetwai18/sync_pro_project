import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_detail_screen.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_tasks_screen.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class BottomNavigationEngineer extends StatefulWidget {
  const BottomNavigationEngineer({
    super.key,
  });

  @override
  State<BottomNavigationEngineer> createState() =>
      _BottomNavigationEngineerState();
}

class _BottomNavigationEngineerState extends State<BottomNavigationEngineer> {
  int currentIndex = 0;
  List<Widget> mobileScreens = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final engineers = await MockApiService.instance.listUsers(role: 'engineer');
    if (engineers.isEmpty) return;
    final engineer = engineers.first;
    setState(() {
      mobileScreens = [
        EngineerTasksScreen(engineerId: engineer.id),
        EngineerDetailScreen(user: engineer),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mobileScreens.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColor.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(Measurement.generalSize10),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.background,
          body: IndexedStack(
            index: currentIndex,
            children: mobileScreens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            backgroundColor: AppColor.background,
            selectedItemColor: AppColor.white,
            unselectedItemColor: AppColor.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.task_alt,
                ),
                label: AppString.tasks,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: AppString.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
