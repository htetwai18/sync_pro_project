import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/app_drawer.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/admin/widgets/user_list_item.dart';
import 'package:sync_pro/presentation/admin/screen/users/add_user_screen.dart';
import 'package:sync_pro/presentation/admin/screen/users/user_detail_screen.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  List<UserModel> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim());
      _load();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<UserModel> filtered = _items;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBarWithDrawer(context: context, title: AppString.users),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: TextField(
                controller: _searchController,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.searchUsers,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  prefixIcon: const Icon(Icons.search, color: AppColor.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
          ),
          Measurement.generalSize16.height,
          // Users list
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Divider(
                height: Measurement.generalSize4,
                color: AppColor.greyPercentCircle.withOpacity(0.2),
              ),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return UserListItem(
                  item: item,
                  onTap: () async {
                    final changed = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailScreen(user: item),
                      ),
                    );
                    if (changed == true) {
                      _load();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddUserScreen()),
          );
          if (created == true) {
            _load();
          }
        },
        backgroundColor: AppColor.blueStatusInner,
        foregroundColor: AppColor.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _load() async {
    final list = await MockApiService.instance.listUsers(query: _query);
    setState(() => _items = list);
  }
}
