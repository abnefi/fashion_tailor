import 'package:fashiontailor/models/modele.dart';
import 'package:flutter/material.dart';

class DetailsPhotos extends StatefulWidget {
  Modele modele;
  DetailsPhotos(this.modele);

  @override
  _DetailsPhotosState createState() => _DetailsPhotosState();
}

class _DetailsPhotosState extends State<DetailsPhotos> {

  //Appbar
  final appbar = AppBar(
    title: Text('Modèles'),
  );
  //Fin Appbar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/modele_femme_image1.jpg'),
            ),
            SizedBox(
              height: 20.0,
            ),
            // ignore: deprecated_member_use
            ElevatedButton(
              child: Icon(
                  Icons.close
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
