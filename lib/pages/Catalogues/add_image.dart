import 'dart:io';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_modele.dart';
import 'package:fashiontailor/models/modele.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;
  //CollectionReference imgRef;
  firebase_storage.Reference ref;

  Cloud_Service_Modele ctrCloudModele = new Cloud_Service_Modele();

  List<File> _image = [];
  final picker = ImagePicker();

  var token = '';
  final double volume = kIsWeb ? 0.0 : 1.0;

  _prendrePhoto() async {

    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 200,
    );
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile?.path));
      } else {
        print('Aucune image sélectionnée');
      }
    });

    if (pickedFile.path == null) retrieveLostData();
    Navigator.of(context).pop();
  }

  _ouvrirGallery() async
  {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 200,
    );

    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile?.path));
        print(pickedFile?.path);
      } else {
        print('Aucune image sélectionnée');
      }
    });

    if (pickedFile.path == null) retrieveLostData();
    Navigator.of(context).pop();
  }

  Future<void> _DialogChooseImage(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Ajouter un modèle',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Prendre une photo',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      _prendrePhoto();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    child: Text(
                      'Ouvrir la Gallery',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      _ouvrirGallery();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    child: Text(
                      'Annuler',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Image'),
          actions: [
            FlatButton(
                onPressed: () {
                  setState(() {
                    uploading = true;
                  });
                  uploadFile().whenComplete(() => Navigator.of(context).pop());
                },
                child: Text(
                  'upload',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                      child: IconButton(
                          icon: Icon(Icons.library_add),
                          onPressed: () => !uploading
                              ? _DialogChooseImage(context)
                              : null),
                    )
                        : Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: kIsWeb
                                  ? NetworkImage(_image[index - 1].path)
                                  : FileImage(File(_image[index - 1].path)) ,
                              //FileImage(_image[index - 1]),
                              fit: BoxFit.cover)),
                    );
                  }),
            ),
            uploading
                ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        'uploading...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      value: val,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    )
                  ],
                ))
                : Container(),
          ],
        ));
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
        print('Ajout de fichier');
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/catalogues/${Path.basename(img.path)}');

      print(Path.basename(img.path));

      if(kIsWeb){
        await ref.putData(
          await img.readAsBytes(),SettableMetadata(contentType: 'image/jpeg'),
        ).whenComplete(() async {
          await ref.getDownloadURL().then((value)
          {
            ctrCloudModele.insertDataModele(Modele(null, token, value,'Cat Elt a gerer apres ex', 'Haute couture ex', 'Favorites', 1,0,0,DateFormat('dd/MM/yyyy').format(new DateTime.now()),''));
            i++;
            print('img numero Web: ${i}');
          });
        });
      }else{
        //write a code for android or ios
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value)
          {
            ctrCloudModele.insertDataModele(Modele(null, token, value,'Cat Elt a gerer apres ex', 'Haute couture ex', 'Favorites', 1,0,0,DateFormat('dd/MM/yyyy').format(new DateTime.now()),''));
            i++;
            print('img numero: ${i}');
          });
        });
      }




    }
  }

  @override
  void initState() {
    super.initState();
    token = StorageUtil.getString("token");
  }
}
