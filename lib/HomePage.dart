import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_booking_app/CS.dart';
import 'package:flutter_booking_app/widget.dart';
import 'package:flutter_booking_app/detail_lapangan.dart';

var informationTextStyle = TextStyle(
  fontFamily: 'Oxygen',
  color: Colors.white,
);

class HomePage extends StatelessWidget {
  final String userEmail;

  const HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YUK FUTSAL',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            exit(0);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset('images/futsal.png'),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Rasakan Kemudahannya Sekarang!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildBookingRow('images/booking.png', 'BOOKING'),
              SizedBox(height: 10),
              buildfieldRow(context),
              SizedBox(height: 10),
              buildcsRow(context),
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

  Widget buildBookingRow(String imagePath, String text) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Jangan di pencet, taku keterusan!',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildfieldRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your login logic here
        // Example: Validation and navigation to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DetailLapangan(
                    userEmail: userEmail,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/lapangan.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DETAIL LAPANGAN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cek dulu fasilitasnya, karena kebahagiaan bukan hanya dari hati yang damai, tapi juga tempat yang nyaman',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildcsRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your login logic here
        // Example: Validation and navigation to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CsPage(
                    userEmail: userEmail,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/cs.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONTACT PERSON',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ada Masalah apa sih kawan, coba cerita sekarang!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
