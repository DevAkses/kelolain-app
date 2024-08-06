import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AnalysisService extends GetxService {
  final String _baseUrl =
      'https://kelolain-knn-model-production.up.railway.app/predict';

  Future<Map<String, dynamic>> getAnalysis(Map<String, dynamic> data) async {
    print(data);
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get analysis');
    }
  }
}
