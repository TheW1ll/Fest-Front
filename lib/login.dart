import 'package:festival/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserValue {
  String email = '';
  String password = '';
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final AuthService authService = AuthService();
  UserValue user = UserValue();
  String? emailError;
  String? passwordError;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  submit() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        loading = true;
      });
      authService
          .signInUsingEmailPassword(email: user.email, password: user.password)
          .then((value) {
        context.goNamed('home');
      }).catchError((e) {
        debugPrint("Ex : ${e is FirebaseAuthException}");
        debugPrint(e.code);
        switch (e.code) {
          case 'user-not-found':
            setState(() {
              emailError = 'User not found';
            });
            break;
          case 'invalid-email':
            setState(() {
              emailError = 'Invalid email';
            });
            break;
          case 'invalid-password':
            setState(() {
              passwordError = 'Invalid password';
            });
            break;
          case 'wrong-password':
            setState(() {
              passwordError = 'Wrong password';
            });
            break;
        }
      }).whenComplete(() => setState(() {
                loading = false;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Festoche',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            CircularProgressIndicator()
          ],
        ),
      ));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Festoche',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: emailController,
                  enableSuggestions: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'email',
                      prefixIcon: const Icon(Icons.mail, color: Colors.black),
                      border: const OutlineInputBorder(),
                      errorText: emailError),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mail is required';
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() {
                    user.email = val!;
                  }),
                ),
                const SizedBox(height: 16),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                        border: const OutlineInputBorder(),
                        errorText: passwordError),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() {
                          user.password = val!;
                        }),
                    onFieldSubmitted: (_) => submit()),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.goNamed('register');
                  },
                  child: const Text('Register'),
                ),
              ],
            )),
      ),
    );
  }
}
