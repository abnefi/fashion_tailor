import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  File _image;
  bool isLoading = false;
  bool isRetrieved = false;
  QuerySnapshot cachedResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Second Page"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              !isRetrieved
                  ? FutureBuilder(
                future: getImages(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    isRetrieved = true;
                    cachedResult = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(
                                snapshot.data.docs[index]["name"]),
                            leading: Image.network(
                                snapshot.data.docs[index]["url"],
                                fit: BoxFit.fill),
                          );
                        });
                  } else if (snapshot.connectionState ==
                      ConnectionState.none) {
                    return Text("No data");
                  }
                  return CircularProgressIndicator();
                },
              )
                  : displayCachedList(),

              /// TODO: cache images correctly
              ElevatedButton(child: Text("Pick Image"), onPressed: getImage),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                _image,
                height: 300,
              ),
              !isLoading
                  ? ElevatedButton(
                  child: Text("Save Image"),
                  onPressed: () async {
                    if (_image != null) {
                      setState(() {
                        this.isLoading = true;
                      });

                      Reference ref = FirebaseStorage.instance.ref();
                      TaskSnapshot addImg =
                      await ref.child("images/avatars").putFile(_image);
                      print("Ajouter à Firebase Storage");

                      if (addImg.state == TaskState.success) {
                        final String downloadUrl =
                        await addImg.ref.getDownloadURL();
                        await FirebaseFirestore.instance
                            .collection("images")
                            .add({"url": downloadUrl, "name": _image.path});
                        setState(() {
                          this.isLoading = false;
                        });
                        print("Ajouter à Firebase storing");
                      }
                    }
                  })
                  : CircularProgressIndicator(),
            ]),
          ),
        ));
  }

  Future getImage() async {
    try {
      final _picker = ImagePicker();
      var image = await _picker.getImage(source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200,);

      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }


  }

  Future<QuerySnapshot> getImages() {
    return fb.collection("images").get();
  }

  ListView displayCachedList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cachedResult.docs.length,
        itemBuilder: (BuildContext context, int index) {
          print(cachedResult.docs[index]["url"]);
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(cachedResult.docs[index]["name"]),
            leading: Image.network(cachedResult.docs[index]["url"],
                fit: BoxFit.fill),
          );
        });
  }
}
