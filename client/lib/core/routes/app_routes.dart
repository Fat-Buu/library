import 'package:go_router/go_router.dart';

import '../../features/books/presentation/views/pages/book_list_screen.dart';

class AppRoutes {
  static const String bookList = "/books";
}

final GoRouter router = GoRouter(
  initialLocation: '/books',
  routes: <RouteBase>[
    GoRoute(
      path: "/books",
      builder: (context, state) {
        return const BookListScreen();
      },
    ),
  ],
);
