import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_details_model.dart';

class BookDetailsService {
  static const String _baseUrl = 'https://www.dbooks.org/api';

  Future<BookDetails> fetchBookDetails(String bookId) async {
    final response = await http.get(Uri.parse('$_baseUrl/book/$bookId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookDetails.fromJson(data);
    } else {
      throw Exception('Failed to load book details');
    }
  }
}
