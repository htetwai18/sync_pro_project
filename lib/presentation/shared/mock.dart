import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/contact_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';

// Core Customer
const mockCustomer = CustomerModel(
  id: 'cust-0001',
  name: 'Acme Corp',
  phone: '+1 555-0100',
  email: 'ops@acme.example',
);

// Buildings
final List<BuildingModel> mockBuildings = [
  BuildingModel(
    id: 'bldg-hq-0001',
    name: 'Headquarters',
    address: '123 Main St, San Francisco',
    roomNumber: 'R001',
    customer: mockCustomer,
  ),
  BuildingModel(
    id: 'bldg-east-0002',
    name: 'East Wing',
    address: '456 Oak Ave, San Francisco',
    customer: mockCustomer,
  ),
];

// Assets
final List<AssetModel> mockAssets = [
  AssetModel(
    id: 'asset-ac-0001',
    name: 'Daikin AC Unit',
    manufacturer: 'Daikin',
    model: 'DX-2000',
    installationDate: DateTime(2024, 5, 10),
    building: mockBuildings.first,
  ),
  AssetModel(
    id: 'asset-gen-0002',
    name: 'Honda GX390 Generator',
    manufacturer: 'Honda',
    model: 'GX390',
    building: mockBuildings.first,
  ),
];

// Contacts
final List<ContactModel> mockContacts = [
  ContactModel(
    id: 'c-alice-0001',
    name: 'Alice Johnson',
    email: 'alice@acme.example',
    phone: '+1 555-222-3333',
    role: 'Manager',
    customer: mockCustomer,
  ),
  ContactModel(
    id: 'c-bob-0002',
    name: 'Bob Williams',
    email: 'bob@acme.example',
    phone: '+1 555-444-5555',
    role: 'Engineer',
    customer: mockCustomer,
  ),
];

// Users (createdBy/assignedTo)
const mockAdmin = UserModel(
  id: 'user-admin-0001',
  name: 'Admin One',
  phone: '+1 555-0000',
  email: 'admin@syncpro.test',
  role: 'admin',
);

const mockEngineer = UserModel(
  id: 'user-eng-0002',
  name: 'Alice Engineer',
  phone: '+1 555-9999',
  email: 'alice@syncpro.test',
  role: 'engineer',
);

// Tasks / Requested Services
final List<TaskOrRequestedServiceModel> mockTasks = [
  TaskOrRequestedServiceModel(
    id: 'task-0001-hq-ac',
    title: 'HVAC Unit Not Cooling',
    description: 'Blowing warm air',
    status: 'in_progress',
    type: 'repair',
    priority: 'high',
    requestDate: DateTime(2025, 7, 25, 10, 0),
    completedDate: null,
    preferredDate: DateTime(2025, 7, 27),
    preferredTime: '10:00',
    notes: '',
    specialInstructions: 'Please bring replacement filters',
    assignedDate: DateTime(2025, 7, 26),
    scheduledDate: DateTime(2025, 7, 27, 10, 0),
    customer: mockCustomer,
    building: mockBuildings.first,
    asset: mockAssets.first,
    createdBy: mockAdmin,
    assignedTo: mockEngineer,
    report: null,
    parts: const [],
  ),
  TaskOrRequestedServiceModel(
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
    notes: '',
    specialInstructions: '',
    assignedDate: DateTime(2025, 7, 10),
    scheduledDate: DateTime(2025, 7, 11, 9, 0),
    customer: mockCustomer,
    building: mockBuildings.first,
    asset: mockAssets.first,
    createdBy: mockAdmin,
    assignedTo: mockEngineer,
    report: null,
    parts: const [],
  ),
];

// Parts and Inventory (minimal to compile Engineer add-part screen)
final List<PartModel> mockParts = [
  PartModel(
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
          unitPrice: 250.0,
        ),
        location: InventoryModel(
          id: 'wh-0002',
          name: 'Engineer Van 5',
          code: 'VAN-5',
          isActive: true,
          createdAt: DateTime(2024, 1, 1),
        ),
      ),
    ],
  ),
  PartModel(
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
          unitPrice: 275.0,
        ),
        location: InventoryModel(
          id: 'wh-0002',
          name: 'Engineer Van 5',
          code: 'VAN-5',
          isActive: true,
          createdAt: DateTime(2024, 1, 1),
        ),
      ),
    ],
  ),
];
