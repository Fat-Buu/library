import 'package:go_router/go_router.dart';
import 'package:oneoone_library/features/authentication/presentation/views/pages/login_screen.dart';
import 'package:oneoone_library/features/home/presentation/views/pages/home.dart';

import '../../features/books/presentation/views/pages/book_list_screen.dart';

class AppRoutes {
  static const String home = "/home";
  static const String login = "/login";
  static const String bookList = "/books";
}

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.bookList,
      builder: (context, state) {
        return const BookListScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ],
);
