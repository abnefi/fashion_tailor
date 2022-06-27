import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewScreen extends StatelessWidget {
  int count = 0;
  void _addImages() {
    var storage = FirebaseStorage.instance;
    List<String> listOfImage = [
      'assets/images/6GEbGk59YG4cInivd8An_avatar.png',
      'assets/images/DuJ00NsTg3aUgWqQqL99_avatar.png',
      'assets/images/hsvefF3RibLgv48E7NSW_avatar.png',
      'assets/images/L3KN0xQjQLCmXcGEf46h_avatar.png',
      'assets/images/NddKDs1nER8AAVtOCtDG_avatar.png',
      'assets/images/OV1ePu9jT6Z3RcjE0O6F_avatar.png',
      'assets/images/stX5vnxIkMf942Ggfmwz_avatar.png',
      'assets/images/avatar1.png',
      'assets/images/avatar2.png',
      'assets/images/avatar3.png',
    ];

    listOfImage.forEach((img) async {
      String imageName = img
          .substring(img.lastIndexOf("/"), img.lastIndexOf("."))
          .replaceAll("/", "");

      String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

      final Directory systemTempDir = Directory.systemTemp;
      final byteData = await rootBundle.load(img);
      final file = File('${systemTempDir.path}/$imageName.jpeg');
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      TaskSnapshot taskSnapshot =
      await storage.ref('$path/$imageName').putFile(file);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection(path)
          .add({"url": downloadUrl, "name": imageName});
      count++;
      print(count);
    });
    print('finished.............');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addImages,
      ),
      appBar: AppBar(
        title: Text('Adding images'),
      ),
      body: Center(
        child: Text('Adding Images to Firebase'),
      ),
    );
  }
}