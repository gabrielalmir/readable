import 'package:flutter/material.dart';
import 'package:readable/models/book.dart';
import 'package:readable/repositories/google_books_repository.dart';
import 'package:readable/services/book_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> books = [];
  List<Book> readingList = [];

  final BookService bookService =
      BookService(googleBooksRepository: GoogleBooksRepository());

  Future<void> searchBooks(String query) async {
    books = await bookService.searchBooks(query);
    notifyListeners();
  }

  Future<void> addToReadingList(Book book) async {
    readingList.add(book);
    notifyListeners();
  }
}
