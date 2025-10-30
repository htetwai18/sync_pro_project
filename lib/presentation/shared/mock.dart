import 'package:flutter/material.dart';
import 'package:sync_pro/presentation/admin/display_models/approval_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/contact_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_line_item_model.dart';
import 'package:sync_pro/presentation/admin/display_models/report_item_display_model.dart';

/// Sample data to populate the list
/// will replace from api fetch later
List<ApprovalItemDisplayModel> approvalItems = const [
  ApprovalItemDisplayModel(
    title: 'New Building',
    submittedBy: 'Sarah Miller',
    icon: Icons.corporate_fare,
    buildingName: 'Corporate Headquarters',
    buildingRoomNumber: '1402',
    assetType: 'HVAC Unit',
    assetDescription: 'Model #ABC-123, Serial #XYZ-987',
    statusText: 'Pending Approval',
    dateAdded: '2024-07-22',
    lastUpdated: '2024-07-22',
  ),
  ApprovalItemDisplayModel(
    title: 'New Building',
    submittedBy: 'David Chen',
    icon: Icons.meeting_room,
    buildingName: 'West Campus',
    buildingRoomNumber: 'B12',
    assetType: 'Building',
    assetDescription: 'Conference room renovation',
    statusText: 'Pending Approval',
    dateAdded: '2024-07-21',
    lastUpdated: '2024-07-22',
  ),
  ApprovalItemDisplayModel(
    title: 'New Asset',
    submittedBy: 'Emily Carter',
    icon: Icons.inventory_2,
    buildingName: 'R&D Center',
    buildingRoomNumber: '220',
    assetType: '3D Printer',
    assetDescription: 'Model Mark X7',
    statusText: 'Pending Approval',
    dateAdded: '2024-07-20',
    lastUpdated: '2024-07-21',
  ),
];

// Public, fully-populated mocks
final CustomerModel mockCustomer = _bundle.customer;
final List<BuildingModel> mockBuildings = _bundle.buildings;
final List<AssetModel> mockAssets = _bundle.assets;
final List<ContactModel> mockContacts = _bundle.contacts;
final List<InventoryModel> mockInventories = _bundle.inventories;
final List<PartModel> mockParts = _bundle.parts;
final List<InvoiceModel> mockInvoices = _bundle.invoices;
final List<TaskOrRequestedServiceModel> mockTasks = _bundle.tasks;

const UserModel mockAdmin = UserModel(
  id: 'user-admin-0001',
  name: 'Admin One',
  phone: '+1 555-0000',
  email: 'admin@syncpro.test',
  role: 'admin',
  department: 'Operations',
  specialization: 'Administration',
  hireDate: '2022-01-01',
);
const UserModel mockEngineer = UserModel(
  id: 'user-eng-0002',
  name: 'Alice Engineer',
  phone: '+1 555-9999',
  email: 'alice@syncpro.test',
  role: 'engineer',
  department: 'Field Service',
  specialization: 'HVAC',
  hireDate: '2023-05-15',
);

class _MockBundle {
  final CustomerModel customer;
  final List<BuildingModel> buildings;
  final List<AssetModel> assets;
  final List<ContactModel> contacts;
  final List<InventoryModel> inventories;
  final List<PartModel> parts;
  final List<InvoiceModel> invoices;
  final List<TaskOrRequestedServiceModel> tasks;
  const _MockBundle({
    required this.customer,
    required this.buildings,
    required this.assets,
    required this.contacts,
    required this.inventories,
    required this.parts,
    required this.invoices,
    required this.tasks,
  });
}

_MockBundle _buildMocks() {
  // Stage A: base instances without back-references
  final baseCustomer = const CustomerModel(
    id: 'cust-0001',
    name: 'Acme Corp',
    phone: '+1 555-0100',
    email: 'ops@acme.example',
  );

  final inv1 = InventoryModel(
    id: 'wh-0001',
    name: 'Main Warehouse',
    code: 'MWH',
    contactName: 'Jane Doe',
    contactPhone: '+1 555-1111',
    isActive: true,
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 6, 1),
  );

  final inv2 = InventoryModel(
    id: 'wh-0002',
    name: 'Engineer Van 5',
    code: 'VAN-5',
    contactName: 'Van Manager',
    contactPhone: '+1 555-2222',
    isActive: true,
    createdAt: DateTime(2024, 1, 15),
    updatedAt: DateTime(2024, 6, 1),
  );

  final bldg1 = BuildingModel(
    id: 'bldg-hq-0001',
    name: 'Headquarters',
    address: '123 Main St, San Francisco',
    roomNumber: 'R001',
    customer: baseCustomer,
  );
  final bldg2 = BuildingModel(
    id: 'bldg-east-0002',
    name: 'East Wing',
    address: '456 Oak Ave, San Francisco',
    customer: baseCustomer,
  );

  // Stage B: assets referencing final buildings (we will rebuild buildings with assets)
  // We will create provisional assets first pointing to bldg1, then recreate with final buildings
  // After buildings_final are created, assets_final will reference the final building instances

  // Parts referencing inventories
  final part1 = PartModel(
    id: 'part-0001',
    name: 'Widget A',
    number: '#12345',
    manufacturer: 'FluidTech',
    unitPrice: 250.0,
    stockLevels: [
      PartInventoryModel(
          quantityOnHand: 10,
          part: const PartModel(
              id: 'part-0001',
              name: 'Widget A',
              number: '#12345',
              manufacturer: 'FluidTech',
              unitPrice: 250.0),
          location: inv2),
      PartInventoryModel(
          quantityOnHand: 50,
          part: const PartModel(
              id: 'part-0001',
              name: 'Widget A',
              number: '#12345',
              manufacturer: 'FluidTech',
              unitPrice: 250.0),
          location: inv1),
    ],
  );
  final part2 = PartModel(
    id: 'part-0002',
    name: 'Widget B',
    number: '#12344',
    manufacturer: 'FluidTech',
    unitPrice: 275.0,
    stockLevels: [
      PartInventoryModel(
          quantityOnHand: 5,
          part: const PartModel(
              id: 'part-0002',
              name: 'Widget B',
              number: '#12344',
              manufacturer: 'FluidTech',
              unitPrice: 275.0),
          location: inv2),
    ],
  );

  // Final buildings with assets
  final asset1 = AssetModel(
    id: 'asset-ac-0001',
    name: 'Daikin AC Unit',
    manufacturer: 'Daikin',
    model: 'DX-2000',
    installationDate: DateTime(2024, 5, 10),
    building: bldg1,
  );
  final asset2 = AssetModel(
    id: 'asset-gen-0002',
    name: 'Honda GX390 Generator',
    manufacturer: 'Honda',
    model: 'GX390',
    installationDate: DateTime(2024, 3, 3),
    building: bldg1,
  );
  final buildingsFinal = <BuildingModel>[
    BuildingModel(
      id: bldg1.id,
      name: bldg1.name,
      address: bldg1.address,
      roomNumber: bldg1.roomNumber,
      customer: baseCustomer,
      assets: [asset1, asset2],
    ),
    BuildingModel(
      id: bldg2.id,
      name: bldg2.name,
      address: bldg2.address,
      customer: baseCustomer,
      assets: const [],
    ),
  ];
  // Recreate assets to reference final building instances
  final asset1Final = AssetModel(
    id: asset1.id,
    name: asset1.name,
    manufacturer: asset1.manufacturer,
    model: asset1.model,
    installationDate: asset1.installationDate,
    building: buildingsFinal.first,
  );
  final asset2Final = AssetModel(
    id: asset2.id,
    name: asset2.name,
    manufacturer: asset2.manufacturer,
    model: asset2.model,
    installationDate: asset2.installationDate,
    building: buildingsFinal.first,
  );
  final buildingsReallyFinal = <BuildingModel>[
    BuildingModel(
      id: bldg1.id,
      name: bldg1.name,
      address: bldg1.address,
      roomNumber: bldg1.roomNumber,
      customer: baseCustomer,
      assets: [asset1Final, asset2Final],
    ),
    buildingsFinal[1],
  ];

  // Contacts
  final contacts = <ContactModel>[
    ContactModel(
      id: 'c-alice-0001',
      name: 'Alice Johnson',
      email: 'alice@acme.example',
      phone: '+1 555-222-3333',
      role: 'Manager',
      customer: baseCustomer,
    ),
    ContactModel(
      id: 'c-bob-0002',
      name: 'Bob Williams',
      email: 'bob@acme.example',
      phone: '+1 555-444-5555',
      role: 'Engineer',
      customer: baseCustomer,
    ),
  ];

  // Invoices and line items
  final invModel = InvoiceModel(
    id: 'inv-0001',
    dueDate: '2025-08-10',
    amount: 250.0,
    status: 'sent',
    invoiceDate: '2025-07-26',
    customer: baseCustomer,
    lineItems: const [],
  );
  final lineItems = <InvoiceLineItemModel>[
    InvoiceLineItemModel(
        id: 'li-1',
        name: 'Labor for task',
        quantity: 2,
        unitPrice: 100.0,
        invoice: invModel),
    InvoiceLineItemModel(
        id: 'li-2',
        name: 'Daikin AC Filter',
        quantity: 1,
        unitPrice: 50.0,
        invoice: invModel),
  ];
  final invoices = <InvoiceModel>[
    InvoiceModel(
      id: invModel.id,
      dueDate: invModel.dueDate,
      amount: invModel.amount,
      status: invModel.status,
      invoiceDate: invModel.invoiceDate,
      customer: baseCustomer,
      lineItems: lineItems,
    ),
  ];

  // Base tasks (without report/parts) referencing final objects
  final task1Base = TaskOrRequestedServiceModel(
    id: 'task-0001-hq-ac',
    title: 'HVAC Unit Not Cooling',
    description: 'Blowing warm air',
    status: 'in_progress',
    type: 'repair',
    priority: 'high',
    requestDate: DateTime(2025, 7, 25, 10, 0),
    completedDate: DateTime(2025, 7, 28, 16, 0),
    preferredDate: DateTime(2025, 7, 27),
    preferredTime: '10:00',
    notes: 'Customer reported warm air from vents.',
    specialInstructions: 'Please bring replacement filters',
    assignedDate: DateTime(2025, 7, 26),
    scheduledDate: DateTime(2025, 7, 27, 10, 0),
    customer: baseCustomer,
    building: buildingsReallyFinal.first,
    asset: asset1Final,
    createdBy: mockAdmin,
    assignedTo: mockEngineer,
  );
  final task2Base = TaskOrRequestedServiceModel(
    id: 'task-0002-inspect',
    title: 'Security Camera Inspection',
    description: 'Full inspection',
    status: 'completed',
    type: 'inspection',
    priority: 'medium',
    requestDate: DateTime(2025, 7, 10, 9, 0),
    completedDate: DateTime(2025, 7, 12, 15, 30),
    preferredDate: DateTime(2025, 7, 11),
    preferredTime: '09:00',
    notes: 'Routine annual inspection for security cameras.',
    specialInstructions:
        'Follow safety protocol and document firmware versions.',
    assignedDate: DateTime(2025, 7, 10),
    scheduledDate: DateTime(2025, 7, 11, 9, 0),
    customer: baseCustomer,
    building: buildingsReallyFinal.first,
    asset: asset2Final,
    createdBy: mockAdmin,
    assignedTo: mockEngineer,
  );

  // Reports linked to base tasks
  final report1 = ReportModel(
    id: 'rep-0001',
    title: 'HVAC Diagnosis',
    submittedDate: '2025-07-26',
    approvedDate: '2025-07-27',
    content:
        'Diagnosed low refrigerant levels. Recommended recharge and filter replace.',
    attachmentUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfDq3HKEoz0XeH131U603zS46pc1NlgClpEA&s',
    status: 'submitted',
    task: task1Base,
    submittedBy: mockEngineer,
    reviewedBy: mockAdmin,
  );
  final report2 = ReportModel(
    id: 'rep-0002',
    title: 'Camera Inspection Report',
    submittedDate: '2025-07-12',
    approvedDate: '2025-07-13',
    content: 'All cameras operational. Two units require firmware updates.',
    attachmentUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfDq3HKEoz0XeH131U603zS46pc1NlgClpEA&s',
    status: 'approved',
    task: task2Base,
    submittedBy: mockEngineer,
    reviewedBy: mockAdmin,
  );

  // Final tasks with reports and parts
  final tasks = <TaskOrRequestedServiceModel>[
    TaskOrRequestedServiceModel(
      id: task1Base.id,
      title: task1Base.title,
      description: task1Base.description,
      status: task1Base.status,
      type: task1Base.type,
      priority: task1Base.priority,
      requestDate: task1Base.requestDate,
      completedDate: task1Base.completedDate,
      preferredDate: task1Base.preferredDate,
      preferredTime: task1Base.preferredTime,
      notes: task1Base.notes,
      specialInstructions: task1Base.specialInstructions,
      assignedDate: task1Base.assignedDate,
      scheduledDate: task1Base.scheduledDate,
      customer: task1Base.customer,
      building: task1Base.building,
      asset: task1Base.asset,
      createdBy: task1Base.createdBy,
      assignedTo: task1Base.assignedTo,
      report: report1,
      parts: [part1],
    ),
    TaskOrRequestedServiceModel(
      id: task2Base.id,
      title: task2Base.title,
      description: task2Base.description,
      status: task2Base.status,
      type: task2Base.type,
      priority: task2Base.priority,
      requestDate: task2Base.requestDate,
      completedDate: task2Base.completedDate,
      preferredDate: task2Base.preferredDate,
      preferredTime: task2Base.preferredTime,
      notes: task2Base.notes,
      specialInstructions: task2Base.specialInstructions,
      assignedDate: task2Base.assignedDate,
      scheduledDate: task2Base.scheduledDate,
      customer: task2Base.customer,
      building: task2Base.building,
      asset: task2Base.asset,
      createdBy: task2Base.createdBy,
      assignedTo: task2Base.assignedTo,
      report: report2,
      parts: [part2],
    ),
  ];

  // Final customer with lists
  final customerFinal = CustomerModel(
    id: baseCustomer.id,
    name: baseCustomer.name,
    phone: baseCustomer.phone,
    email: baseCustomer.email,
    contacts: contacts,
    buildings: buildingsReallyFinal,
    invoices: invoices,
  );

  // Build contacts bound to final customer
  final contactsFinal = contacts
      .map((c) => ContactModel(
            id: c.id,
            name: c.name,
            email: c.email,
            phone: c.phone,
            role: c.role,
            customer: customerFinal,
          ))
      .toList();

  // Build invoices bound to final customer
  final invoicesFinal = invoices
      .map((inv) => InvoiceModel(
            id: inv.id,
            dueDate: inv.dueDate,
            amount: inv.amount,
            status: inv.status,
            invoiceDate: inv.invoiceDate,
            customer: customerFinal,
            lineItems: inv.lineItems
                .map((li) => InvoiceLineItemModel(
                      id: li.id,
                      name: li.name,
                      quantity: li.quantity,
                      unitPrice: li.unitPrice,
                      invoice: inv,
                    ))
                .toList(),
          ))
      .toList();

  return _MockBundle(
    customer: customerFinal,
    buildings: buildingsReallyFinal,
    assets: [asset1Final, asset2Final],
    contacts: contactsFinal,
    inventories: [inv1, inv2],
    parts: [part1, part2],
    invoices: invoicesFinal,
    tasks: tasks,
  );
}

// Initialize on import
final _MockBundle _bundle = _buildMocks();
