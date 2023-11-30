class FarmField {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double length;
  final double breath;
  final double totalArea;
  final String soilType;
  final List<String> image;

  FarmField({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.length,
    required this.breath,
    required this.totalArea,
    required this.soilType,
    required this.image,
  });

  factory FarmField.fromJson(Map<String, dynamic> json) {
    return FarmField(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      length: json['length'],
      breath: json['breath'],
      totalArea: json['totalArea'],
      soilType: json['soilType'],
      image: List<String>.from(json['image']),
    );
  }
}
