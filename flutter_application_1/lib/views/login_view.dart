import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_exception.dart';
import 'package:flutter_application_1/services/auth/auth_services.dart';
import 'package:flutter_application_1/utilities/show_error_dialog.dart';
import 'package:flutter_application_1/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                hintText: "  Email",
                icon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: _password,
              decoration: InputDecoration(
                icon: const Icon(Icons.password),
                hintText: "  pasword",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await AuthService.firebase()
                    .logIn(email: email, password: password);
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDiglog(
                  context,
                  "User Not Found",
                );
              } on WrongPassworAuthException {
                await showErrorDiglog(
                  context,
                  "Wrong Password",
                );
              } on GenericAuthException {
                await showErrorDiglog(
                  context,
                  'Authentication error',
                );
              }
            },
            child: const Text(
              "Login",
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Not Register yet? Register Here!"),
          ),
        ],
      ),
    );
  }
}
