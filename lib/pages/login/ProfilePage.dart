import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCouturier extends StatefulWidget {
  @override
  _ProfileCouturierState createState() => _ProfileCouturierState();
}

class _ProfileCouturierState extends State<ProfileCouturier> {

  File imageFile;

  _prendrePhoto() async
  {
    try {
      final picker = ImagePicker();
      final photo = await picker.getImage(source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200,
      );
      setState(()
      {
        if (photo != null) {
          imageFile = File(photo.path);
        } else
        {
          print('Aucune image sélectionnée');
        }
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  _ouvrirGallery() async {
    try {
      final picker = ImagePicker();
      final photo = await picker.getImage(source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200,
      );
      setState(()
      {
        if (photo != null) {
          imageFile = File(photo.path);
        } else {
          print('Aucune image sélectionnée');
        }
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }


  Future<void> _showChoiceDialog(BuildContext context) async {
    return await showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text(
          'Ajouter une photo',
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

  _decideImageView() {
    if (imageFile == null) {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/avatar.png'),
        radius: 65.0,
      );
    } else {
      return CircleAvatar(
        //backgroundImage: null,
        child: ClipOval(
            child: Image.file(imageFile,)
        ),
        radius: 65.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final appbarProfile = AppBar(
      title: Text('Mon compte'),
      centerTitle: true,
    );

    return Scaffold(
      appBar: appbarProfile,
      body: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 0.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Stack(
                        children: <Widget>[
                          _decideImageView(),
                          Positioned(
                            top: 90.0,
                            left: 90.0,
                            child: InkWell(
                              onTap: (){
                                return _showChoiceDialog(context);
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.add_a_photo),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 35.0,),
                Padding(
                  padding: const EdgeInsets.only(left:40.0,right:40.0 ),
                  child: Divider(
                    height: 0.0,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.0,),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.deepPurpleAccent,),
                  title: Text(
                    'Nom',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  subtitle: Text(
                    'LEWHE Habib',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  trailing: Icon(Icons.edit),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 68.0),
                  child: Text("C'est ce nom qui sera visible par tous"),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  leading: Icon(Icons.business, color: Colors.deepPurpleAccent,),
                  title: Text(
                    'Spécialité',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  subtitle: Text(
                    'Styliste',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  trailing: Icon(Icons.edit),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  leading: Icon(Icons.style, color: Colors.deepPurpleAccent,),
                  title: Text(
                    'Type de couturier',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  subtitle: Text(
                    'Couturier Homme',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  trailing: Icon(Icons.edit),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  leading: Icon(Icons.call, color: Colors.deepPurpleAccent,),
                  title: Text(
                    'Téléphone',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  subtitle: Text(
                    '61951451',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  trailing: Icon(Icons.edit),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  leading: Icon(Icons.place, color: Colors.deepPurpleAccent,),
                  title: Text(
                    'Adresse',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  subtitle: Text(
                    'Ekpe Marina Pk10',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  trailing: Icon(Icons.edit),
                ),
                SizedBox(height: 20.0,),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    'E-Couture',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.blue
                    ) ,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
