import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/providers/book_provider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.book),
            SizedBox(width: 4),
            Text('Readable'),
          ],
        ),
        backgroundColor: const Color.fromRGBO(47, 56, 74, 1),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/book_hero.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.blueGrey.withOpacity(0.8),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 16,
                top: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Encontre seus livros favoritos!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pesquise e adicione livros à sua lista de leitura',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite o nome do livro',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.read<BookProvider>().searchBooks(_controller.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<BookProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    final book = provider.books[index];

                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.authors),
                      leading: Image.network(
                        book.thumbnail,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          provider.addToReadingList(book);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
