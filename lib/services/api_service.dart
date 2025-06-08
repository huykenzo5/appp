import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class ApiService {
  static const String url = 'http://10.0.2.2/travel_api/getAllPlace.php';

  static Future<List<Place>> fetchPlaces() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Place.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
}
