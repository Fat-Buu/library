import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneoone_library/core/routes/app_routes.dart';
import 'package:oneoone_library/features/books/presentation/views/pages/book_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.bookList,
      routes: {AppRoutes.bookList: (context) => const BookListScreen()},
    );
  }
}
