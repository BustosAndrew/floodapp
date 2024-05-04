import 'package:flood/UI/signup.dart';
import 'package:flood/auth/auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : (() async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      await AuthRepo.instance
                                          .loginUserWithEmailAndPassword(
                                              emailController.text.trim(),
                                              passwordController.text.trim());
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    } catch (e) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }),
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : const Text("Login"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              child: const Text("Sign Up"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                );
                              }),
                        ],
                      )),
                ],
              ),
            )),
      ),
    ));
  }
}
