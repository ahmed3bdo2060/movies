import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = 'ff6627b2838427c934ed8ab6d6a0a17f';
const String baseUrl = 'https://api.themoviedb.org/3';

Future<List<dynamic>> searchMovies(String query) async {
  final response = await http.get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load movies');
  }
}