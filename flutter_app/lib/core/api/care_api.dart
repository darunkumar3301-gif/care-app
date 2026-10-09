import 'dart:convert';
import 'package:http/http.dart' as http;

class CareApi {
  
  static const String baseUrl = 'http://10.0.2.2:8081';

  Future<List<Map<String, dynamic>>> getBranches() async {
    final response = await http.get(
      Uri.parse('$baseUrl/v1/branches'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load branches: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);

    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    throw Exception('Invalid branches response');
  }

  Future<bool> healthCheck() async {
    final response = await http.get(
      Uri.parse('$baseUrl/health'),
    );

    return response.statusCode == 200;
  }
}