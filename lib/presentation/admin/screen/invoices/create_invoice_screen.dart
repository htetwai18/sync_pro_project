import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_line_item_model.dart';
import 'package:sync_pro/presentation/admin/widgets/invoice_line_item_tile.dart';
import 'package:sync_pro/presentation/shared/mock.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  String? _selectedCustomer;
  DateTime _invoiceDate = DateTime.now();
  DateTime? _dueDate;
  String _status = 'sent';
  final List<InvoiceLineItemModel> _items = [];
  List<CustomerModel> _customers = [];

  late InvoiceModel _draftInvoice = InvoiceModel(
    id: 'draft',
    invoiceDate: _formatDate(DateTime.now()),
    dueDate: '',
    amount: 0,
    status: 'draft',
    customer: mockCustomer,
    lineItems: const [],
  );

  double get _total => _items.fold(0, (p, e) => p + e.total);

  String _formatDate(DateTime d) =>
      '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    final list = await MockApiService.instance.listCustomers();
    setState(() {
      _customers = list;
      _selectedCustomer = _customers.isNotEmpty ? _customers.first.id : null;
    });
  }

  Future<void> _openLineItemDialog({int? editIndex}) async {
    final isEdit = editIndex != null;
    final existing = isEdit ? _items[editIndex] : null;
    final nameController = TextEditingController(text: existing?.name ?? '');
    final qtyController = TextEditingController(
        text: existing != null ? existing.quantity.toString() : '');
    final priceController = TextEditingController(
        text: existing != null ? existing.unitPrice.toStringAsFixed(2) : '');
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<InvoiceLineItemModel>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColor.background,
          shape: RoundedRectangleBorder(
            borderRadius: Measurement.generalSize12.allRadius,
          ),
          title: Center(
            child: Text(isEdit ? AppString.edit : AppString.addLineItem)
                .mediumBold(AppColor.white),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppString.nameLabel).mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                _field(TextFormField(
                  decoration: InputDecoration(
                      contentPadding:
                          Measurement.generalSize4.horizontalPadding),
                  style: TextStyle(color: AppColor.white),
                  controller: nameController,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? AppString.pleaseEnterName
                      : null,
                )),
                Measurement.generalSize12.height,
                Text(AppString.quantity).mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                _field(TextFormField(
                  decoration: InputDecoration(
                      contentPadding:
                          Measurement.generalSize4.horizontalPadding),
                  style: TextStyle(color: AppColor.white),
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    if (n == null || n <= 0)
                      return AppString.pleaseEnterQuantity;
                    return null;
                  },
                )),
                Measurement.generalSize12.height,
                Text(AppString.unitPrice).mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                _field(TextFormField(
                  decoration: InputDecoration(
                      contentPadding:
                          Measurement.generalSize4.horizontalPadding),
                  style: TextStyle(color: AppColor.white),
                  controller: priceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    final d = double.tryParse(v ?? '');
                    if (d == null || d < 0) return AppString.pleaseEnterAmount;
                    return null;
                  },
                )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppString.cancelButton),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.blueStatusInner,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final item = InvoiceLineItemModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text.trim(),
                    quantity: int.parse(qtyController.text.trim()),
                    unitPrice: double.parse(priceController.text.trim()),
                    invoice: _draftInvoice,
                  );
                  Navigator.pop(ctx, item);
                }
              },
              child: Text(
                  isEdit ? AppString.saveChangesButton : AppString.addLineItem),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        if (isEdit) {
          _items[editIndex as int] = result;
        } else {
          _items.add(result);
        }
      });
    }
  }

  Future<void> _confirmDelete(int index) async {
    final confirm = await showDialog<bool>(
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
              backgroundColor: AppColor.redStatusInner,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppString.delete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _items.removeAt(index));
    }
  }

  Widget _field(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.createInvoice, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invoice Date
            const Text(AppString.invoiceDate).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _invoiceDate,
                    firstDate: DateTime(now.year - 2),
                    lastDate: DateTime(now.year + 3),
                    builder: (context, child) =>
                        Theme(data: ThemeData.dark(), child: child!),
                  );
                  if (picked != null) setState(() => _invoiceDate = picked);
                },
                child: Padding(
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_invoiceDate.month.toString().padLeft(2, '0')}/${_invoiceDate.day.toString().padLeft(2, '0')}/${_invoiceDate.year}',
                        ).mediumNormal(AppColor.white),
                      ),
                      const Icon(Icons.calendar_today, color: AppColor.grey),
                    ],
                  ),
                ),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.selectCustomerLabel)
                .mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedCustomer,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                hint: const Text(AppString.selectCustomerHint)
                    .mediumNormal(AppColor.grey),
                items: _customers
                    .map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.name).smallNormal(AppColor.white),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCustomer = v),
              ),
            ),
            Measurement.generalSize16.height,
            // Status selector
            const Text(AppString.statusFilter).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                dropdownColor: AppColor.blueField,
                iconEnabledColor: AppColor.grey,
                items: const [
                  DropdownMenuItem(
                      value: 'draft',
                      child: Text(
                        'draft',
                        style: TextStyle(color: AppColor.white),
                      )),
                  DropdownMenuItem(
                      value: 'sent',
                      child: Text('sent',
                          style: TextStyle(color: AppColor.white))),
                ],
                onChanged: (v) => setState(() => _status = v ?? _status),
              ),
            ),
            Measurement.generalSize16.height,
            const Text(AppString.dueDateCreate).mediumBold(AppColor.white),
            Measurement.generalSize8.height,
            Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDate ?? now,
                    firstDate: DateTime(now.year - 1),
                    lastDate: DateTime(now.year + 3),
                    builder: (context, child) =>
                        Theme(data: ThemeData.dark(), child: child!),
                  );
                  if (picked != null) setState(() => _dueDate = picked);
                },
                child: Padding(
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dueDate == null
                              ? 'mm/dd/yyyy'
                              : '${_dueDate!.month.toString().padLeft(2, '0')}/${_dueDate!.day.toString().padLeft(2, '0')}/${_dueDate!.year}',
                        ).mediumNormal(AppColor.white),
                      ),
                      const Icon(Icons.calendar_today, color: AppColor.grey),
                    ],
                  ),
                ),
              ),
            ),
            Measurement.generalSize24.height,
            const Text(AppString.invoiceLineItems).mediumBold(AppColor.white),
            Measurement.generalSize12.height,
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: Measurement.generalSize12),
                child: InvoiceLineItemTile(
                  item: e,
                  onEdit: () => _openLineItemDialog(editIndex: index),
                  onDelete: () => _confirmDelete(index),
                ),
              );
            }),
            Container(
              width: double.infinity,
              padding: Measurement.generalSize16.horizontalIsToVertical,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: Measurement.generalSize12.allRadius,
                border: Border.all(
                    color: AppColor.greyPercentCircle,
                    style: BorderStyle.solid,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside),
              ),
              child: InkWell(
                onTap: () => _openLineItemDialog(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: AppColor.blueStatusInner),
                    Measurement.generalSize8.width,
                    const Text(AppString.addLineItem)
                        .mediumBold(AppColor.blueStatusInner),
                  ],
                ),
              ),
            ),
            Measurement.generalSize24.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppString.totalAmount).mediumBold(AppColor.white),
                Text('\$${_total.toStringAsFixed(2)}')
                    .xLargeBold(AppColor.white),
              ],
            ),
            Measurement.generalSize24.height,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueStatusInner,
                  foregroundColor: AppColor.white,
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                ),
                onPressed: () async {
                  final due = _dueDate != null ? _formatDate(_dueDate!) : '';
                  final created = _formatDate(_invoiceDate);
                  final payloadItems = _items
                      .map((e) => {
                            'name': e.name,
                            'quantity': e.quantity,
                            'unitPrice': e.unitPrice,
                          })
                      .toList();
                  final createdInvoice =
                      await MockApiService.instance.createInvoice(
                    customerId: _selectedCustomer ?? 'cust-0001',
                    status: _status,
                    invoiceDate: created,
                    dueDate: due,
                    items: payloadItems,
                  );
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invoice created: ${createdInvoice.id}'),
                    ),
                  );
                  Navigator.pop(context, true);
                },
                onLongPress: null,
                child: const Text(AppString.generateInvoice)
                    .mediumBold(AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
