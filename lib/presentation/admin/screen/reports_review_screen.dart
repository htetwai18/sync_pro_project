import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/report_item_display_model.dart';
import 'package:sync_pro/presentation/admin/widgets/report_list_item.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/screen/report_detail_screen.dart';

class ReportsReviewScreen extends StatefulWidget {
  const ReportsReviewScreen({super.key});

  @override
  State<ReportsReviewScreen> createState() => _ReportsReviewScreenState();
}

class _ReportsReviewScreenState extends State<ReportsReviewScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ReportItemDisplayModel> filtered = mockReports
        .where((e) =>
            e.title.toLowerCase().contains(_query.toLowerCase()) ||
            e.customer.toLowerCase().contains(_query.toLowerCase()) ||
            e.author.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.reportsToBeReviewed,
        icon: Icons.menu,
        onTap: () {

        },
      ),
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
                  hintText: AppString.searchReports,
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
              separatorBuilder: (_, __) => Divider(
                height: Measurement.generalSize16,
                color: AppColor.greyPercentCircle.withOpacity(0.2),
              ),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return ReportListItem(
                  item: item,
                  onTap: () {
                    Routing.transition(
                      context,
                      ReportDetailScreen(item: item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
