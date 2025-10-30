import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/app_drawer.dart';
// PartModel imported through shared mocks usage in this file
import 'package:sync_pro/presentation/admin/widgets/part_list_item.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/screen/parts/part_detail_screen.dart';
import 'package:sync_pro/presentation/admin/screen/parts/add_part_screen.dart';
import 'package:sync_pro/presentation/shared/mock.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';

class PartsScreen extends StatefulWidget {
  const PartsScreen({super.key});

  @override
  State<PartsScreen> createState() => _PartsScreenState();
}

class _PartsScreenState extends State<PartsScreen> {
  final TextEditingController _search = TextEditingController();
  String _query = '';
  late List<PartModel> _items;

  @override
  void initState() {
    super.initState();
    _items = List<PartModel>.from(mockParts);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _items
        .where((e) =>
            e.name.toLowerCase().contains(_query.toLowerCase()) ||
            e.number.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBarWithDrawer(context: context, title: AppString.parts),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: TextField(
                controller: _search,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.searchByNameOrNumber,
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
          Expanded(
            child: ListView.separated(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Measurement.generalSize16.height,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PartListItem(
                        item: item,
                        onTap: () {
                          Routing.transition(
                            context,
                            PartDetailScreen(part: item),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: AppColor.grey),
                      onPressed: () => _confirmDelete(item.id),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routing.transition(context, const AddPartScreen());
        },
        backgroundColor: AppColor.blueStatusInner,
        foregroundColor: AppColor.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _confirmDelete(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.background,
        shape: RoundedRectangleBorder(
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        title: Text(AppString.delete).mediumBold(AppColor.white),
        content: Text(AppString.areYouSureDelete).mediumNormal(AppColor.white),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(AppString.cancelButton),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.redStatusInner),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppString.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _items.removeWhere((p) => p.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted successfully.')),
      );
    }
  }
}
