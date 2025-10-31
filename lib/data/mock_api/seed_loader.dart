import 'dart:convert';

class SeedLoader {
  static List<Map<String, dynamic>> loadCustomers() =>
      (json.decode(_customersJson) as List).cast<Map<String, dynamic>>();

  static List<Map<String, dynamic>> loadInventories() =>
      (json.decode(_inventoriesJson) as List).cast<Map<String, dynamic>>();

  static List<Map<String, dynamic>> loadParts() =>
      (json.decode(_partsJson) as List).cast<Map<String, dynamic>>();

  static List<Map<String, dynamic>> loadPartInventory() =>
      (json.decode(_partInventoryJson) as List).cast<Map<String, dynamic>>();

  static List<Map<String, dynamic>> loadInvoices() =>
      (json.decode(_invoicesJson) as List).cast<Map<String, dynamic>>();

  static List<Map<String, dynamic>> loadInvoiceLineItems() =>
      (json.decode(_invoiceLineItemsJson) as List).cast<Map<String, dynamic>>();

  static const String _customersJson = '''
  [
    {"id":"cust-0001","name":"Acme Corp","phone":"+1 555-0100","email":"ops@acme.example"}
  ]
  ''';

  static const String _inventoriesJson = '''
  [
    {"id":"wh-0001","name":"Main Warehouse","code":"MWH","contactName":"Jane Doe","contactPhone":"+1 555-1111","isActive":true,"createdAt":"2024-01-01T00:00:00.000Z"},
    {"id":"wh-0002","name":"Engineer Van 5","code":"VAN-5","contactName":"Van Manager","contactPhone":"+1 555-2222","isActive":true,"createdAt":"2024-01-15T00:00:00.000Z"}
  ]
  ''';

  static const String _partsJson = '''
  [
    {"id":"part-0001","name":"Widget A","number":"#12345","manufacturer":"FluidTech","unitPrice":250.0},
    {"id":"part-0002","name":"Widget B","number":"#12344","manufacturer":"FluidTech","unitPrice":275.0}
  ]
  ''';

  static const String _partInventoryJson = '''
  [
    {"partId":"part-0001","inventoryId":"wh-0001","quantityOnHand":50},
    {"partId":"part-0001","inventoryId":"wh-0002","quantityOnHand":10},
    {"partId":"part-0002","inventoryId":"wh-0002","quantityOnHand":5}
  ]
  ''';

  static const String _invoicesJson = '''
  [
    {"id":"inv-0001","invoiceDate":"2025-07-26","dueDate":"2025-08-10","amount":250.0,"status":"sent","customerId":"cust-0001"}
  ]
  ''';

  static const String _invoiceLineItemsJson = '''
  [
    {"id":"li-1","invoiceId":"inv-0001","name":"Labor for task","quantity":2,"unitPrice":100.0},
    {"id":"li-2","invoiceId":"inv-0001","name":"Daikin AC Filter","quantity":1,"unitPrice":50.0}
  ]
  ''';
}
