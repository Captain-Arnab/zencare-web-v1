import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zencare/core/api_config.dart';

class ServiceableArea {
  final int id;
  final String name;
  final String pincode;
  final String label;
  final String value;

  ServiceableArea({
    required this.id,
    required this.name,
    required this.pincode,
    required this.label,
    required this.value,
  });

  factory ServiceableArea.fromJson(Map<String, dynamic> json) {
    return ServiceableArea(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      pincode: (json['pincode'] ?? '') as String,
      label: (json['label'] ?? '') as String,
      value: (json['value'] ?? json['pincode'] ?? '') as String,
    );
  }
}

Future<List<ServiceableArea>> fetchServiceableAreas() async {
  try {
    final res = await http.get(Uri.parse(ApiConfig.serviceableAreas));
    if (res.statusCode != 200) return [];
    final data = json.decode(res.body);
    final list = data['serviceable_areas'];
    if (list is! List) return [];
    return list.map((e) => ServiceableArea.fromJson(Map<String, dynamic>.from(e))).toList();
  } catch (_) {
    return [];
  }
}
