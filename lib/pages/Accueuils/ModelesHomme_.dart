import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_modele.dart';
import 'package:fashiontailor/models/modele.dart';
import 'package:flutter/foundation.dart';

import '../Configurations/Parametres.dart';
import 'detailsPhotos.dart';
import 'package:flutter/material.dart';

class AlbumCell extends StatelessWidget {

  String cheminImage = '';
  Modele modeleData;
  AlbumCell(this.cheminImage,this.modeleData);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(7.0),
        child: Container(
          alignment: Alignment.center,
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child:
            kIsWeb
                ? Image.network(modeleData.imgmodele)
                : FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: 'assets/Spinner.gif',
                image: modeleData.imgmodele),

            // Image(
            //   image: AssetImage('assets/modele_femme_image2.jpg'),
            //   fit: BoxFit.fill,
            // ),
          ),
        ),
      ),
    );
  }
}


class Constants {
  static const String Parametres = 'Paramètres';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String>[
    Parametres,
    Quitter
  ];
}



class AlbumGidView extends StatefulWidget {

  static String albumGridTag = 'albumGridTag';
  static String albumGridTag1 = 'tagTenuesBomba';
  static String albumGridTag2 = 'tagChemise';
  static String albumGridTag3 = 'tagTenuesLocales';
  static String albumGridTag4 = 'tagTenuesGoodLuck';
  static String albumGridTag5 = 'tagTenueAfricaineModerne';

  String titleGenre;
  String nomModele;
  AlbumGidView(this.titleGenre, this.nomModele);

  @override
  _AlbumGidViewState createState() => _AlbumGidViewState();
}

class _AlbumGidViewState extends State<AlbumGidView>  {

  //catalogues
  List<AlbumCell> album  = [];

  Cloud_Service_Modele ctrCloudModele = new Cloud_Service_Modele();
  CollectionReference _collectionRef =FirebaseFirestore.instance.collection('Modele');

  @override
  void initState() {
    super.initState();
    // _chargerPhotosCatalogues() ;

  }

  goToDetailsPage(BuildContext context,Modele modele){
    Navigator.push(context, MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => DetailsPhotos(modele)
    )
    );
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
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
    print("Abed");
    print(album);

    final appbar1 = AppBar(
      title: Text(widget.titleGenre),
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

    //FinAppbar


    return Scaffold(
      appBar: appbar1,
      body: RefreshIndicator(
        onRefresh: getRefresh,
        child: StreamBuilder<QuerySnapshot>(
          stream: ctrCloudModele.chargerToutLesModelesAleatoire(),
          // A ecrire en cs_client apres
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Il y a des erreurs');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  :Container(
                padding: EdgeInsets.all(4),
                child: GridView.builder
                  (
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {

                      DocumentSnapshot dataModele = snapshot.data.docs[index];
                      Modele modele = Modele.fromSnapshots(dataModele);
                      //print(modele.imgmodele);

                      return Container(
                        margin: EdgeInsets.all(3),
                        child: GridView.count(
                            // crossAxisCount: 1,
                            // childAspectRatio: 0.5,
                            // mainAxisSpacing: 0.0,
                            // crossAxisSpacing: 0.0,
                            crossAxisCount: 2,
                            padding: EdgeInsets.all(20.0),
                            childAspectRatio: 0.99,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0,
                            children:
                            List.generate(snapshot.data.docs.length, (index){
                              return GestureDetector(
                                child:
                                GridTile(
                                  child: new AlbumCell('cheminImage', modele),
                                ),
                                onTap: (){
                                  goToDetailsPage(context,modele);
                                },
                              );
                            })
                        ),
                      );
                    }),
              );

            }
          },
        ),
      ),
    );
  }
}


