import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_client.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_commande.dart';
import 'package:fashiontailor/models/client.dart';
import 'package:fashiontailor/utils/storage_util.dart';

import '../Commandes/CreationCommande.dart';
import '../login/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ChoisirClient extends StatefulWidget {
  static String tagChoisirClient = 'tagChoisirClient';

  @override
  _ChoisirClientState createState() => _ChoisirClientState();
}

class DesignListe {
  //
  String nomClient = '';
  String avatarCLient = '';
  String numTelClient = '';

  DesignListe({this.nomClient, this.avatarCLient, this.numTelClient});
}

class _ChoisirClientState extends State<ChoisirClient> {
  final dbFirestore = FirebaseFirestore.instance;
  Cloud_Service_Client ctrCloudClient = new Cloud_Service_Client();
  Cloud_Service_Commande ctrCloudCommande= new Cloud_Service_Commande();

  String idCommande='0';
  var token = '';

  @override
  void initState() {
    super.initState();
    token = StorageUtil.getString("token");
    ajoutNbreCategorie();
    _refreshData();
  }


  Future<void> _refreshData() async {
    await StorageUtil.getInstance();
  }


  Future<void> ajoutNbreCategorie()
  async {
    final QuerySnapshot qSnap = await dbFirestore.collection('Commande').get();
    final int document = qSnap.docs.length +1;

    token = StorageUtil.getString("token");
    print("Voici le token choisir commande :"+token);

    DateTime currentDate = new DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd'); // On modelise le format de façon générale
    final String formattedDay = formatter.format(currentDate);
    //yyyyMMddhhmmss
    String currentdate = DateFormat('hhddmmMMss').format(currentDate);

    idCommande='CMD0${document}T${currentdate}';
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Widget listeclient() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: StreamBuilder<QuerySnapshot>(
        //stream: ctrCloudClient.chargerToutLesClientsDuCouturier(widget.idUserOne),
        stream: ctrCloudClient.chargerToutLesClientsDuCouturier(token),
        // A ecrire en cs_client apres
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Il y a des erreurs');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return !snapshot.hasData
                ? Text('PLease Wait')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot dataClient = snapshot.data.docs[index];
                      Client client = Client.fromSnapshots(dataClient);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        child: Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              ajoutNbreCategorie();

                              print('ID Commande fourni:');
                              print(idCommande);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) =>
                                          CreerCommande(
                                            client: client,idCommande: idCommande,
                                          )));
                            },
                            title: Text(client.prenomclient.toString() +
                                ' ' +
                                client.nomclient.toString()),
                            subtitle: Text(client.telephoneclient.toString()),
                            leading: CircleAvatar(
                              // child: Image.network("${client.avatarclient}"),
                              //AssetImage('assets/${client.avatarclient}'),

                              backgroundImage: ((client.avatarclient == '') ||
                                      (client.avatarclient == null))
                                  ? AssetImage('assets/avatar.png')
                                  : NetworkImage(client.avatarclient),
                              radius: 25,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Appbar
    final appbarListClient = AppBar(
      title: Text('Choisir un client'),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null),
      ],
    );
    //Fin Appbar

    return Scaffold(
      appBar: appbarListClient,
      body: listeclient(),
    );
  }
}
