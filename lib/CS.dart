import 'package:flutter/material.dart';
import 'package:flutter_booking_app/HomePage.dart';
import 'package:flutter_booking_app/widget.dart';

var informationTextStyle = TextStyle(
  fontFamily: 'Oxygen',
  color: Colors.white,
);

class CsPage extends StatelessWidget {
  final String userEmail; // Add this line

  const CsPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONTACT PERSON',
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
                  builder: (context) => HomePage(
                        userEmail: userEmail,
                      )),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    ('wa.me//6285725040030'); // Replace with the desired link
                  },
                  child: Text(
                    'Bayu Tri Prayitno',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ),
              // Add other widgets or links here
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
                userEmail: userEmail,
              ).buildHistoryNavItem(context),
              Tampilan(
                userEmail: userEmail,
              ).buildHomeNavItem(context),
              Tampilan(
                userEmail: userEmail,
              ).buildProfilNavItem(context),
            ],
          ),
        ),
      ),
    );
  }
}
