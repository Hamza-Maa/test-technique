import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BookService {
  static const String _baseUrl = 'https://www.dbooks.org/api/recent';

  Future<BookResponse> fetchBooks() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookResponse.fromJson(data);
    } else {
      throw Exception('Failed to load books');
    }
  }
}
