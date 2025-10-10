import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/app_drawer.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/screen/add_customer_screen.dart';
import 'package:sync_pro/presentation/admin/widgets/customer_list_item.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = mockCustomers
        .where((c) =>
            c.name.toLowerCase().contains(_query.toLowerCase()) ||
            c.phone.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBarWithDrawer(context: context, title: AppString.customers),
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
                controller: _searchController,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.searchCustomers,
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
              separatorBuilder: (_, __) => Measurement.generalSize12.height,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return CustomerListItem(
                    item: item,
                    onTap: () {
                      Routing.transition(context, const AddCustomerScreen());
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.blueStatusInner,
        foregroundColor: AppColor.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
