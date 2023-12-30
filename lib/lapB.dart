import 'package:flutter/material.dart';
import 'package:flutter_booking_app/detail_lapangan.dart';
import 'package:flutter_booking_app/widget.dart';

class LapB extends StatelessWidget {
  final String userEmail;

  const LapB({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LAPANGAN A',
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
                  builder: (context) => DetailLapangan(
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
                child: Image.network(
                  'https://kreasi.nurulfikri.ac.id/muha21051ti/PROJEK%20TUGAS%201%20LANDING%20PAGE/images/2.jpg',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'UKURAN LAPANGAN A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _tampilkanPopupUkuran(context);
                      },
                      child: Text('Lihat Ukuran Lapangan'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'FASILITAS LAPANGAN B',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _tampilkanPopupfasilitas(context);
                      },
                      child: Text('Lihat fasilitas Lapangan'),
                    ),
                  ],
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

  void _tampilkanPopupUkuran(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ukuran Lapangan'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://assets-skorid.s3.ap-southeast-1.amazonaws.com/lapangan_futsal_fifa_7013b0282e.png', // Ganti dengan URL gambar sesungguhnya
              ),
              SizedBox(height: 16),
              Text(
                  'Lapangan futsal ini telah memenuhi standar nasional Federasi Futsal Indonesia yaitu 40 x 20.'),
              SizedBox(height: 16),
              Text('Ukuran Gawang'),
              SizedBox(height: 10),
              Image.network(
                  'https://cdn.idntimes.com/content-images/community/2020/09/ukuran-gawang-futsal-98f2fbe2c4a604f882d0544f8249acb6.jpg'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _tampilkanPopupfasilitas(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fasilitas Lapangan'),
          content: Container(
            // Wrap the text in a SingleChildScrollView to enable scrolling
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. Lantai Sintetis'),
                  Text('2. Tempat duduk Pemain'),
                  Text('3. Toilet'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
