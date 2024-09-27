import 'dart:convert';

import 'package:http/http.dart' as http;

class GoogleBooksRepository {
  final baseUrl = "https://www.googleapis.com/books/v1";

  Future<List<dynamic>> searchBooks(String query) async {
    final url = '$baseUrl/volumes?q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar livros');
    }

    final data = jsonDecode(response.body);
    return data['items'];
  }
}
