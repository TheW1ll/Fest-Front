import 'package:festival/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserValue {
  String email = '';
  String password = '';
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool registerSuccess = false;
  final AuthService authService = AuthService();
  UserValue user = UserValue();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reapeatPasswordController = TextEditingController();
  String? emailError;
  String? passwordError;

  submit() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        loading = true;
      });
      authService
          .registerUsingEmailPassword(
              email: user.email, password: user.password)
          .then((value) {
        setState(() {
          registerSuccess = true;
        });
      }).catchError((e) {
        debugPrint("Ex : ${e is FirebaseAuthException}");
        debugPrint(e.code);
        switch (e.code) {
          case 'invalid-email':
            setState(() {
              emailError = 'Invalid email';
            });
            break;
          case 'email-already-in-use':
            setState(() {
              emailError = 'Email already in use';
            });
            break;
          case 'invalid-password':
            setState(() {
              passwordError = 'Invalid password';
            });
            break;
          case 'weak-password':
            setState(() {
              passwordError = 'Weak password';
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
            child: (registerSuccess)
                ? const Success()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Festoche',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: emailController,
                        enableSuggestions: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'email',
                            prefixIcon:
                                const Icon(Icons.mail, color: Colors.black),
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
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onSaved: (val) => setState(() {
                          user.password = val!;
                        }),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                          controller: reapeatPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Repeat password',
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.black),
                              border: const OutlineInputBorder(),
                              errorText: passwordError),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value != passwordController.text) {
                              return 'Password is not matching';
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
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          context.goNamed('login');
                        },
                        child: const Text('Login'),
                      )
                    ],
                  )),
      ),
    );
  }
}

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Register success'),
        ElevatedButton(
            onPressed: () {
              context.goNamed('login');
            },
            child: const Text('Login'))
      ],
    );
  }
}
