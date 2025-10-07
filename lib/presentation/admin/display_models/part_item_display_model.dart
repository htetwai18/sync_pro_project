class PartItemDisplayModel {
  final String name;
  final String number;
  final int onHand;
  // details
  final String manufacturer;
  final double unitPrice;
  final List<PartStockLocation> stock;

  const PartItemDisplayModel({
    required this.name,
    required this.number,
    required this.onHand,
    this.manufacturer = 'FluidTech',
    this.unitPrice = 250.0,
    this.stock = const [],
  });
}

class PartStockLocation {
  final String location;
  final int quantity;
  const PartStockLocation({required this.location, required this.quantity});
}

final List<PartItemDisplayModel> mockParts = [
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget B',
    number: '#12344',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget C',
    number: '#12349',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
  const PartItemDisplayModel(
    name: 'Widget A',
    number: '#12345',
    onHand: 100,
    stock: [
      PartStockLocation(location: 'Warehouse A', quantity: 15),
      PartStockLocation(location: 'Engineer Van 5', quantity: 5)
    ],
  ),
];
