import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/pages/book_details_page.dart';
import 'package:readable/pages/home_page.dart';
import 'package:readable/pages/reading_list_page.dart';
import 'package:readable/providers/book_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // obrigado professor Douglas! 😂

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Readable',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Lato',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/readingList': (context) => const ReadingListPage(),
          '/bookDetails': (context) => const BookDetailsPage(),
        },
      ),
    );
  }
}
