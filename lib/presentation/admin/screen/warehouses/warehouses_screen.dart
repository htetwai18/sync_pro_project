import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_drawer.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/presentation/admin/screen/warehouses/create_edit_warehouse_screen.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';

class WarehousesScreen extends StatefulWidget {
  const WarehousesScreen({super.key});

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  final TextEditingController _search = TextEditingController();
  List<InventoryModel> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
    _search.addListener(() => _load());
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = (_items)
        .where((w) =>
            _search.text.isEmpty ||
            w.name.toLowerCase().contains(_search.text.toLowerCase()) ||
            w.code.toLowerCase().contains(_search.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      drawer: const AppDrawer(),
      appBar: getAppBarWithDrawer(title: AppString.warehouse, context: context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blueStatusInner,
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateEditWarehouseScreen(),
            ),
          );
          if (created == true) await _load();
        },
        child: const Icon(Icons.add, color: AppColor.white),
      ),
      body: Padding(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          children: [
            _searchField(),
            Measurement.generalSize16.height,
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => Measurement.generalSize8.height,
                itemBuilder: (_, idx) {
                  final w = filtered[idx];
                  return _WarehouseItem(
                    warehouse: w,
                    onTap: () {},
                    onEdit: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CreateEditWarehouseScreen(warehouse: w),
                        ),
                      );
                      if (updated == true) await _load();
                    },
                    onDelete: () => _confirmDelete(w.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: TextField(
        controller: _search,
        style: Measurement.mediumFont
            .textStyle(AppColor.white, Measurement.font400),
        decoration: InputDecoration(
          hintText: 'Search by name or code',
          hintStyle: Measurement.mediumFont
              .textStyle(AppColor.grey, Measurement.font400),
          border: InputBorder.none,
          contentPadding: Measurement.generalSize16.horizontalIsToVertical,
        ),
        onChanged: (_) {},
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
      await MockApiService.instance.deleteInventory(id);
      await _load();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted successfully.')),
      );
    }
  }

  Future<void> _load() async {
    final list =
        await MockApiService.instance.listInventories(query: _search.text);
    setState(() {
      _items = list;
    });
  }
}

class _WarehouseItem extends StatelessWidget {
  final InventoryModel warehouse;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _WarehouseItem(
      {required this.warehouse,
      required this.onTap,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        decoration: BoxDecoration(
          color: AppColor.blueCard,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(warehouse.name).mediumBold(AppColor.white),
                  Measurement.generalSize4.height,
                  Text(warehouse.code).smallNormal(AppColor.grey),
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: AppColor.grey),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: AppColor.grey),
            ),
          ],
        ),
      ),
    );
  }
}
