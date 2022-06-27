import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ModifierClient.dart';
import '../../models/client.dart';

class DetailsClients extends StatefulWidget {
  static String tagDetailClient = 'tagDetailClient';
  Client client;
    DetailsClients(this.client);
  @override
  _DetailsClientsState createState() => _DetailsClientsState();
}

class _DetailsClientsState extends State<DetailsClients> {
  @override
  Widget build(BuildContext context) {

    final appbarDetailsClients = AppBar(
      title: Text('Détails du clients'),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.mode_edit,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed(ModifierClient.tagModifierClient),
        ),
        IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: null
        ),
      ],
      leading:
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );

    final table = Table(
      defaultColumnWidth: FlexColumnWidth(1.0),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('H Poitrine : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('30,5 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lg jupe : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('55,5 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Lg Buste : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('60,3 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Pantalon : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('89 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Lg Corsage : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('20,6 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Dos : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('39,4 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Lg Robe : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('60,4 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Ca Dos : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('45 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Encolure : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('67,3 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Larg Dos : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('90,7 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Ca Devant : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('65 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Manche : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('45 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Tr Poitrine : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('54 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tr de Manche : ', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('85 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Ecart Sein : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('20 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Poignet : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('28 cm'),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text('Tr de Taille : ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('60 cm'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Pente : ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('16 cm'),
                ],
              ),
            ]
        ),
      ],
    );


    return Scaffold(
      appBar: appbarDetailsClients,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/image3.jpg'),
                    radius: 50.0,
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('LEWHE Habib',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                    SizedBox(height: 10.0,),
                    Text('M, Noir',style: TextStyle(fontSize: 18.0),),
                    SizedBox(height: 10.0,),
                    Text('61951451',style: TextStyle(fontSize: 18.0),)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0,),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 15.0),
            child:
            Text(
              'Mesures (cm)',
              style: TextStyle(
                color: Colors.lightBlue,
                fontFamily: 'Roboto Medium',
                fontSize: 15,
              ),
            ),
          ),
          Divider(color: Colors.lightBlue,height: 0.0,),
          SizedBox(height: 30.0,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child:
            Container(
              child: table,
            ),
          )
        ],
      ),
    );
  }
}
