import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/pages/home_page.dart';
import 'package:readable/providers/book_provider.dart';

void main() {
  runApp(const MainApp());
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
        home: HomePage(),
      ),
    );
  }
}
