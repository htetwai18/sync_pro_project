import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_line_item_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';
import 'seed_loader.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/report_item_display_model.dart';

class MockApiService {
  MockApiService._internal() {
    _seed();
  }
  static final MockApiService instance = MockApiService._internal();

  // In-memory stores (raw JSON rows)
  final Map<String, Map<String, dynamic>> _customers = {};
  final Map<String, Map<String, dynamic>> _users = {};
  final Map<String, Map<String, dynamic>> _buildings = {};
  final Map<String, Map<String, dynamic>> _assets = {};
  final Map<String, Map<String, dynamic>> _inventories = {};
  final Map<String, Map<String, dynamic>> _parts = {};
  final List<Map<String, dynamic>> _partInventory = [];
  final Map<String, Map<String, dynamic>> _invoices = {};
  final List<Map<String, dynamic>> _invoiceLineItems = [];
  final Map<String, Map<String, dynamic>> _tasks = {};
  final Map<String, Map<String, dynamic>> _reports = {};

  void _seed() {
    for (final c in SeedLoader.loadCustomers()) {
      _customers[c['id'] as String] = c;
    }
    for (final u in SeedLoader.loadUsers()) {
      _users[u['id'] as String] = u;
    }
    for (final b in SeedLoader.loadBuildings()) {
      _buildings[b['id'] as String] = b;
    }
    for (final a in SeedLoader.loadAssets()) {
      _assets[a['id'] as String] = a;
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

    for (final t in SeedLoader.loadTasks()) {
      _tasks[t['id'] as String] = t;
    }
    for (final r in SeedLoader.loadReports()) {
      _reports[r['id'] as String] = r;
    }
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

  Future<InvoiceModel> updateInvoiceStatus(String id, String status) async {
    final row = _invoices[id];
    if (row == null) throw StateError('Invoice not found');
    row['status'] = status;
    return _buildInvoice(row);
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

  Future<InvoiceModel> createInvoice({
    required String customerId,
    required String status,
    required String invoiceDate,
    required String dueDate,
    required List<Map<String, dynamic>> items, // {name, quantity, unitPrice}
  }) async {
    final id = 'inv-${DateTime.now().millisecondsSinceEpoch}';
    final amount = items.fold<double>(
        0.0,
        (p, e) =>
            p + (e['quantity'] as int) * (e['unitPrice'] as num).toDouble());
    _invoices[id] = {
      'id': id,
      'invoiceDate': invoiceDate,
      'dueDate': dueDate,
      'amount': amount,
      'status': status,
      'customerId': customerId,
    };
    for (final it in items) {
      _invoiceLineItems.add({
        'id':
            'li-${DateTime.now().microsecondsSinceEpoch}-${_invoiceLineItems.length}',
        'invoiceId': id,
        'name': it['name'],
        'quantity': it['quantity'],
        'unitPrice': it['unitPrice'],
      });
    }
    return _buildInvoice(_invoices[id]!);
  }
}

// ======== TASKS & REPORTS ========
extension TasksApi on MockApiService {
  Future<List<TaskOrRequestedServiceModel>> listTasks({String? status}) async {
    final list = _tasks.values.map(_buildTask).toList();
    if (status == null || status.toLowerCase() == 'all') return list;
    return list
        .where((t) => t.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  Future<TaskOrRequestedServiceModel> getTask(String id) async {
    final row = _tasks[id];
    if (row == null) throw StateError('Task not found');
    return _buildTask(row);
  }

  Future<TaskOrRequestedServiceModel> createTask({
    required String customerId,
    required String buildingId,
    required String assetId,
    required String title,
    required String description,
    required String type,
    required String priority,
    required DateTime requestDate,
    String status = 'pending',
    String? assignedToId,
    DateTime? scheduledDate,
  }) async {
    final id = 'task-${DateTime.now().millisecondsSinceEpoch}';
    _tasks[id] = {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'type': type,
      'priority': priority,
      'requestDate': requestDate.toIso8601String(),
      'completedDate': null,
      'preferredDate': requestDate.toIso8601String(),
      'preferredTime': '10:00',
      'notes': '',
      'specialInstructions': '',
      'assignedDate':
          assignedToId != null ? DateTime.now().toIso8601String() : null,
      'scheduledDate': scheduledDate?.toIso8601String(),
      'customerId': customerId,
      'buildingId': buildingId,
      'assetId': assetId,
      'createdById': _users.keys.first,
      'assignedToId': assignedToId,
      'reportId': null,
    };
    return _buildTask(_tasks[id]!);
  }

  Future<TaskOrRequestedServiceModel> updateTaskStatus(
      String id, String status) async {
    final row = _tasks[id];
    if (row == null) throw StateError('Task not found');
    row['status'] = status;
    if (status == 'completed') {
      row['completedDate'] = DateTime.now().toIso8601String();
    }
    return _buildTask(row);
  }

  Future<TaskOrRequestedServiceModel> assignTask(
      String id, String userId) async {
    final row = _tasks[id];
    if (row == null) throw StateError('Task not found');
    row['assignedToId'] = userId;
    row['assignedDate'] = DateTime.now().toIso8601String();
    return _buildTask(row);
  }

  Future<TaskOrRequestedServiceModel> scheduleTask(
      String id, DateTime when) async {
    final row = _tasks[id];
    if (row == null) throw StateError('Task not found');
    row['scheduledDate'] = when.toIso8601String();
    return _buildTask(row);
  }

  Future<void> deleteTask(String id) async {
    _tasks.remove(id);
    _reports.removeWhere((_, r) => r['taskId'] == id);
  }

  TaskOrRequestedServiceModel _buildTask(Map<String, dynamic> row) {
    final customer = _buildCustomer(_customers[row['customerId']]!);
    final building = _buildBuilding(_buildings[row['buildingId']]!, customer);
    final asset = _buildAsset(_assets[row['assetId']]!, building);
    final createdBy = _buildUser(_users[row['createdById']]!);
    final assignedTo = row['assignedToId'] != null
        ? _buildUser(_users[row['assignedToId']]!)
        : null;
    final report = row['reportId'] != null
        ? _buildReport(_reports[row['reportId']]!)
        : null;

    return TaskOrRequestedServiceModel(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String,
      status: row['status'] as String,
      type: row['type'] as String,
      priority: row['priority'] as String,
      requestDate: DateTime.parse(row['requestDate'] as String),
      completedDate: row['completedDate'] != null
          ? DateTime.tryParse(row['completedDate'] as String)
          : null,
      preferredDate:
          DateTime.tryParse(row['preferredDate'] as String) ?? DateTime.now(),
      preferredTime: row['preferredTime'] as String? ?? '10:00',
      notes: row['notes'] as String? ?? '',
      specialInstructions: row['specialInstructions'] as String? ?? '',
      assignedDate: row['assignedDate'] != null
          ? DateTime.tryParse(row['assignedDate'] as String)
          : null,
      scheduledDate: row['scheduledDate'] != null
          ? DateTime.tryParse(row['scheduledDate'] as String)
          : null,
      customer: customer,
      building: building,
      asset: asset,
      createdBy: createdBy,
      assignedTo: assignedTo,
      report: report,
      parts: const [],
    );
  }

  UserModel _buildUser(Map<String, dynamic> row) {
    return UserModel(
      id: row['id'] as String,
      name: row['name'] as String,
      phone: row['phone'] as String,
      email: row['email'] as String,
      role: row['role'] as String,
    );
  }

  BuildingModel _buildBuilding(
      Map<String, dynamic> row, CustomerModel customer) {
    return BuildingModel(
      id: row['id'] as String,
      name: row['name'] as String,
      address: row['address'] as String,
      roomNumber: row['roomNumber'] as String?,
      customer: customer,
    );
  }

  AssetModel _buildAsset(Map<String, dynamic> row, BuildingModel building) {
    return AssetModel(
      id: row['id'] as String,
      name: row['name'] as String,
      manufacturer: row['manufacturer'] as String,
      model: row['model'] as String,
      installationDate: row['installationDate'] != null
          ? DateTime.tryParse(row['installationDate'] as String)
          : null,
      building: building,
    );
  }

  ReportModel _buildReport(Map<String, dynamic> row) {
    final task = _buildTask(_tasks[row['taskId']]!);
    final submittedBy = _buildUser(_users[row['submittedById']]!);
    final reviewedBy = row['reviewedById'] != null
        ? _buildUser(_users[row['reviewedById']]!)
        : null;
    return ReportModel(
      id: row['id'] as String,
      title: row['title'] as String,
      submittedDate: row['submittedDate'] as String,
      approvedDate: row['approvedDate'] as String?,
      content: row['content'] as String,
      attachmentUrl: row['attachmentUrl'] as String?,
      status: row['status'] as String,
      task: task,
      submittedBy: submittedBy,
      reviewedBy: reviewedBy,
    );
  }
}

// ======== LOOKUPS ========
extension LookupsApi on MockApiService {
  Future<List<CustomerModel>> listCustomers() async {
    return _customers.values.map(_buildCustomer).toList();
  }

  Future<List<BuildingModel>> listBuildings(String customerId) async {
    final rows = _buildings.values.where((b) => b['customerId'] == customerId);
    final customer = _buildCustomer(_customers[customerId]!);
    return rows.map((r) => _buildBuilding(r, customer)).toList();
  }

  Future<List<AssetModel>> listAssets(String buildingId) async {
    final rows = _assets.values.where((a) => a['buildingId'] == buildingId);
    final bRow = _buildings[buildingId]!;
    final customer = _buildCustomer(_customers[bRow['customerId']]!);
    final building = _buildBuilding(bRow, customer);
    return rows.map((r) => _buildAsset(r, building)).toList();
  }

  Future<List<UserModel>> listUsers({String? role}) async {
    final all = _users.values.map(_buildUser).toList();
    if (role == null) return all;
    return all
        .where((u) => (u.role).toLowerCase() == role.toLowerCase())
        .toList();
  }
}
