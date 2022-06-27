import 'package:fashiontailor/utils/storage_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CreationClient.dart';
import '../../models/client.dart';
import '../../data/Controles/CtrClient.dart';
import '../widgets/RadialExpansionImage.dart';


class DetailsClients extends StatefulWidget {
  static String tagDetailClient = 'tagDetailClient';
  final Client client;
  DetailsClients({Key key, @required this.client}) : super(key: key);

  @override
  _DetailsClientsState createState() => _DetailsClientsState();
}

class _DetailsClientsState extends State<DetailsClients> {

  CtrClient ctrClient = new CtrClient();
  String    _idcouturier_c;
  String _nomclient,_prenomclient,_idclientFirestore,_sexeclient,_teintclient,_avatarclient,_telephoneclient,_code_pays,_ca_dos,_h_poitrine,_lg_buste,_lg_corsage,_lg_robe,_encolure,_ca_devant,_tr_poitrine,_ecart_sein,_tr_de_taille,_lg_jupe,_lg_pantalon,_lg_dos,_larg_dos,_lg_manche,_tr_de_manche,_poignet,_pente;
  var token = StorageUtil.getString("token");
  Client monClient;

  @override
  void initState() {

    super.initState();
    monClient = new Client(
        widget.client.idclient,
        widget.client.idcouturier_c,
        widget.client.idclientFirestore,
        widget.client.nomclient,
        widget.client.prenomclient,
        widget.client.sexeclient,
        widget.client.teintclient,
        widget.client.avatarclient,
        widget.client.telephoneclient,
        widget.client.code_pays,
        widget.client.ca_dos,
        widget.client.h_poitrine,
        widget.client.lg_buste,
        widget.client.lg_corsage,
        widget.client.lg_robe,
        widget.client.encolure,
        widget.client.ca_devant,
        widget.client.tr_poitrine,
        widget.client.ecart_sein,
        widget.client.tr_de_taille,
        widget.client.lg_jupe,
        widget.client.lg_pantalon,
        widget.client.lg_dos,
        widget.client.larg_dos,
        widget.client.lg_manche,
        widget.client.tr_de_manche,
        widget.client.poignet,
        widget.client.pente);

    //remplacer les attributs manuelle par ceux de l'entité apres dans le code
    _nomclient = widget.client.nomclient.toString();
    _prenomclient = widget.client.prenomclient.toString();
    _idclientFirestore = widget.client.idclientFirestore.toString();
    _sexeclient = widget.client.sexeclient.toString();
    _sexeclient = widget.client.sexeclient.toString();
    _avatarclient = widget.client.avatarclient.toString();
    _telephoneclient=widget.client.telephoneclient.toString();
    _code_pays = widget.client.code_pays.toString();
    _ca_dos = widget.client.ca_dos.toString();
    _h_poitrine = widget.client.h_poitrine.toString();
    _lg_buste = widget.client.lg_buste.toString();
    _lg_corsage = widget.client.lg_corsage.toString();
    _lg_robe = widget.client.lg_robe.toString();
    _encolure = widget.client.encolure.toString();
    _ca_devant = widget.client.ca_devant.toString();
    _tr_poitrine = widget.client.tr_poitrine.toString();
    _ecart_sein = widget.client.ecart_sein.toString();
    _tr_de_taille = widget.client.tr_de_taille.toString();
    _lg_jupe = widget.client.lg_jupe.toString();
    _lg_pantalon = widget.client.lg_pantalon.toString();
    _lg_dos = widget.client.lg_dos.toString();
    _larg_dos = widget.client.larg_dos.toString();
    _lg_manche = widget.client.lg_manche.toString();
    _tr_de_manche = widget.client.tr_de_manche.toString();
    _poignet = widget.client.poignet.toString();
    _pente = widget.client.pente.toString();
    _idcouturier_c = widget.client.idcouturier_c;

  }
  
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
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CreerClient(client: monClient,iduserOnline: token),
              ),
              );
            }
            ),
        IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: null
        ),
      ],
      leading:
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );

    final table = Table  (
      defaultColumnWidth: FlexColumnWidth(1.0),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        // 0: FixedColumnWidth(60), // this column has a fixed width of 50
        0: FlexColumnWidth(), // take the remaining space
        1: FlexColumnWidth(), // take the remaining space
        2: FlexColumnWidth(), // take the remaining space
        3: FlexColumnWidth(), // take the remaining space
    },
      children: [
        TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text( monClient.h_poitrine.toString(),
                  ),
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
                  Text(
                   monClient.lg_jupe.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.lg_buste.toString(),
                  ),
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
                  Text(
                   monClient.lg_pantalon.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.lg_corsage.toString(),
                  ),
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
                  Text(
                   monClient.lg_dos.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.lg_robe.toString(),
                  ),
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
                  Text(
                   monClient.ca_dos.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.encolure.toString(),
                  ),
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
                  Text(
                   monClient.larg_dos.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.ca_devant.toString(),
                  ),
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
                  Text(
                   monClient.lg_manche.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.tr_poitrine.toString(),
                  ),
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
                  Text(
                   monClient.tr_de_manche.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.ecart_sein.toString(),
                  ),
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
                  Text(
                   monClient.poignet.toString(),
                  ),
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
                    padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
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
                  Text(
                   monClient.tr_de_taille.toString(),
                  ),
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
                  Text(
                   monClient.pente.toString(),
                  ),
                ],
              ),
            ]
        ),
      ],
    );


    return Scaffold(
      appBar: appbarDetailsClients,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:RadialExpansionImage(imageName: _avatarclient,description: _prenomclient,user: _idclientFirestore),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text( capitalize(monClient.prenomclient.toString()),
                          style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 08.0),
                        Text(
                         monClient.nomclient.toString(),
                          style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 09.0),
                        Text('Sexe: '+ monClient.sexeclient.toString() +' Teint: '+ monClient.teintclient.toString(),
                          style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 09.0),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 07.0,),

              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20.0),
                child:
                Text(
                  'Adresse:  $_code_pays  $_telephoneclient',
                  style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),
                ),
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
                    fontFamily: 'Time New Roman',
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(color: Colors.lightBlue,height: 0.0,),
              SizedBox(height: 15.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: table
                ),
            ],
          ),
        ),
    );
  }


}
 String capitalize( String phrase) {
String a = phrase[0].toUpperCase();
String b = phrase.substring(1);
return a+b ;
}