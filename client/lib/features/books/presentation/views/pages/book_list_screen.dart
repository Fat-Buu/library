import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/book.dart';
import '../../viewmodels/book_list_viewmodel.dart';
import '../widgets/book_card.dart';

class BookListScreen extends ConsumerStatefulWidget {
  const BookListScreen({super.key});

  @override
  BookListScreenState createState() => BookListScreenState();
}

class BookListScreenState extends ConsumerState<BookListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookListProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Book List")),
      body: bookState.when(
        data: (books) {
          if (books.isEmpty) {
            return Center(child: Text("No book"));
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              Book book = books[index];
              return BookCard(
                title: book.title,
                author: book.author,
                category: book.category,
              );
            },
          );
        },
        error: (e, _) => Center(child: Text("Something error!!")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
