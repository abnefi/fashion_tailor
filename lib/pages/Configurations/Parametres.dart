import '../login/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Parametres extends StatefulWidget {
  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/modele_femme_image5.jpg'),
                    radius: 35.0,
                  ),
                  SizedBox(width: 15.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Habib LEWHE',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Styliste , ',
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                          Text(
                            '61951451',
                            style: TextStyle(
                              fontSize: 13
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 25.0,
            ),
            SizedBox(height: 20.0,),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.person),
              ),
              title: Text(
                'Compte',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
              subtitle: Text(
                'Nom, Prenom, Contact, Adresse ...'
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => ProfileCouturier()
                )
                );
              },
            ),
            SizedBox(height: 15.0,),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.power_settings_new,),
              ),
              title: Text(
                'Deconnexion',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
              onTap: (){
                print('clicked');
              },
            ),
            Expanded(
              child: Align(
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
            )
          ],
        ),
      ),
    );
  }
}
