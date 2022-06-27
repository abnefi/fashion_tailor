import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_modele.dart';
import 'package:fashiontailor/models/modele.dart';
import 'package:fashiontailor/pages/Configurations/Parametres.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:transparent_image/transparent_image.dart';

import '../Configurations/Parametres.dart';

import 'add_image.dart';

class CatalogueAccueil extends StatefulWidget {
  @override
  _CatalogueAccueilState createState() => _CatalogueAccueilState();
}

class Constants{
  static const String Parametres = 'Paramètres';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String> [
    Parametres,Quitter
  ];
}

class _CatalogueAccueilState extends State<CatalogueAccueil> {
  Cloud_Service_Modele ctrCloudModele = new Cloud_Service_Modele();
  var token = '';

  @override
  void initState() {
    super.initState();
    token = StorageUtil.getString("token");
  }
  Future<Null> getRefresh() async
  {
    await Future.delayed(Duration(seconds: 3));
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
      body: RefreshIndicator(
        onRefresh: getRefresh,
        child: StreamBuilder(
          stream: ctrCloudModele.chargerToutLesModelesDuCouturier(token),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Il y a des erreurs');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : Container(
                padding: EdgeInsets.all(4),
                child: GridView.builder(
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {

                      DocumentSnapshot dataModele = snapshot.data.docs[index];
                      Modele modele = Modele.fromSnapshots(dataModele);
                      print(modele.imgmodele);

                      return Container(
                        margin: EdgeInsets.all(3),

                        child: kIsWeb
                            ? Image.network(modele.imgmodele)
                            : FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/Spinner.gif',
                            image: modele.imgmodele),

                        // child: FadeInImage.assetNetwork(
                        //     fit: BoxFit.cover,
                        //     placeholder: 'assets/Spinner.gif',
                        //     image: modele.imgmodele),
                      );
                    }),
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, right: 10.0),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddImage()));
          },
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
