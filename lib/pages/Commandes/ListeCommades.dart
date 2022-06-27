import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_commande.dart';
import 'package:fashiontailor/models/commande.dart';
import 'package:fashiontailor/pages/Clients/DetailsClients.dart';
import 'package:fashiontailor/pages/widgets/RadialExpansionImage.dart';
import 'package:fashiontailor/utils/storage_util.dart';

import '../Clients/ChoisirClient.dart';
import 'DetailsCommandes.dart';
import 'ListeCommandesParClients.dart';
import '../Clients/ModifierClient.dart';
import '../Configurations/Parametres.dart';
import '../login/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListeCommandes extends StatefulWidget {
  @override
  _ListeCommandesState createState() => _ListeCommandesState();
}

class Constants {
  static const String Parametres = 'Paramètres';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String>[Parametres, Quitter];
}

class _ListeCommandesState extends State<ListeCommandes> {
  final dbFirestore = FirebaseFirestore.instance;
  Cloud_Service_Commande ctrCloudCommande = new Cloud_Service_Commande();

  bool isSearching = false;
  var token = '';
  String texteRecherche = "";

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _deleteCommande(
      BuildContext context, Commande commande, int position) async {
    ctrCloudCommande.supprimerCommande(commande.idcommande);
    setState(() {
      // Je reinitialise la liste snapshort
    });
  }

  void _supprimerCommande(
      BuildContext context, Commande commande, int position) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Voulez-vous supprimer la commande ?',
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
                  _deleteCommande(context, commande, position);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // String date = '20180626170555';
  // String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);

  Future<void> _refreshData() async {
    await StorageUtil.getInstance();
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Widget listeCommande() {
    token = StorageUtil.getString("token");
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: StreamBuilder<QuerySnapshot>(
        //stream: ctrCloudClient.chargerToutLesClientsDuCouturier(widget.idUserOne),
        stream: (texteRecherche != "" && texteRecherche != null)
            ? ctrCloudCommande.chargerLesCommandeParFiltrerCouturier(token,texteRecherche)
            : ctrCloudCommande.chargerLesCommandeParCouturier(token),
        // A ecrire en cs_client apres
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Il y a des erreurs');
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
                        DocumentSnapshot dataCommende =
                            snapshot.data.docs[index];
                        Commande commande = Commande.fromSnapshots(dataCommende);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 4.0),
                          child: Slidable(
                            key: ValueKey(commande),
                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                setState(() {
                                  _deleteCommande(context, commande, index);
                                });

                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${commande.idcommandeTenue} supprimé'),
                                  action: SnackBarAction(
                                    label: 'Annulé',
                                    onPressed: () {
                                      setState(() {});
                                    },
                                  ),
                                ));
                              }),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  //onPressed:  (context) => _nouvelleCommandeDialog(client),
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit_outlined,
                                  label: 'Commande',
                                ),
                                SlidableAction(
                                  onPressed: (context) => _supprimerCommande(context, commande, index),
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Supprimer',
                                ),

                              ],
                            ),

                            // actionPane: SlidableDrawerActionPane(),
                            // secondaryActions: <Widget>[
                            //   IconSlideAction(
                            //     icon: Icons.edit_outlined,
                            //     caption: 'Commande',
                            //     color: Colors.blueAccent,
                            //     //onTap: () => _nouvelleCommandeDialog(client),
                            //   ),
                            //   IconSlideAction(
                            //     icon: Icons.delete,
                            //     caption: 'Supprimer',
                            //     color: Colors.redAccent,
                            //     onTap: () => _supprimerCommande(
                            //         context, commande, index),
                            //   )
                            // ],
                            // dismissal: SlidableDismissal(
                            //   child: SlidableDrawerDismissal(),
                            //   onDismissed: (direction) {
                            //     setState(() {
                            //       _deleteCommande(context, commande, index);
                            //     });
                            //
                            //     Scaffold.of(context).showSnackBar(SnackBar(
                            //       content: Text(
                            //           '${commande.idcommandeTenue} supprimé'),
                            //       action: SnackBarAction(
                            //         label: 'Annulé',
                            //         onPressed: () {
                            //           setState(() {});
                            //         },
                            //       ),
                            //     ));
                            //   },
                            // ),

                            child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: ListTile(
                                onTap: ()
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsCommandes(
                                          commande: commande),
                                    ),
                                  );

                                },
                                title:
                                    Text(commande.idcommandeTenue.toString()),
                                subtitle: Text(
                                    commande.datecommande.toString() +
                                        ' ' +
                                        commande.montantcommande.toString() +
                                        ' Fcfa' +
                                        '\n' +
                                        capitalize(commande.intitule.toString())),
                                // leading: CircleAvatar(
                                //   backgroundImage: ((commande.imgClient ==
                                //       '') ||
                                //       (commande.imgClient == null))
                                //       ? AssetImage('assets/avatar.png')
                                //       : Center(
                                //     child: FadeInImage.assetNetwork(
                                //       placeholder: 'assets/spinner/Spinner.gif',
                                //       image:
                                //       'https://picsum.photos/250?image=9',
                                //     ),
                                //   ),
                                //   // : NetworkImage('https://www.jarca.ca/wp-content/uploads/2015/10/checklist2.png'),
                                //   radius: 25,
                                // ),
                                leading: RadialExpansionImage(
                                    imageName: commande.imgClient,
                                    description: commande.intitule,
                                    user: commande.idcommande),
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
                builder: (BuildContext context) => Parametres()));
      } else if (choice == 'Quitter') {
        Navigator.of(context).pop();
      }
    }

    //Appbar
    final appbarListCommande = AppBar(
      title: !isSearching
          ? Text('Commandes')
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
    //Fin Appbar

    return Scaffold(
      appBar: appbarListCommande,
      body: listeCommande(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, right: 10.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(ChoisirClient.tagChoisirClient);
          },
        ),
      ),
    );
  }
}
