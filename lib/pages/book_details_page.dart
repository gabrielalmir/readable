import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readable/models/book.dart';
import 'package:readable/providers/book_provider.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;
    final bookProvider = Provider.of<BookProvider>(context);
    final isInReadingList = bookProvider.isInReadingList(book);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: const Color.fromRGBO(47, 56, 74, 1),
        foregroundColor: Colors.white,
        actions: [
          // add or remove book
          IconButton(
            icon: Icon(
              isInReadingList ? Icons.remove : Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              if (isInReadingList) {
                bookProvider.removeFromReadingList(book);
              } else {
                bookProvider.addToReadingList(book);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                book.thumbnail,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Autores: ${book.authors}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descrição:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              book.description.isNotEmpty
                  ? book.description
                  : 'Descrição não disponível',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            RatingBar.builder(
              initialRating: book.rating?.toDouble() ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                book.rating = rating.toInt();
                bookProvider.updateBookRating(book);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Classificação Etária: ${book.maturityRating}',
              style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                icon: Icon(
                  isInReadingList ? Icons.remove : Icons.add,
                  color: Colors.blueGrey,
                ),
                label: Text(isInReadingList
                    ? 'Remover da Lista de Leitura'
                    : 'Adicionar à Lista de Leitura'),
                onPressed: () {
                  if (isInReadingList) {
                    bookProvider.removeFromReadingList(book);
                  } else {
                    bookProvider.addToReadingList(book);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
