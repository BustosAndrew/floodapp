import 'package:flood/auth/auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _householdSize = '';
  String _language = 'English';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController householdSizeController = TextEditingController();
  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await AuthRepo().createUserWithEmailAndPassword(
          emailController.text,
          passwordController.text,
          householdSizeController.text.isEmpty
              ? 1
              : int.parse(householdSizeController.text),
          _language);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty || !value.contains('@')
                  ? 'Enter a valid email'
                  : null,
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => value!.isEmpty || value.length < 6
                  ? 'Password must be at least 6 characters'
                  : null,
              onSaved: (value) => _password = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Household Size'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'Enter household size' : null,
              onSaved: (value) => _householdSize = value!,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Language'),
              value: _language,
              items: ['English', 'Spanish'].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                });
              },
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(children: [
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : (() async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              _submitForm();
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
                        : const Text("Sign Up"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ])),
          ],
        ),
      ),
    );
  }
}
