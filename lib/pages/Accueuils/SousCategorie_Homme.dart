import 'ModelesHomme.dart';
import '../Configurations/Parametres.dart';
import 'package:flutter/material.dart';

class SousCategorieHomme extends StatefulWidget {

  static String tagHomme = 'tagHomme';
  static String tagFemme = 'tagFemme';
  static String tagEnfants = 'tagEnfants';
  static String tagCouples = 'tagCouples';

  String title;
  Widget mylist;
  int sousCategorie;

  SousCategorieHomme(this.title);

  @override
  _SousCategorieHommeState createState() => _SousCategorieHommeState();
}

class _SousCategorieHommeState extends State<SousCategorieHomme> {

  //
  List<DesignModel> modele;

  Widget myListView (){
    return ListView.builder(
      itemCount: modele.length,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => AlbumGidView(widget.title,modele[index].nomModele)
                )
                );
              },
              title: Text(modele[index].nomModele),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${modele[index].imageModele}'),
                radius: 25,
              ),
              trailing: Icon(
                Icons.arrow_right,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    void ChoiceAction(String choice) {
      if(choice == 'Paramètres'){
        Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => Parametres()
        )
        );
      }
      else if(choice == 'Quitter'){
        Navigator.of(context).pop();
      }
    }

    //Appbar
    final appbar1 = AppBar(
      title: Text(widget.title),
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
        ),
      ],
    );

    if(widget.title == 'Homme'){
      modele = [
        DesignModel(nomModele: 'Tenues Bomba moderne', imageModele: 'modele_homme_image1.jpg'),
        DesignModel(nomModele: 'Chemises', imageModele: 'modele_homme_image2.jpg'),
        DesignModel(nomModele: 'Tenues locales', imageModele: 'modele_homme_image3.jpg'),
        DesignModel(nomModele: 'Tenues GoodLuck', imageModele: 'modele_homme_image4.jpg'),
        DesignModel(nomModele: 'Tenue africaine moderne', imageModele: 'modele_homme_image5.jpg'),
      ];
    }else if(widget.title == 'Femme'){
      modele = [
        DesignModel(nomModele: 'Tenues traditionnelles', imageModele: 'modele_femme_image1.jpg'),
        DesignModel(nomModele: 'Robes', imageModele: 'modele_femme_image2.jpg'),
        DesignModel(nomModele: 'Boubou', imageModele: 'modele_femme_image6.jpg'),
        DesignModel(nomModele: 'Jupes', imageModele: 'modele_femme_image8.jpg'),
        DesignModel(nomModele: 'Longues robes', imageModele: 'modele_femme_image5.jpg'),
      ];
    }else if(widget.title == 'Couples'){
      modele = [
        DesignModel(nomModele: 'Tenues traditionnelles', imageModele: 'modele_couple_image1.jpg'),
        DesignModel(nomModele: 'mode africaine moderne', imageModele: 'modele_couple_image12.jpg'),
        DesignModel(nomModele: 'Boubou', imageModele: 'modele_couple_image3.jpg'),
        DesignModel(nomModele: 'Tenues locales', imageModele: 'modele_couple_image4.jpg'),
        DesignModel(nomModele: 'Tenue africaine moderne', imageModele: 'modele_couple_image5.jpg'),
      ];
    }else{
      modele = [
        DesignModel(nomModele: 'Tenue africaine moderne', imageModele: 'modele_enfant_image7.jpg'),
        DesignModel(nomModele: 'Pantalon', imageModele: 'modele_enfant_image2.jpg'),
        DesignModel(nomModele: 'Boubou', imageModele: 'modele_enfant_image5.jpg'),
        DesignModel(nomModele: 'Tenues traditionnelles', imageModele: 'modele_enfant_image3.jpg'),
        DesignModel(nomModele: 'Modele femme', imageModele: 'modele_enfant_image6.jpg'),
      ];
    }

    return Scaffold(
      appBar: appbar1,
      body: myListView(),
    );
  }
}


class DesignModel{
  //
  String nomModele = '';
  String imageModele = '';

  DesignModel({ this.nomModele, this.imageModele});

}


class Constants {
  static const String Parametres = 'Paramètres';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String>[
    Parametres,
    Quitter
  ];
}
