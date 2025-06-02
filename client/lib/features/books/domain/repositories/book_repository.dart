import 'package:oneoone_library/features/books/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getAllBooks();
}
