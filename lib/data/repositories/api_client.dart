import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:libura/data/models/holiday_model.dart';

class ApiClient {
  final String baseUrl = 'https://kalenderindonesia.com/api/82e86417a1c09d9a';

  Future<List<Holiday>> fetchHolidays(String year) async {
    final url = '$baseUrl/libur/masehi/$year';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final List<dynamic> holidaysJson = data['data']['holidays'];
          return holidaysJson
              .map((holiday) => Holiday.fromJson(holiday))
              .toList();
        } else {
          throw Exception('Failed to fetch holidays');
        }
      } else {
        throw Exception(
            'Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
