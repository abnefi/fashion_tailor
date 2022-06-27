import 'DetailsCommandes.dart';
import '../Clients/DonneesClients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListeCommandesParClients extends StatefulWidget {

  static String taglisteCommandeParClient = 'listeCommandeParClient';

  @override
  _ListeCommandesParClientsState createState() => _ListeCommandesParClientsState();
}

class CommandesIndividuelles {
  //
  String nomCommande = '';

  CommandesIndividuelles({this.nomCommande});
}

class _ListeCommandesParClientsState extends State<ListeCommandesParClients> {
  List<CommandesIndividuelles> listeDesCommandes;

  @override
  void initState() {
    super.initState();
    listeDesCommandes = List();
    addCommandes();
  }

  addCommandes() {
    listeDesCommandes.add(CommandesIndividuelles(
      nomCommande: '',
    ));
    listeDesCommandes.add(CommandesIndividuelles(
      nomCommande: '',
    ));
  }

  Widget listeDesCommandesIndiv() {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: listeDesCommandes.length,
      itemBuilder: (context, index) {
        CommandesIndividuelles item = listeDesCommandes[index];
        int chiffre = 1;
        chiffre += index;
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Dismissible(
            key: ValueKey(item),
            background: Container(
              child:
              // IconSlideAction(
              //   icon: Icons.delete,
              //   caption: 'Supprimer',
              //   color: Colors.redAccent,
              // ),
              SlidableAction(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Share',
              ),
              color: Colors.red,
            ),
            onDismissed: (direction){
              setState(() {
                listeDesCommandes.removeAt(index);
              });

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Commande '+'${chiffre} supprimé'),
                action: SnackBarAction(
                  label: 'Annulé',
                  onPressed: () {
                    setState(() {
                      listeDesCommandes.insert(index, item);
                    });
                  },
                ),
              ));
            },
            child: Card(
              elevation: 1.0,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(DetailsCommandes.tagDetailsCommandes);
                },
                title: Text('Commande '+'${chiffre}',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final appbarListCommandParClients = AppBar(
      title: Text('Commandes par clients'),
    );


    return Scaffold(
      appBar: appbarListCommandParClients,
      body: listeDesCommandesIndiv(),
    );
  }
}
