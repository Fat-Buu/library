import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/book_remote_data_source.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/repositories/book_repository_imlp.dart';

// Inject DataSource
final bookRemoteDataSourceProvider = Provider((ref) => BookRemoteDataSource());

// Inject Repository
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final remote = ref.watch(bookRemoteDataSourceProvider);
  return BookRepositoryImpl(remote);
});
