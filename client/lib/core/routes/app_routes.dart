import 'package:go_router/go_router.dart';
import 'package:oneoone_library/features/authentication/presentation/views/login_screen.dart';
import 'package:oneoone_library/features/home/presentation/views/pages/home.dart';

import '../../features/books/presentation/views/pages/book_list_screen.dart';

class AppRoutes {
  static const String bookList = "/books";
}

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: "/home",
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: "/books",
      builder: (context, state) {
        return const BookListScreen();
      },
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ],
);
