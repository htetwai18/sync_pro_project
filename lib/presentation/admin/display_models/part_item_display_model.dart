class PartItemDisplayModel {
  final String name;
  final String number;
  final int onHand;

  const PartItemDisplayModel({
    required this.name,
    required this.number,
    required this.onHand,
  });
}

final List<PartItemDisplayModel> mockParts = [
  const PartItemDisplayModel(name: 'Widget A', number: '#12345', onHand: 100),
  const PartItemDisplayModel(name: 'Connector B', number: '#67890', onHand: 50),
  const PartItemDisplayModel(name: 'Module C', number: '#11223', onHand: 75),
  const PartItemDisplayModel(name: 'Sensor D', number: '#33445', onHand: 200),
  const PartItemDisplayModel(name: 'Cable E', number: '#55667', onHand: 150),
  const PartItemDisplayModel(name: 'Bearing F', number: '#98765', onHand: 30),
];
