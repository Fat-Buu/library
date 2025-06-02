import 'package:oneoone_library/features/books/domain/repositories/book_repository.dart';

import '../entities/book.dart';

class BookService {
  final BookRepository bookRepository;

  BookService(this.bookRepository);

  Future<List<Book>> getAllBooks() {
    return bookRepository.getAllBooks();
  }
}
  