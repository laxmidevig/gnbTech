// lib/models/property.dart

class Property {
  final String id;
  final String title;       // ← add this
  final String postcode;
  final String machine_id;
  final DateTime start_at;
  final DateTime? end_at;
  final String status;

  Property({
    required this.id,
    required this.title,
    required this.postcode,
    required this.machine_id,
    required this.start_at,
    this.end_at,
    required this.status,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'].toString(),
      title: json['postcode'], // or whatever field you want to show as "title"
      postcode: json['postcode'],
      machine_id: json['machine_id'],
      start_at: DateTime.parse(json['start_at']),
      end_at: json['end_at'] != null ? DateTime.parse(json['end_at']) : null,
      status: json['status'],
    );
  }

  static List<Property> fromList(List<dynamic> list) =>
      list.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList();
}
