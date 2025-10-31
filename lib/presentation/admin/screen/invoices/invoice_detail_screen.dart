import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
// enum colors are used indirectly via list screen; not needed here
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_line_item_model.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final bool isCustomer;
  final InvoiceModel invoice;

  const InvoiceDetailScreen(
      {super.key, required this.invoice, this.isCustomer = false});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  late InvoiceModel _invoice;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _invoice = widget.invoice;
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = _invoice.lineItems.fold(0, (p, e) => p + e.total);
    final double taxPercent = 0;
    final double tax = subtotal * (taxPercent / 100);
    final double total = subtotal + tax;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _changed);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.background,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.white),
            onPressed: () => Navigator.pop(context, _changed),
          ),
          title: Text('${AppString.invoice} #${_invoice.id}')
              .largeBold(AppColor.white),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: Measurement.generalSize16.horizontalIsToVertical,
          child: Column(
            children: [
              // Header card
              Container(
                width: double.infinity,
                padding: Measurement.generalSize16.horizontalIsToVertical,
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppString.invoice} #${_invoice.id}')
                        .xLargeBold(AppColor.white),
                    Measurement.generalSize4.height,
                    Text(_invoice.customer.name).smallNormal(AppColor.grey),
                    Measurement.generalSize16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(AppString.unpaid).smallNormal(AppColor.white),
                            Measurement.generalSize4.height,
                            Text(AppString.amountDue)
                                .smallNormal(AppColor.grey),
                          ],
                        ),
                        Text('\$${_invoice.amount.toStringAsFixed(2)}')
                            .xLargeBold(AppColor.white),
                      ],
                    ),
                  ],
                ),
              ),

              Measurement.generalSize16.height,
              // Dates row
              Container(
                padding: Measurement.generalSize16.horizontalIsToVertical,
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _KV(
                        k: AppString.invoiceDate,
                        v: _invoice.invoiceDate,
                      ),
                    ),
                    Expanded(
                      child: _KV(
                        k: AppString.dueDateLabel,
                        v: _invoice.dueDate,
                      ),
                    ),
                  ],
                ),
              ),

              Measurement.generalSize16.height,
              // Line items
              Container(
                width: double.infinity,
                padding: Measurement.generalSize16.horizontalIsToVertical,
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppString.lineItems).mediumBold(AppColor.white),
                    Measurement.generalSize16.height,
                    ..._invoice.lineItems.map((e) => _LineItemRow(item: e)),
                    Divider(
                        height: 1,
                        color: AppColor.greyPercentCircle.withOpacity(0.2)),
                    Measurement.generalSize12.height,
                    _AmountRow(label: AppString.subtotal, value: subtotal),
                    _AmountRow(
                        label:
                            '${AppString.tax} (${taxPercent.toStringAsFixed(0)}%)',
                        value: tax),
                    const SizedBox(height: 8),
                    _AmountRow(
                        label: AppString.total, value: total, bold: true),
                  ],
                ),
              ),

              Measurement.generalSize16.height,
              if (!widget.isCustomer)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.blueStatusInner,
                          foregroundColor: AppColor.white,
                          padding:
                              Measurement.generalSize16.horizontalIsToVertical,
                          shape: RoundedRectangleBorder(
                            borderRadius: Measurement.generalSize12.allRadius,
                          ),
                        ),
                        onPressed: () async {
                          final updated = await MockApiService.instance
                              .updateInvoiceStatus(_invoice.id, 'paid');
                          setState(() {
                            _invoice = updated;
                            _changed = true;
                          });
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Marked as paid.')),
                          );
                        },
                        child: const Text(AppString.markAsPaid)
                            .mediumBold(AppColor.white),
                      ),
                    ),
                    Measurement.generalSize16.width,
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: AppColor.greyPercentCircle),
                          foregroundColor: AppColor.white,
                          backgroundColor: AppColor.blueField,
                          padding:
                              Measurement.generalSize16.horizontalIsToVertical,
                          shape: RoundedRectangleBorder(
                            borderRadius: Measurement.generalSize12.allRadius,
                          ),
                        ),
                        onPressed: () async {
                          final updated = await MockApiService.instance
                              .updateInvoiceStatus(_invoice.id, 'voided');
                          setState(() {
                            _invoice = updated;
                            _changed = true;
                          });
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invoice voided.')),
                          );
                        },
                        child: const Text(AppString.voidInvoice)
                            .mediumBold(AppColor.white),
                      ),
                    ),
                  ],
                ),
              if (widget.isCustomer)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blueStatusInner,
                    foregroundColor: AppColor.white,
                    padding: Measurement.generalSize16.horizontalIsToVertical,
                    shape: RoundedRectangleBorder(
                      borderRadius: Measurement.generalSize12.allRadius,
                    ),
                  ),
                  onPressed: () {},
                  child:
                      const Text(AppString.payNow).mediumBold(AppColor.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KV extends StatelessWidget {
  final String k;
  final String v;
  const _KV({required this.k, required this.v});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(k).smallNormal(AppColor.grey),
        Measurement.generalSize4.height,
        Text(v).mediumBold(AppColor.white),
      ],
    );
  }
}

class _LineItemRow extends StatelessWidget {
  final InvoiceLineItemModel item;
  const _LineItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Measurement.generalSize8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name).mediumNormal(AppColor.white),
                Measurement.generalSize4.height,
                Text('x ${item.unitPrice.toStringAsFixed(2)}')
                    .smallNormal(AppColor.grey),
              ],
            ),
          ),
          Text('${item.quantity} x').smallNormal(AppColor.grey),
          Measurement.generalSize16.width,
          Text('\$${item.total.toStringAsFixed(2)}').mediumBold(AppColor.white),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;
  const _AmountRow(
      {required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Measurement.generalSize8),
      child: Row(
        children: [
          Expanded(child: Text(label).smallNormal(AppColor.grey)),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: (bold ? Measurement.largeFont : Measurement.mediumFont)
                .textStyle(AppColor.white,
                    bold ? Measurement.font600 : Measurement.font400),
          ),
        ],
      ),
    );
  }
}
