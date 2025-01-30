import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class SearchService {
  Future<List<Book>> searchBooks(String query) async {
    final response =
        await http.get(Uri.parse('https://www.dbooks.org/api/search/$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('books') && data['books'] != null) {
        final List<dynamic> booksJson = data['books'];
        return booksJson.map((json) => Book.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
