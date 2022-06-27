import 'package:fashiontailor/pages/Accueuils/AccueilPage.dart';
import 'package:fashiontailor/pages/Accueuils/home_screen.dart';
import 'package:fashiontailor/pages/Accueuils/intro_screen.dart';
import 'package:fashiontailor/pages/login/ConnexionPage.dart';
import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    //Navigator.pushNamed(context, "/home");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen()),
    );
  }

  static void goToIntro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IntroScreen()),
    );  }

  static void goToAcceuil(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => Accueil()),
    // );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Accueil(para_iduserOline: '',)),
          (Route<dynamic> route) => false,
    );

  }

  static void goToConnexion(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Connexion()),
          (Route<dynamic> route) => false,
    );

  }
}
