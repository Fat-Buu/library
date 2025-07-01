import 'package:flutter/material.dart';

import '../../viewmodels/login_viewmodel.dart';

class FormApp extends StatelessWidget {
  const FormApp({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernameCtl,
    required TextEditingController passwordCtl,
    required this.loginNotifier,
  }) : _formKey = formKey,
       _usernameCtl = usernameCtl,
       _passwordCtl = passwordCtl;

  final GlobalKey<FormState> _formKey;
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
            TextFormField(
              controller: _usernameCtl,
              decoration: InputDecoration(labelText: "username"),
              validator: (value) => value!.isEmpty ? 'required username' : null,
            ),
            TextFormField(
              controller: _passwordCtl,
              obscureText: true,
              decoration: InputDecoration(labelText: "password"),
              validator: (value) => value!.isEmpty ? 'required password' : null,
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
