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
    final idRaw = json['id'];
    final pincodeStr = json['pincode']?.toString() ?? '';
    final valueStr = json['value']?.toString() ?? pincodeStr;
    return ServiceableArea(
      id: idRaw is int ? idRaw : (idRaw != null ? int.tryParse(idRaw.toString()) ?? 0 : 0),
      name: json['name']?.toString() ?? '',
      pincode: pincodeStr,
      label: json['label']?.toString() ?? (json['name']?.toString() ?? '') + (pincodeStr.isNotEmpty ? ' - $pincodeStr' : ''),
      value: valueStr.isNotEmpty ? valueStr : pincodeStr,
    );
  }
}

/// Result of fetching serviceable areas: list and optional error message.
class ServiceableAreasResult {
  final List<ServiceableArea> areas;
  final String? error;

  const ServiceableAreasResult({required this.areas, this.error});
}

/// Fetches serviceable areas from API. Returns areas and optional error (e.g. CORS, network, or empty response).
Future<ServiceableAreasResult> fetchServiceableAreasWithError() async {
  try {
    final uri = Uri.parse(ApiConfig.serviceableAreas);
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      return ServiceableAreasResult(
        areas: [],
        error: 'Server returned ${res.statusCode}. Check that serviceable_areas.php is deployed and returns 200.',
      );
    }
    final data = json.decode(res.body) as Map<String, dynamic>?;
    if (data == null) {
      return const ServiceableAreasResult(areas: [], error: 'Invalid response from server.');
    }
    // Support both { serviceable_areas: [...] } and { data: { serviceable_areas: [...] } }
    dynamic list = data['serviceable_areas'] ?? (data['data'] is Map ? (data['data'] as Map)['serviceable_areas'] : null);
    if (list is! List) {
      return const ServiceableAreasResult(areas: [], error: 'Response missing serviceable_areas list.');
    }
    if (list.isEmpty) {
      return const ServiceableAreasResult(areas: [], error: 'No serviceable areas in database. Add rows to serviceable_areas table.');
    }
    final areas = list.map((e) => ServiceableArea.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    return ServiceableAreasResult(areas: areas);
  } catch (e) {
    // CORS or network errors often show here (e.g. in browser)
    final msg = e.toString();
    String error = 'Could not load serviceable areas. ';
    if (msg.contains('CORS') || msg.contains('Failed to load')) {
      error += 'Server may need CORS headers (Access-Control-Allow-Origin) for ${ApiConfig.serviceableAreas}';
    } else {
      error += 'Check internet connection and that the API URL is correct.';
    }
    return ServiceableAreasResult(areas: [], error: error);
  }
}

/// Legacy: returns only the list (empty on any error). Use [fetchServiceableAreasWithError] for error details.
Future<List<ServiceableArea>> fetchServiceableAreas() async {
  final result = await fetchServiceableAreasWithError();
  return result.areas;
}
