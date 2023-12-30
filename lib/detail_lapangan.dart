import 'package:flutter/material.dart';
import 'package:flutter_booking_app/HomePage.dart';
import 'package:flutter_booking_app/lapA.dart';
import 'package:flutter_booking_app/lapB.dart';
import 'package:flutter_booking_app/widget.dart';

class DetailLapangan extends StatelessWidget {
  final String userEmail; // Add this line

  const DetailLapangan({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Lapangan',
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
              SizedBox(height: 10),
              buildlapanganA(context),
              SizedBox(height: 10),
              buildlapanganB(context),
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

  Widget buildlapanganA(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your login logic here
        // Example: Validation and navigation to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LapA(
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
        child: Stack(
          children: [
            // Gambar Latar Belakang
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://i0.wp.com/isibangunan.com/wp-content/uploads/2017/11/5-Motif-Lantai-Vinyl-Untuk-Lapangan-Futsal-Modern.jpg?fit=800%2C350&ssl=1',
                height: 120, // Sesuaikan tinggi sesuai kebutuhan
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Konten
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // Pusatkan teks
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Teks
                    Text(
                      'LAPANGAN A',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildlapanganB(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your login logic here
        // Example: Validation and navigation to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LapB(
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
        child: Stack(
          children: [
            // Gambar Latar Belakang
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://kreasi.nurulfikri.ac.id/muha21051ti/PROJEK%20TUGAS%201%20LANDING%20PAGE/images/2.jpg',
                height: 120, // Sesuaikan tinggi sesuai kebutuhan
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Konten
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // Pusatkan teks
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Teks
                    Text(
                      'LAPANGAN B',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
