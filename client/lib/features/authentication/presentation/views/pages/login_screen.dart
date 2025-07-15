import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:oneoone_library/features/authentication/presentation/viewmodels/login_viewmodel.dart';
import 'package:oneoone_library/features/authentication/presentation/views/widgets/form_app.dart';

import '../../../../../core/routes/app_routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    String? token = await storage.read(key: "access_token");
    setState(() {
      if (token!.isNotEmpty) {
        context.goNamed(AppRoutes.bookList);
      }
    });
  }

  @override
  void dispose() {
    _usernameCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginAsync = ref.watch(loginViewModelProvider);
    final loginNotifier = ref.read(loginViewModelProvider.notifier);
    ref.listen(loginViewModelProvider, (prev, next) {
      next.when(
        data: (data) {
          if (mounted) {
            if (data.accessToken.isNotEmpty) {
              context.goNamed(AppRoutes.bookList);
            }
          }
        },
        error: (error, stackTrace) {
          SnackBar(content: Text('Error: $error'));
        },
        loading: () {},
      );
    });
    return Scaffold(
      body: Center(
        child: loginAsync.when(
          data: (data) {
            return FormApp(
              formKey: _formKey,
              usernameCtl: _usernameCtl,
              passwordCtl: _passwordCtl,
              loginNotifier: loginNotifier,
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (err, _) => SnackBar(content: Text('Error: $err')),
        ),
      ),
    );
  }
}
