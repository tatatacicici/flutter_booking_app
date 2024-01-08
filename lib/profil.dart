import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_booking_app/HomePage.dart';
import 'package:flutter_booking_app/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

var informationTextStyle = TextStyle(
  fontFamily: 'Oxygen',
  color: Colors.white,
);

class ProfilPage extends StatefulWidget {
  final String userEmail;
  final String userName;

  const ProfilPage({Key? key, required this.userEmail, required this.userName})
      : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? retrievedUserName;
  String? retrievedUserEmail;
  String _fotoUrl = '/';

  @override
  void initState() {
    super.initState();
    getDataFromFirestore(widget.userEmail);
    _loadImageFromPrefs();
  }

  // Method untuk mengambil data dari Firestore
  Future<void> getDataFromFirestore(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (userData.docs.isNotEmpty) {
        Map<String, dynamic> user =
            userData.docs[0].data() as Map<String, dynamic>;

        setState(() {
          retrievedUserName = user['username'];
          retrievedUserEmail = user['email'];
        });
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error retrieving data from Firestore: $e');
    }
  }

  // Fungsi untuk menyimpan _fotoUrl_ menggunakan shared preferences
  Future<void> saveFotoUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fotoUrl', url);
  }

  // Fungsi untuk mendapatkan _fotoUrl_ dari shared preferences
  Future<void> _loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fotoUrl = prefs.getString('fotoUrl');
    if (fotoUrl != null) {
      setState(() {
        _fotoUrl = fotoUrl;
      });
    }
  }

  // Metode untuk mengambil gambar dari galeri
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _fotoUrl = pickedFile.path;
        saveFotoUrl(
            _fotoUrl); // Simpan _fotoUrl_ menggunakan shared preferences
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFIL',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(userEmail: widget.userEmail),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: _fotoUrl.isEmpty
                      ? AssetImage('images/foto_profil.jpg')
                      : FileImage(File(_fotoUrl)) as ImageProvider<Object>?,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '$retrievedUserName',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '$retrievedUserEmail',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[900],
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Tampilan(
                userEmail: widget.userEmail,
              ).buildHistoryNavItem(context),
              Tampilan(
                userEmail: widget.userEmail,
              ).buildHomeNavItem(context),
              Tampilan(
                userEmail: widget.userEmail,
              ).buildProfilNavItem(context),
            ],
          ),
        ),
      ),
    );
  }
}
