import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneoone_library/features/authentication/data/states/login_state.dart';
import 'package:oneoone_library/features/authentication/presentation/viewmodels/login_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtl = TextEditingController();
  final _passwordCtl = TextEditingController();

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
    return Scaffold(
      body: Center(
        child: loginAsync.when(
          data:
              (data) => FormApp(
                formKey: _formKey,
                loginState: data,
                usernameCtl: _usernameCtl,
                passwordCtl: _passwordCtl,
                loginNotifier: loginNotifier,
              ),
          loading: () => CircularProgressIndicator(),
          error: (err, _) => Text('Error: $err'),
        ),
      ),
    );
  }
}

class FormApp extends StatelessWidget {
  const FormApp({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.loginState,
    required TextEditingController usernameCtl,
    required TextEditingController passwordCtl,
    required this.loginNotifier,
  }) : _formKey = formKey,
       _usernameCtl = usernameCtl,
       _passwordCtl = passwordCtl;

  final GlobalKey<FormState> _formKey;
  final LoginState loginState;
  final TextEditingController _usernameCtl;
  final TextEditingController _passwordCtl;
  final LoginViewModel loginNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loginState.accessToken),
            TextFormField(
              controller: _usernameCtl,
              decoration: InputDecoration(labelText: "username"),
              validator: (value) => value == null ? 'required username' : null,
            ),
            TextFormField(
              controller: _passwordCtl,
              obscureText: true,
              decoration: InputDecoration(labelText: "password"),
              validator: (value) => value == null ? 'required password' : null,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await loginNotifier.login();
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
