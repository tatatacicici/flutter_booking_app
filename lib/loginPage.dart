import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booking_app/HomePage.dart';
import 'package:flutter_booking_app/signInPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo underneath the title
              Image.asset(
                'images/logo.png',
                height: 100, // Adjust the height as needed
              ),
              SizedBox(height: 16.0),
              // Text fields for username and password
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 32.0),
              MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text(
                    'Tidak punya akun? Daftar',
                    style: TextStyle(
                      color: isHovered ? Colors.blue : Colors.black,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Login button
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                            userEmail: userCredential.user?.email ?? ""),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Email or Password is incorrect!'),
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: () {},
                        ),
                      ),
                    );

                    print("Error: $e");
                  }
                },
                child:
                    Text('Login', style: TextStyle(color: Colors.green[900])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
