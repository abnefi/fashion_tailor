import 'dart:io';

import '../Configurations/Parametres.dart';
import '../login/ProfilePage.dart';
import 'package:flutter/material.dart';
 import 'package:image_picker/image_picker.dart';

class Catalogue extends StatefulWidget {
  @override
  _CatalogueState createState() => _CatalogueState();
}

class Constants{
  static const String Parametres = 'Paramètres';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String> [
    Parametres,Quitter
  ];
}

class _CatalogueState extends State<Catalogue> {

  File imageFile;
  final picker = ImagePicker();

  _prendrePhoto() async{
    final photo = await picker.getImage(source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 200,
    );
    this.setState(()
    {
      if (photo != null) {
        imageFile = File(photo.path);
      } else {
        print('Aucune image sélectionnée');
      }
    });
    Navigator.of(context).pop();
  }


  _ouvrirGallery() async{
    final photo = await picker.getImage(source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    this.setState(()
    {
      if (photo != null) {
        imageFile = File(photo.path);
      } else {
        print('Aucune image sélectionnée');
      }
    });
    Navigator.of(context).pop();
  }


  Future<void> _showChoiceDialog(BuildContext context) async {
    return await showDialog(context: context,barrierDismissible: false ,builder: (BuildContext context){
      return AlertDialog(
        title: Text(
          'Ajouter un modèle',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'Prendre une photo',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: (){
                  _prendrePhoto();
                },
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                child: Text(
                  'Ouvrir la Gallery',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: (){
                  _ouvrirGallery();
                },
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                child: Text(
                  'Annuler',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Center(child: Text("Pas de modeles ajoutés !",
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.red
      ),
      ));
    }else{
      return Center(child: Image.file(imageFile,width: 400,height: 400,));
    }
  }

  @override
  Widget build(BuildContext context) {

    void ChoiceAction(String choice){
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

    final appbarCatalogue = AppBar(
      title: Text('Catalogue'),
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

    return Scaffold(
      appBar: appbarCatalogue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _decideImageView()
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, right: 10.0),
        child: FloatingActionButton(
          onPressed: (){
            return _showChoiceDialog(context);
          },
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
