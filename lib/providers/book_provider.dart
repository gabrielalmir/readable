import 'package:flutter/material.dart';
import 'package:readable/helpers/db.dart';
import 'package:readable/models/book.dart';
import 'package:readable/repositories/google_books_repository.dart';
import 'package:readable/services/book_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> books = [];
  List<Book> readingList = [];
  bool isLoading = false;

  final BookService bookService =
      BookService(googleBooksRepository: GoogleBooksRepository());

  final DatabaseHelper db = DatabaseHelper();

  BookProvider() {
    _loadReadingListFromDatabase();
  }

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

  Future<void> toggleFavoriteStatus(Book book) async {
    book.isFavorite = !book.isFavorite;
    await db.updateBook(book);
    notifyListeners();
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

  bool isInReadingList(Book book) {
    return readingList.any((b) => b.id == book.id);
  }

  Future<void> addToReadingList(Book book) async {
    if (!isInReadingList(book)) {
      readingList.add(book);
      await db.insertBook(book);
      notifyListeners();
    }
  }

  Future<void> updateBookRating(Book book) async {
    await db.updateBook(book);

    int index = readingList.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      readingList[index] = book;
    }

    notifyListeners();
  }

  void removeFromReadingList(Book book) async {
    readingList.removeWhere((b) => b.id == book.id);
    await db.deleteBook(book.id);
    notifyListeners();
  }

  Future<void> _loadReadingListFromDatabase() async {
    readingList = await db.getBooks();
    notifyListeners();
  }
}
