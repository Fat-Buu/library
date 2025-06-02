import 'package:oneoone_library/features/books/data/datasources/book_remote_data_source.dart';
import 'package:oneoone_library/features/books/domain/entities/book.dart';

import '../../data/models/book_model.dart';
import 'book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Book>> getAllBooks() async {
    final rawBooks = await remoteDataSource.fetchBooks();
    return rawBooks.map((json) => BookModel.fromJson(json)).toList();
  }
}
