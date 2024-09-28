import 'package:flutter/material.dart';
import 'package:readable/models/book.dart';
import 'package:readable/repositories/google_books_repository.dart';
import 'package:readable/services/book_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> books = [];
  List<Book> readingList = [];
  bool isLoading = false;

  final BookService bookService =
      BookService(googleBooksRepository: GoogleBooksRepository());

  Future<void> searchBooks(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      books = await bookService.searchBooks(query);
    } catch (e) {
      books = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSuggestedBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      books = await bookService.searchBooks('lord');
    } catch (e) {
      books = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToReadingList(Book book) async {
    readingList.add(book);
    notifyListeners();
  }

  void removeFromReadingList(Book book) {
    readingList.remove(book);
    notifyListeners();
  }
}
