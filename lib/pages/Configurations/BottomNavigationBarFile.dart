import '../login/ConnexionPage.dart';
import '../Accueuils/ContenuAccueil.dart';
import '../login/InscriptionPage_1.dart';
import '../Accueuils/SousCategorie_Homme.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  //
  Widget Pages(int currentIndex){
    switch(currentIndex){
      case 0: return ContenuAccueil();
      case 1: return SousCategorieHomme('Homme');
      case 2: return Connexion();
      case 3: return Inscription_1();
      break;
      default: ContenuAccueil();
    }
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (value){
        _currentIndex = value;
        setState(() {

        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Clients',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Commandes',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Catalogue',
          backgroundColor: Colors.blue,
        )
      ],
    );
  }
}
