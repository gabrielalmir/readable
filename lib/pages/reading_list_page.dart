import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readable/providers/book_provider.dart';

class ReadingListPage extends StatelessWidget {
  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista de Leitura'),
        backgroundColor: const Color.fromRGBO(47, 56, 74, 1),
        foregroundColor: Colors.white,
      ),
      body: Consumer<BookProvider>(
        builder: (context, provider, child) {
          if (provider.readingList.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum livro na lista de leitura',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.readingList.length,
            itemBuilder: (context, index) {
              final book = provider.readingList[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(book.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.authors),
                      RatingBarIndicator(
                        rating: book.rating?.toDouble() ?? 0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  leading: Image.network(
                    book.thumbnail,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      provider.removeFromReadingList(book);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/bookDetails',
                      arguments: book,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
