import 'package:go_router/go_router.dart';
import 'package:oneoone_library/features/authentication/presentation/views/pages/login_screen.dart';
import 'package:oneoone_library/features/home/presentation/views/pages/home.dart';

import '../../features/books/presentation/views/pages/book_list_screen.dart';
import '../../features/error/presentations/views/pages/error_screen.dart';

class AppRoutes {
  static const String home = "home";
  static const String login = "login";
  static const String bookList = "books";
}

final GoRouter router = GoRouter(
  initialLocation: "/home",
  errorBuilder: (context, state) => ErrorScreen(),
  routes: <RouteBase>[
    GoRoute(
      name: AppRoutes.home,
      path: "/home",
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.bookList,
      path: "/books",
      builder: (context, state) {
        return const BookListScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.login,
      path: "/login",
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ],
);
