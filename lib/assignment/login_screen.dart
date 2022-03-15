import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum userType { business, user }

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  userType userSelected = userType.user;
  bool _passwordVisibility = false;
  String valueOfResponse = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final url = Uri.parse('http://pt.frantic.in/RestApi/login_user');

    try {
      final response = await http.post(Uri.parse("http://pt.frantic.in/RestApi/login_user"), body: {
        "username": _email,
        //"harpreetfrantic@gmail.com",
        "password": _password,
        //"harry9654",
        "usertype": userSelected == userType.user ? "USER" : "BUSINESS",
      });
      final json = jsonDecode(response.body);
      valueOfResponse = json['response_string'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.local_fire_department, size: 200, color: Colors.yellow[700]),
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: _passwordVisibility ? false : true,
              onChanged: (value) {
                _password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Password',
                suffix: IconButton(
                    icon: Icon(
                      _passwordVisibility ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisibility = !_passwordVisibility;
                      });
                    }),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Row(
                  children: [
                    Radio<userType>(
                      value: userType.user,
                      groupValue: userSelected,
                      onChanged: (value) {
                        userSelected = userType.user;
                      },
                    ),
                    const Text(
                      'User',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<userType>(
                      value: userType.business,
                      groupValue: userSelected,
                      onChanged: (value) {
                        userSelected = userType.business;
                      },
                    ),
                    const Text(
                      'Business',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 5.0,
              color: Colors.purple,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  if (valueOfResponse == "Login Success") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    );
                  }
                },
                minWidth: 300.0,
                height: 50.0,
                child: const Text(
                  'Log in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: Divider(thickness: 2)),
                Text(
                  '  or sign in using  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
                Expanded(child: Divider(thickness: 2)),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account ?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
