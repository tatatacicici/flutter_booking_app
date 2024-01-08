import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_app/HomePage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _userPhoto;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _userPhoto = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageToStorage(String userId) async {
    if (_userPhoto != null) {
      try {
        // Mendapatkan referensi storage
        Reference storageReference =
            FirebaseStorage.instance.ref().child('foto_profil/$userId.jpeg');

        // Mengupload foto ke Firebase Storage
        await storageReference.putFile(_userPhoto!);

        // Mendapatkan URL dari foto yang diupload
        String downloadURL = await storageReference.getDownloadURL();

        // Menyimpan URL foto ke Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'photoURL': downloadURL});
      } catch (e) {
        print('Error uploading image to storage: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                },
                child: Text('Pilih Gambar'),
              ),
              SizedBox(height: 16.0),
              // Text fields for email, username, and password
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 32.0),
              // Sign-in button
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    UserCredential signInCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    // Simpan data ke Firestore
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(signInCredential.user?.uid)
                        .set({
                      'username': _usernameController.text,
                      'email': _emailController.text,
                    });

                    // Upload foto ke Firebase Storage dan simpan URL-nya di Firestore
                    await _uploadImageToStorage(signInCredential.user!.uid);

                    // Navigasi ke halaman HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                            userEmail: signInCredential.user?.email ?? ""),
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
                    Text('Sign In', style: TextStyle(color: Colors.green[900])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
