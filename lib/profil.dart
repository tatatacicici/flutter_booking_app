import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_booking_app/HomePage.dart';
import 'package:flutter_booking_app/widget.dart';

var informationTextStyle = TextStyle(
  fontFamily: 'Oxygen',
  color: Colors.white,
);

class ProfilPage extends StatefulWidget {
  final String userEmail;
  const ProfilPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? retrievedUserName;
  String? retrievedUserEmail;

  // Method untuk mengambil data dari Firestore
  Future<void> getDataFromFirestore(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (userData.docs.isNotEmpty) {
        // Pastikan terdapat data yang ditemukan
        Map<String, dynamic> user =
            userData.docs[0].data() as Map<String, dynamic>;

        // Lakukan sesuatu dengan data yang diambil, misalnya, simpan ke variabel state
        setState(() {
          retrievedUserName = user['username'];
          retrievedUserEmail = user['email'];
          print(user['email']);
        });
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error retrieving data from Firestore: $e');
      // Handle error jika diperlukan
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromFirestore(widget.userEmail);
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
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/foto_profil.jpg'),
              ),
              SizedBox(height: 16.0),
              Text(
                'User Name: $retrievedUserName',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'User Email: $retrievedUserEmail',
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
