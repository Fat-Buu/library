import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/book.dart';
import '../providers/providers.dart';

part 'book_list_viewmodel.g.dart';

@riverpod
class BookList extends _$BookList {
  @override
  Future<List<Book>> build() async {
    final repo = ref.watch(bookRepositoryProvider);
    return await repo.getAllBooks();
  }
}
