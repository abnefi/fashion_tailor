import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_client.dart';
import 'package:fashiontailor/pages/widgets/RadialExpansionImage.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../data/Controles/CtrClient.dart';

import 'CreationClient.dart';
import 'DetailsClients.dart';
import 'ModifierClient.dart';
import '../login/ProfilePage.dart';
import '../Commandes/CreationCommande.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/client.dart';

class ListeClients extends StatefulWidget {
  final String idUserOne;

  ListeClients({Key key, @required this.idUserOne}) : super(key: key);

  @override
  _ListeClientsState createState() => _ListeClientsState();
}

class _ListeClientsState extends State<ListeClients> {
  List<Client> list_itemsClients = new List();
  List<Client> list_itemsClientsactu = new List();
  CtrClient ctrClient = new CtrClient();
  Client client_vide;
  final dbFirestore = FirebaseFirestore.instance;
  Cloud_Service_Client ctrCloudClient = new Cloud_Service_Client();
  var token = '';
  bool isSearching = false;
  String texteRecherche = "";


  @override
  void initState() {
    print('idClien '+widget.idUserOne);
    super.initState();
    token = StorageUtil.getString("token");
    client_vide = new Client(
        null,
        null,
        null,
        '',
        '',
        'M',
        'Noir',
        'image2.jpg',
        '64469339',
        'CI',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0);
    // Appel de mise à jour de la liste des clients
    //miseAjourListeClient(widget.idUserOne);
  }

  void _deleteClient(BuildContext context, Client client, int position) async {
    ctrCloudClient.supprimerClient(client.idclientFirestore);
    setState(() {
      // Je reinitialise la liste snapshort
    });
  }

  void _nouvelleCommandeDialog(Client client) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Opération sur le client'),
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.note_add,
                          color: Colors.lightBlue,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Nouvelle commande',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreerCommande(
                                  client: client)
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _supprimerClient(BuildContext context, Client client, int position) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Voulez-vous supprimer le client ?',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              VerticalDivider(
                color: Colors.black45,
                width: 1.0,
              ),
              FlatButton(
                child: Text(
                  'Supprimer',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 15.0),
                ),
                onPressed: () {
                  _deleteClient(context, client, position);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<Null> getRefresh() async
  {
    await Future.delayed(Duration(seconds: 2));
  }

  Widget listeclient() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: StreamBuilder<QuerySnapshot>(
        //stream: ctrCloudClient.chargerToutLesClientsDuCouturier(widget.idUserOne),
        stream: (texteRecherche != "" || texteRecherche != null)
            ? ctrCloudClient.chargerToutLesClientsFiltrerDuCouturier(token,texteRecherche)
            : ctrCloudClient.chargerToutLesClientsDuCouturier(token),

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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4.0),
                    child: Slidable(
                      key: ValueKey(client.idclient),


                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {
                          setState(() {
                            _deleteClient(context, client, index);
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
                        children: [ // J'ai enlevé le "const"
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed:  (context) => _supprimerClient(context, client, index),
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Supprimer',
                          ),
                          SlidableAction(
                            onPressed: (context) => _nouvelleCommandeDialog(client),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.note_add,
                            label: 'Commander',
                          ),
                        ],
                      ),


                      // actionPane: SlidableDrawerActionPane(),
                      // secondaryActions: <Widget>[
                      //   IconSlideAction(
                      //     icon: Icons.note_add,
                      //     caption: 'Commander',
                      //     color: Colors.blueAccent,
                      //     onTap: () => _nouvelleCommandeDialog(client),
                      //   ),
                      //   IconSlideAction(
                      //     icon: Icons.delete,
                      //     caption: 'Supprimer',
                      //     color: Colors.redAccent,
                      //     onTap: () => _supprimerClient(context, client, index),
                      //   )
                      // ],
                      // dismissal: SlidableDismissal(
                      //   child: SlidableDrawerDismissal(),
                      //   onDismissed: (direction) {
                      //     setState(() {
                      //       _deleteClient(context, client, index);
                      //     });
                      //
                      //     Scaffold.of(context).showSnackBar(SnackBar(
                      //       content: Text(
                      //           '${client.prenomclient.toString()} supprimé'),
                      //       action: SnackBarAction(
                      //         label: 'Annulé',
                      //         onPressed: () {
                      //           setState(() {
                      //             //list_itemsClients.insert(index, client);
                      //           });
                      //         },
                      //       ),
                      //     ));
                      //   },
                      // ),

                      

                      child: Card(
                        elevation: 1.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsClients(
                                    client: client),
                              ),
                            );
                          },
                          title: Text(capitalize(client.prenomclient.toString())+' '+client.nomclient.toString()),
                          subtitle: Text(client.telephoneclient.toString()),
                          leading: RadialExpansionImage(imageName: client.avatarclient,description: client.prenomclient,user: client.avatarclient),
                          // leading: CircleAvatar(
                          //   // child: Image.network("${client.avatarclient}"),
                          //   //AssetImage('assets/${client.avatarclient}'),
                          //   backgroundImage: ((client.avatarclient=='') || (client.avatarclient==null))
                          //       ?AssetImage('assets/avatar.png')
                          //       :NetworkImage(client.avatarclient),
                          //   radius: 25,
                          // ),
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

  @override
  Widget build(BuildContext context) {
    void ChoiceAction(String choice) {
      if (choice == 'Paramètres') {
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => ProfileCouturier()));
      } else if (choice == 'Quitter') {
        Navigator.of(context).pop();
      }
    }


    //Appbar
    final appbarListClient = AppBar(
      title: !isSearching
          ? Text('Clients')
          : TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        onChanged: (val) {
          setState(() {
            texteRecherche = val;
          });
        },
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Rechercher',
            hintStyle: TextStyle(color: Colors.white)),
      ),
      actions: <Widget>[
        isSearching
            ? IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                this.isSearching = false;
                texteRecherche = null;
              });
            })
            : IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            }),
        PopupMenuButton<String>(
          onSelected: ChoiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choices) {
              return PopupMenuItem<String>(
                value: choices,
                child: Text(choices),
              );
            }).toList();
          },
        ),
      ],
    );







    return Scaffold(
      appBar: appbarListClient,
      body: listeclient(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, right: 10.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreerClient(
                  client: client_vide,
                  iduserOnline: widget.idUserOne,
                ),
              ),
            );
          },
        ),
      ),
    );


  }
}

class Constants {
  static const String MonCompte = 'Mon compte';
  static const String Parametres = 'Paramètres';
  static const String Partager = 'Partager';
  static const String Apropos = 'A propos';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String>[
    MonCompte,
    Parametres,
    Partager,
    Apropos,
    Quitter
  ];
}

void ChoiceAction(String choice) {
  //print ('Working');
  if (choice == 'Mon compte') {
    print('je veux manger');
  }
}
