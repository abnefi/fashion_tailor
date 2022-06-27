import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final appbar1 = AppBar(
  title: Text('E-Couture'),
  actions: <Widget>[
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
    )
  ],
);

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
    //print ('Working');
    if(choice == 'Mon compte'){
      print('je veux manger');
    }
  }