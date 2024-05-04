import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _householdSize = '';
  String _language = 'English'; // Default to English

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process data here
      print(
          'Email: $_email, Password: $_password, Household: $_householdSize, Language: $_language');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty || !value.contains('@')
                  ? 'Enter a valid email'
                  : null,
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => value!.isEmpty || value.length < 6
                  ? 'Password must be at least 6 characters'
                  : null,
              onSaved: (value) => _password = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Household Size'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'Enter household size' : null,
              onSaved: (value) => _householdSize = value!,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Language'),
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
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
