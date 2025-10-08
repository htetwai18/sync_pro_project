import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/enum.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_detail_screen.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_tasks_screen.dart';

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

  //TODO : will replace with login engineer later
  UserItemDisplayModel engineer = const UserItemDisplayModel(
    name: 'Alice Johnson',
    email: 'alice.johnson@example.com',
    role: UserRole.engineer,
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
  );
  @override
  void initState() {
    super.initState();
    mobileScreens = [
      const EngineerTasksScreen(),
      EngineerDetailScreen(user: engineer),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
