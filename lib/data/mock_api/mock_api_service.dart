import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_line_item_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'seed_loader.dart';

class MockApiService {
  MockApiService._internal() {
    _seed();
  }
  static final MockApiService instance = MockApiService._internal();

  // In-memory stores (raw JSON rows)
  final Map<String, Map<String, dynamic>> _customers = {};
  final Map<String, Map<String, dynamic>> _inventories = {};
  final Map<String, Map<String, dynamic>> _parts = {};
  final List<Map<String, dynamic>> _partInventory = [];
  final Map<String, Map<String, dynamic>> _invoices = {};
  final List<Map<String, dynamic>> _invoiceLineItems = [];

  void _seed() {
    for (final c in SeedLoader.loadCustomers()) {
      _customers[c['id'] as String] = c;
    }
    for (final w in SeedLoader.loadInventories()) {
      _inventories[w['id'] as String] = w;
    }
    for (final p in SeedLoader.loadParts()) {
      _parts[p['id'] as String] = p;
    }
    _partInventory.addAll(SeedLoader.loadPartInventory());
    for (final inv in SeedLoader.loadInvoices()) {
      _invoices[inv['id'] as String] = inv;
    }
    _invoiceLineItems.addAll(SeedLoader.loadInvoiceLineItems());
  }

  // ===== Parts =====
  Future<List<PartModel>> listParts({String query = ''}) async {
    final q = query.toLowerCase();
    final all = _parts.values.map(_buildPart).toList();
    return all
        .where((e) =>
            e.name.toLowerCase().contains(q) ||
            e.number.toLowerCase().contains(q))
        .toList();
  }

  Future<void> deletePart(String id) async {
    _parts.remove(id);
    _partInventory.removeWhere((pi) => pi['partId'] == id);
  }

  Future<PartModel> createPart({
    required String name,
    required String number,
    required String manufacturer,
    required double unitPrice,
    String? inventoryId,
    int? initialQuantity,
  }) async {
    final id = 'part-${DateTime.now().millisecondsSinceEpoch}';
    _parts[id] = {
      'id': id,
      'name': name,
      'number': number,
      'manufacturer': manufacturer,
      'unitPrice': unitPrice,
    };
    if (inventoryId != null && initialQuantity != null) {
      _partInventory.add({
        'partId': id,
        'inventoryId': inventoryId,
        'quantityOnHand': initialQuantity,
      });
    }
    return _buildPart(_parts[id]!);
  }

  Future<PartModel> updatePart({
    required String id,
    String? name,
    String? number,
    String? manufacturer,
    double? unitPrice,
  }) async {
    final row = _parts[id];
    if (row == null) {
      throw StateError('Part not found');
    }
    if (name != null) row['name'] = name;
    if (number != null) row['number'] = number;
    if (manufacturer != null) row['manufacturer'] = manufacturer;
    if (unitPrice != null) row['unitPrice'] = unitPrice;
    return _buildPart(row);
  }

  Future<void> setPartInventoryQuantity({
    required String partId,
    required String inventoryId,
    required int quantity,
  }) async {
    final idx = _partInventory.indexWhere(
        (pi) => pi['partId'] == partId && pi['inventoryId'] == inventoryId);
    if (idx >= 0) {
      _partInventory[idx]['quantityOnHand'] = quantity;
    } else {
      _partInventory.add({
        'partId': partId,
        'inventoryId': inventoryId,
        'quantityOnHand': quantity,
      });
    }
  }

  PartModel _buildPart(Map<String, dynamic> row) {
    final partId = row['id'] as String;
    final shallow = PartModel(
      id: partId,
      name: row['name'] as String,
      number: row['number'] as String,
      manufacturer: row['manufacturer'] as String,
      unitPrice: (row['unitPrice'] as num).toDouble(),
      stockLevels: const [],
    );
    final levels = _partInventory
        .where((pi) => pi['partId'] == partId)
        .map((pi) => PartInventoryModel(
              quantityOnHand: pi['quantityOnHand'] as int,
              part: shallow,
              location: _buildInventory(_inventories[pi['inventoryId']]!),
            ))
        .toList();
    return PartModel(
      id: shallow.id,
      name: shallow.name,
      number: shallow.number,
      manufacturer: shallow.manufacturer,
      unitPrice: shallow.unitPrice,
      stockLevels: levels,
    );
  }

  // ===== Inventories =====
  Future<List<InventoryModel>> listInventories({String query = ''}) async {
    final q = query.toLowerCase();
    final all = _inventories.values.map(_buildInventory).toList();
    return all
        .where((w) =>
            w.name.toLowerCase().contains(q) ||
            w.code.toLowerCase().contains(q))
        .toList();
  }

  Future<void> deleteInventory(String id) async {
    _inventories.remove(id);
    _partInventory.removeWhere((pi) => pi['inventoryId'] == id);
  }

  Future<InventoryModel> createInventory({
    required String name,
    required String code,
    String? contactName,
    String? contactPhone,
    bool isActive = true,
  }) async {
    final id = 'wh-${DateTime.now().millisecondsSinceEpoch}';
    _inventories[id] = {
      'id': id,
      'name': name,
      'code': code,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'isActive': isActive,
      'createdAt': DateTime.now().toIso8601String(),
    };
    return _buildInventory(_inventories[id]!);
  }

  Future<InventoryModel> updateInventory({
    required String id,
    String? name,
    String? code,
    String? contactName,
    String? contactPhone,
    bool? isActive,
  }) async {
    final row = _inventories[id];
    if (row == null) throw StateError('Inventory not found');
    if (name != null) row['name'] = name;
    if (code != null) row['code'] = code;
    if (contactName != null) row['contactName'] = contactName;
    if (contactPhone != null) row['contactPhone'] = contactPhone;
    if (isActive != null) row['isActive'] = isActive;
    return _buildInventory(row);
  }

  InventoryModel _buildInventory(Map<String, dynamic> row) {
    return InventoryModel(
      id: row['id'] as String,
      name: row['name'] as String,
      code: row['code'] as String,
      contactName: row['contactName'] as String?,
      contactPhone: row['contactPhone'] as String?,
      isActive: (row['isActive'] as bool?) ?? true,
      createdAt: DateTime.tryParse(row['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt: null,
    );
  }

  // ===== Invoices =====
  Future<List<InvoiceModel>> listInvoices({String? status}) async {
    final items = _invoices.values.map(_buildInvoice).toList();
    if (status == null || status.toLowerCase() == 'all') return items;
    return items
        .where((e) => e.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  Future<void> deleteInvoice(String id) async {
    _invoices.remove(id);
    _invoiceLineItems.removeWhere((li) => li['invoiceId'] == id);
  }

  InvoiceModel _buildInvoice(Map<String, dynamic> row) {
    final customer = _buildCustomer(_customers[row['customerId']]!);
    final invId = row['id'] as String;
    final lines = _invoiceLineItems
        .where((li) => li['invoiceId'] == invId)
        .map((li) => InvoiceLineItemModel(
              id: li['id'] as String,
              name: li['name'] as String,
              quantity: li['quantity'] as int,
              unitPrice: (li['unitPrice'] as num).toDouble(),
              invoice: InvoiceModel(
                id: invId,
                dueDate: row['dueDate'] as String,
                amount: (row['amount'] as num).toDouble(),
                status: row['status'] as String,
                invoiceDate: row['invoiceDate'] as String,
                customer: customer,
                lineItems: const [],
              ),
            ))
        .toList();

    return InvoiceModel(
      id: invId,
      dueDate: row['dueDate'] as String,
      amount: (row['amount'] as num).toDouble(),
      status: row['status'] as String,
      invoiceDate: row['invoiceDate'] as String,
      customer: customer,
      lineItems: lines,
    );
  }

  CustomerModel _buildCustomer(Map<String, dynamic> row) {
    return CustomerModel(
      id: row['id'] as String,
      name: row['name'] as String,
      phone: row['phone'] as String,
      email: row['email'] as String,
    );
  }
}
