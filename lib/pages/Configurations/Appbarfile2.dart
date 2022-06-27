import '../Accueuils/AccueilPage.dart';
import 'package:flutter/material.dart';

class Appbarfile2 extends StatefulWidget {
  @override
  _Appbarfile2State createState() => _Appbarfile2State();
}

class _Appbarfile2State extends State<AppBar> {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('E-Couture'),
      actions: <Widget>[
        IconButton(
          onPressed: (){
            Navigator.of(context).pushNamed(Accueil.tag);
          },
          icon: Icon(Icons.home),
        ),
        PopupMenuButton <String>(
          onSelected: ChoiceAction,
          itemBuilder: (BuildContext context){
            return Constants.choices.map((String choices){
              return PopupMenuItem<String>(
                value: choices,
                child: Text(choices),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}

class Constants{
  static const String MonCompte = 'Mon compte';
  static const String Parametres = 'Paramètres';
  static const String Partager = 'Partager';
  static const String Apropos = 'A propos';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String> [
    MonCompte,Parametres, Partager, Apropos, Quitter
  ];
}

void ChoiceAction(String choice){
  print ('Working');
}