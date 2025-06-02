import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodels/book_list_viewmodel.dart';

class BookListScreen extends ConsumerWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookState = ref.watch(bookListProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Book List")),
      body: bookState.when(
        data: (book) => Placeholder(),
        error: (e, _) => Center(child: Text("พบข้อผิดพลาด")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
