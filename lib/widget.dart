import 'package:flutter/material.dart';
import 'package:flutter_booking_app/HomePage.dart';
import 'package:flutter_booking_app/historyPage.dart';
import 'package:flutter_booking_app/profil.dart';

var informationTextStyle = TextStyle(
  fontFamily: 'Oxygen',
  color: Colors.white,
);

class Tampilan extends StatelessWidget {
  final String userEmail;

  const Tampilan({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget buildHistoryNavItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryPage(
                    userEmail: userEmail,
                  )),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          Text(
            'HISTORY',
            style: informationTextStyle,
          ),
        ],
      ),
    );
  }

  Widget buildHomeNavItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userEmail: userEmail,
                  )),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Text(
            'HOME',
            style: informationTextStyle,
          ),
        ],
      ),
    );
  }

  Widget buildProfilNavItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilPage(
                    userEmail: userEmail,
                  )),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.face,
            color: Colors.white,
          ),
          Text(
            'PROFIL',
            style: informationTextStyle,
          ),
        ],
      ),
    );
  }

  Widget buildSessionButton(String session, String selectedSession, int price,
      VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: session == selectedSession ? Colors.green : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              session,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Rp${price.toString()}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
