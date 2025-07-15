import 'package:oneoone_library/features/books/domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.category,
    required super.image,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      category: json['category'],
      image: json['image'],
    );
  }
}
