import 'package:readable/models/book.dart';
import 'package:readable/repositories/google_books_repository.dart';

class BookService {
  final GoogleBooksRepository googleBooksRepository;

  BookService({required this.googleBooksRepository});

  Future<List<Book>> searchBooks(String query) async {
    final googleBooks = await googleBooksRepository.searchBooks(query);
    List<Book> books = [];

    for (var googleBook in googleBooks) {
      var book = Book.fromJson(googleBook);
      books.add(book);
    }

    return books;
  }
}
