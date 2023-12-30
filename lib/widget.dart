import 'package:flutter/material.dart';
import 'package:flutter_booking_app/HomePage.dart';
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
        // Add your login logic here
        // Example: Validation and navigation to the home page
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
        // Add your login logic here
        // Example: Validation and navigation to the home page
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
        // Add your login logic here
        // Example: Validation and navigation to the home page
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
}
