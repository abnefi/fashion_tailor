import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_tenue.dart';
import 'package:fashiontailor/models/client.dart';
import 'package:fashiontailor/models/tenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/Cloud_Service/cs_client.dart';
import '../../data/Cloud_Service/cs_commande.dart';
import '../../models/commande.dart';
import '../widgets/RadialExpansionImage.dart';

class DetailsCommandes extends StatefulWidget {
  static String tagDetailsCommandes = 'tagDetailsCommandes';
  final Commande commande;

  DetailsCommandes({Key key, @required this.commande}) : super(key: key);

  @override
  _DetailsCommandesState createState() => _DetailsCommandesState();
}

class TenueAjouter {
  //
  String avatarTenue = '';

  TenueAjouter({this.avatarTenue});
}

class _DetailsCommandesState extends State<DetailsCommandes> {
  List<TenueAjouter> listeDesTenues;
  Cloud_Service_Client ctrCloudClient = new Cloud_Service_Client();
  Cloud_Service_Tenue ctrCloudTenue = new Cloud_Service_Tenue();
  Cloud_Service_Commande ctrCloudCommande = new Cloud_Service_Commande();

  Client client;

  DateTime _dateTime, _dateTime1;
  DateTime currentDate = new DateTime.now();

  @override
  void initState()
  {
    super.initState();
    listeDesTenues = List();

    _dateTime = new DateFormat('dd/MM/yyyy').parse(widget.commande.datecommande);
    _dateTime1 = new DateFormat('dd/MM/yyyy').parse(widget.commande.datelivraison);
    _chargerClient(widget.commande.idclient_c);
  }


  Future<Null> _selectDate(BuildContext context) async
  {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime == null ? currentDate : _dateTime,
      firstDate: DateTime(2021),
      lastDate: _dateTime1 == null ? DateTime(2050) : _dateTime1,
    );
    if (picked != null && picked != _dateTime) {
      setState(() {
        ctrCloudCommande.editCommandeDateCommande(widget.commande.idcommande, DateFormat('dd/MM/yyyy').format(picked));
        _dateTime = picked;
      });
    }
  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime1 == null
          ? (_dateTime == null
          ? currentDate
          : new DateTime(
          _dateTime.year, _dateTime.month, _dateTime.day + 1))
          : _dateTime1,
      firstDate: _dateTime == null
          ? currentDate
          : new DateTime(_dateTime.year, _dateTime.month, _dateTime.day),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _dateTime1) {
      setState(() {
        ctrCloudCommande.editCommandeDateLivraison(widget.commande.idcommande, DateFormat('dd/MM/yyyy').format(picked));
        _dateTime1 = picked;
      });
    }
  }


  Future<void> _chargerClient(idclient) async {
    print(idclient);
    client = await ctrCloudClient.getClient(idclient);
    print(client.prenomclient + ' ' + client.nomclient);
  }

  addTenues() {
    listeDesTenues.add(TenueAjouter(
      avatarTenue: 'modele_femme_image1.jpg',
    ));
    listeDesTenues.add(TenueAjouter(
      avatarTenue: 'modele_femme_image2.jpg',
    ));
  }

  Widget listetenues() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: StreamBuilder<QuerySnapshot>(
        stream: ctrCloudTenue
            .chargerLesTenuesParCommande(widget.commande.idcommandeTenue),

        // A ecrire en cs_client apres
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Une erreur s\'est produite");
          if (snapshot.connectionState != ConnectionState.done) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot dataTenue = snapshot.data.docs[index];
                        Tenue tenue = Tenue.fromSnapshots(dataTenue);
                        print(tenue.descriptiontenue.toString());
                        int chiffre = 1;
                        chiffre += index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 4.0),
                          child: Slidable(
                            key: ValueKey(tenue.idtenue),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                setState(() {
                                  //_deleteClient(context, client, index);
                                });

                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${client.prenomclient.toString()} supprimé'),
                                  action: SnackBarAction(
                                    label: 'Annulé',
                                    onPressed: () {
                                      setState(() {
                                        //list_itemsClients.insert(index, client);
                                      });
                                    },
                                  ),
                                ));
                              }),

                              // All actions are defined in the children parameter.
                              children: [
                                // J'ai enlevé le "const"
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) =>null,
                                  //_supprimerClient(context, client, index),
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Supprimer',
                                ),
                                SlidableAction(
                                  onPressed: (context) =>null,
                                  //_nouvelleCommandeDialog(client),
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  icon: Icons.note_add,
                                  label: 'Commander',
                                ),
                              ],
                            ),

                            child: Card(
                              elevation: 1.0,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  return _voirDetailTenue(tenue,chiffre.toString());
                                },
                                title: Text('Tenue ' + '${chiffre}'),
                                subtitle: Text(tenue.descriptiontenue.toString()),
                                leading: RadialExpansionImage(
                                    imageName: tenue.imgtissu,
                                    description: tenue.descriptiontenue.toString(),
                                    user: tenue.idtenue),

                              ),
                            ),
                          ),
                        );
                      },
                    );
            }
          } else {
            return Center(child: Text('Verifier votre connexion'));
          }
        },
      ),
    );
  }

  void _voirDetailTenue(Tenue tenue, String position) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Tenue '+position+' '+tenue.descriptiontenue.toString(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Photo du tissu',
                    style: TextStyle(fontSize: 15, color: Colors.lightBlue),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(
                      child: Image(
                        image: ((tenue.imgtissu=='') || (tenue.imgtissu==null))
                            ?AssetImage('assets/avatar.png')
                            :NetworkImage(tenue.imgtissu),
                        fit: BoxFit.fitWidth,
                        height: 200,
                        width: 400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Photo du modèle',
                    style: TextStyle(fontSize: 15, color: Colors.lightBlue),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(
                      child: Image(
                        image: ((tenue.imgmodele=='') || (tenue.imgmodele==null))
                            ?AssetImage('assets/avatar.png')
                            :NetworkImage(tenue.imgmodele),
                        fit: BoxFit.fitWidth,
                        height: 200,
                        width: 400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Type de tenue :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(tenue.typetenue.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Observation',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tenue.observation.toString()),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Modifier',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Widget maCommande()
  {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: StreamBuilder<QuerySnapshot>(
        stream: ctrCloudClient.chargerUnSeulClient(widget.commande.idclient_c),
        // A ecrire en cs_client apres
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Une erreur s\'est produite");
          if (snapshot.connectionState != ConnectionState.done) {
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
                        print(client.telephoneclient.toString());
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RadialExpansionImage(
                                          imageName: client.avatarclient,
                                          description: client.prenomclient,
                                          user: client.idclientFirestore),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        client.nomclient.toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Sexe: ' +
                                            client.sexeclient.toString() +
                                            ' , Teint: ' +
                                            client.teintclient.toString(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        client.telephoneclient.toString(),
                                        style: TextStyle(fontSize: 18.0),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Details de la commande',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontFamily: 'Roboto Medium',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.lightBlue,
                              height: 0.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Date de la commande'),
                                    subtitle: Text(DateFormat('dd/MM/yyyy').format(_dateTime)),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.mode_edit,color: Colors.lightBlueAccent,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Date de livraison'),
                                    subtitle: Text(DateFormat('dd/MM/yyyy').format(_dateTime1)),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.mode_edit,color: Colors.lightBlueAccent,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        _selectDate1(context);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Tenues ajoutée(s)',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.lightBlue),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: listetenues(),
                                  )
                                  /*Container(
                      margin: EdgeInsets.only(left: 10.0, top: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      child: FlatButton(
                          child: Text(
                            'Tenue(s) commandé(s)',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        onPressed: (){
                        },
                      ),
                    ),*/
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
            }
          } else {
            return Center(child: Text('Verifier votre connexion'));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appbarDetailsCommande = AppBar(
      title: Text('Info commande'),
    );

    return Scaffold(appBar: appbarDetailsCommande, body: maCommande());
  }
}
