import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_drawer.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/presentation/admin/screen/warehouses/create_edit_warehouse_screen.dart';
import 'package:sync_pro/presentation/shared/mock.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';

class WarehousesScreen extends StatefulWidget {
  const WarehousesScreen({super.key});

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Derive unique inventories from part stock levels (mock data source)
    final List<InventoryModel> items = {
      for (final level in mockParts.expand(
          (PartModel p) => (p.stockLevels ?? const <PartInventoryModel>[])))
        level.location.id: level.location
    }.values.toList();

    final filtered = items
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
          if (created == true) setState(() {});
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
                      if (updated == true) setState(() {});
                    },
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
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}

class _WarehouseItem extends StatelessWidget {
  final InventoryModel warehouse;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  const _WarehouseItem(
      {required this.warehouse, required this.onTap, required this.onEdit});

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
          ],
        ),
      ),
    );
  }
}
