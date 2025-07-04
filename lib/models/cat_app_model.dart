class CatAppModel {
  final String id;
  final String name;
  final String origin;
  final String temperament;
  final String description;

  CatAppModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.description,
  });

  factory CatAppModel.fromJson(dynamic json) => CatAppModel(
    id: json['id'],
    name: json['name'],
    origin: json['origin'],
    temperament: json['temperament'],
    description: json['description'],
  );
}