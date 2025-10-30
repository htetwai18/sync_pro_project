import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/presentation/admin/widgets/invoice_list_item.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/screen/invoice_detail_screen.dart';

class InvoicesCustomerScreen extends StatefulWidget {
  const InvoicesCustomerScreen({super.key});

  @override
  State<InvoicesCustomerScreen> createState() => _InvoicesCustomerScreenState();
}

class _InvoicesCustomerScreenState extends State<InvoicesCustomerScreen> {
  String _statusFilter = AppString.all;
  String _dateRange = AppString.all;

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with repository/API once available. Using empty list to compile.
    final List<InvoiceModel> all = [];
    final List<InvoiceModel> filtered = all.where((e) {
      if (_statusFilter == AppString.all) return true;
      return e.status.toLowerCase() == _statusFilter.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
          context: context, title: AppString.invoices, canBack: false),
      // drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: Row(
              children: [
                _FilterChip(
                  label: AppString.statusFilter,
                  value: _statusFilter,
                  onTap: () async {
                    final value =
                        await _showStatusSheet(context, _statusFilter);
                    if (value != null) setState(() => _statusFilter = value);
                  },
                ),
                Measurement.generalSize16.width,
                _FilterChip(
                  label: AppString.dateRange,
                  value: _dateRange,
                  onTap: () async {
                    final value =
                        await _showDateRangeSheet(context, _dateRange);
                    if (value != null) setState(() => _dateRange = value);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: AppColor.greyPercentCircle.withOpacity(0.2),
              ),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return InvoiceListItem(
                  item: item,
                  onTap: () {
                    Routing.transition(
                      context,
                      InvoiceDetailScreen(
                        invoice: item,
                        isCustomer: true,
                      ),
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

  Future<String?> _showStatusSheet(BuildContext context, String current) async {
    final options = [
      AppString.all,
      'paid',
      'sent',
      'draft',
      'voided',
      'due',
      'overdue'
    ];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColor.blueField,
      shape: RoundedRectangleBorder(
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: options
            .map((e) => ListTile(
                  title: Text(e).mediumNormal(AppColor.white),
                  trailing: current == e
                      ? const Icon(Icons.check, color: AppColor.white)
                      : null,
                  onTap: () => Navigator.pop(context, e),
                ))
            .toList(),
      ),
    );
  }

  Future<String?> _showDateRangeSheet(
      BuildContext context, String current) async {
    final options = [
      AppString.all,
      AppString.last7Days,
      AppString.last30Days,
      AppString.thisYear
    ];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColor.blueField,
      shape: RoundedRectangleBorder(
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: options
            .map((e) => ListTile(
                  title: Text(e).mediumNormal(AppColor.white),
                  trailing: current == e
                      ? const Icon(Icons.check, color: AppColor.white)
                      : null,
                  onTap: () => Navigator.pop(context, e),
                ))
            .toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Measurement.generalSize16,
          vertical: Measurement.generalSize12,
        ),
        decoration: BoxDecoration(
          color: AppColor.blueStatusOuter,
          borderRadius: Measurement.generalSize24.allRadius,
        ),
        child: Row(
          children: [
            Text(label).mediumNormal(AppColor.white),
            Measurement.generalSize8.width,
            const Icon(
              Icons.filter_list_outlined,
              color: AppColor.white,
              size: Measurement.generalSize20,
            ),
          ],
        ),
      ),
    );
  }
}
