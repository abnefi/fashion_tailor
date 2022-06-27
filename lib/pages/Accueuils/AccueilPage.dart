import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashiontailor/pages/Catalogues/CatalogueAccueil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../login/ConnexionPage.dart';
import 'ContenuAccueil.dart';
import 'Home.dart';
import '../Catalogues/Catalogue.dart';
import '../login/InscriptionPage_1.dart';
import '../Clients/ListeClients.dart';
import '../Commandes/ListeCommades.dart';
import 'SousCategorie_Homme.dart';
import '../Configurations/BottomNavigationBarFile.dart';

class Accueil extends StatefulWidget{

  static String tag = 'accueil-page';
  final String para_iduserOline;
  final VoidCallback signOut;

  Accueil({Key key, @required this.para_iduserOline,this.signOut}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  signOut() {
    setState(() {
      widget.signOut();
    });
  }


  int _currentIndex = 0;
  //
  Widget Pages(int currentIndex){
    print('idClient recu par la page accueil: '+widget.para_iduserOline);
    switch(currentIndex){
      case 0: return ContenuAccueil(para_iduserOline: widget.para_iduserOline,);
      case 1: return ListeClients(idUserOne: widget.para_iduserOline);
      case 2: return ListeCommandes();
      case 3: return CatalogueAccueil();
      break;
      default: ContenuAccueil();
    }
  }

  @override
  Widget build(BuildContext context){

    //Bottom Navigation Bar
    final bottomNavBar = BottomNavigationBar(
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

    //Fin Bottom Navigation Bar


    return Scaffold(
      body: Pages(_currentIndex),
      bottomNavigationBar: bottomNavBar,
    );
  }
  }


