import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_modele.dart';
import 'package:fashiontailor/pages/Configurations/SecondPage.dart';
import 'package:fashiontailor/pages/login/ConnexionPage.dart';
import 'package:fashiontailor/pages/Accueuils/AnimationSliderAccueil.dart';
import 'package:fashiontailor/utils/storage_util.dart';

import '../login/InscriptionPage_1.dart';

import '../Configurations/Parametres.dart';
import '../login/ProfilePage.dart';
import 'SousCategorie_Homme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ContenuAccueil extends StatefulWidget {
  final String para_iduserOline;
  ContenuAccueil({Key key, @required this.para_iduserOline}) : super(key: key);
  @override
  _ContenuAccueilState createState() => _ContenuAccueilState();
}

class Constants{
  static const String Parametres = 'Paramètres';
  static const String NouveauCouturier = 'NouveauCouturier';
  static const String NewPhoto = 'NewPhoto';
  static const String Slider = 'Modeles';
  static const String Deconnexion = 'Deconnexion';


  static const List<String> choices = <String> [
    Parametres,NouveauCouturier,NewPhoto,'Modeles',Deconnexion
  ];
}



class _ContenuAccueilState extends State<ContenuAccueil> {

  int photoIndex = 0;

  List<String> photos = [];

  @override
  void initState() {
    _chargerPhotosModeles();
  }

  List<T> map<T> (List list, Function handler){
    List<T> result = [];
    for(var i = 0; i < list.length; i++){
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Cloud_Service_Modele ctrCloudModele = new Cloud_Service_Modele();

  QuerySnapshot slides;

  CollectionReference _collectionRef =FirebaseFirestore.instance.collection('Modele');

  Future<void> _chargerPhotosModeles() async {
    // Get docs from collection reference
    Stream<QuerySnapshot> stream = ctrCloudModele.chargerToutLesModelesAleatoire();

    stream.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        // photos.add(doc.data()['imgmodele']); //Ancien
        photos.add(doc.get('imgmodele'));
      });
    });



    //     QuerySnapshot snap = await   _collectionRef.get();
    // snap.docs.forEach((document) {
    //   photos.add(document.data()['imgmodele']);
    // });

  }

  @override
  Widget build(BuildContext context) {

    void ChoiceAction(String choice){
      //print ('Working');
      if(choice == 'Paramètres'){
        Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => Parametres()
        )
        );
      }
      else if(choice == 'Deconnexion')
      {
        StorageUtil.putString("token", '0');
        StorageUtil.putString("tokenClient", '0');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Connexion()),
              (Route<dynamic> route) => false,
        );
      }else if (choice == 'NouveauCouturier')
      {
        Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => Inscription_1(m_iduser: widget.para_iduserOline,)
        )
        );
      }else if (choice == 'Modeles') {
        Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => AnimationSliderAccueil()
        )
        );
      }else if (choice == 'Connexion') {
        Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => Connexion()
        )
        );
      }
    }

    List<GridModel> model = [
      new GridModel(name:"Hommes", chemin:"assets/modele_homme_image1.jpg"),
      new GridModel(name:"Femmes", chemin:"assets/modele_femme_image4.jpg"),
      new GridModel(name:"Couples", chemin:"assets/modele_couple_image1.jpg"),
      new GridModel(name:"Enfants", chemin:"assets/modele_enfant_image3.jpg")
    ];

    //Appbar
    final appbarCOntAcc = AppBar(
      title: Text('E-Couture',
        style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
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
    //Fin Appbar

    return Scaffold(
      appBar: appbarCOntAcc,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enlargeCenterPage: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                autoPlay: true,
                onPageChanged: (index, reason){
                  setState(() {
                    photoIndex = index;
                    reason = CarouselPageChangedReason.timed;
                  });
                },
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: photos.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        height: MediaQuery.of(context).size.height-525,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/fspinner.gif',
                            image: '$imgUrl'),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map(photos, (index, url){
                return Container(
                  width: photoIndex == index ? 9.0 : 7.0,
                  height: photoIndex == index ? 9.0 : 7.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: photoIndex == index ? Colors.black38 : Colors.grey[350],
                  ),
                );
              }),
            ),
            SizedBox(height: 15.0,),
            Container(
              //padding: EdgeInsets.only(left: 15.0),
              //alignment: Alignment.topLeft,
              child: Text('Catégories',
                  style: GoogleFonts.lobsterTwo(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            SizedBox(height: 10.0,),
            Container(  //Les gridTiles
              height: MediaQuery.of(context).size.height-433,
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(20.0),
                childAspectRatio: 0.99,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 30.0,
                children:
                List.generate(model.length, (index)
                {
                  return
                    GestureDetector(
                      child:
                      GridTile(
                        child:  model[index],
                      ),
                      onTap: (){
                        if(model[index].name == 'Hommes'){
                          Navigator.of(context).pushNamed(SousCategorieHomme.tagHomme);
                        }
                        else if(model[index].name == 'Femmes'){
                          Navigator.of(context).pushNamed(SousCategorieHomme.tagFemme);
                        }else if(model[index].name == 'Couples'){
                          Navigator.of(context).pushNamed(SousCategorieHomme.tagCouples);
                        }else{
                          Navigator.of(context).pushNamed(SousCategorieHomme.tagEnfants);
                        }
                      },
                    );

                }),
              ),
            )
          ],
        ),
      ),
    ) ;

  }
}



class GridModel extends StatelessWidget {
  String name;
  String chemin;

  GridModel({this.name, this.chemin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 0,
            )
          ]
      ),
      child:
      Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                image: DecorationImage(
                    image: AssetImage(chemin),
                    fit: BoxFit.fill
                )
            ),
          ),
          Positioned(  // la bande sur les gridTiles
            bottom: 0.0,
            child:
            Container(
              width: 145,
              height: 30.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(7.0), bottomLeft: Radius.circular(7.0)),
                  color: Colors.blueAccent.withOpacity(0.60)
              ),
              child:
              Text(name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSerifPro(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

}


