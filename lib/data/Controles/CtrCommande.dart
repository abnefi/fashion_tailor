import '../../models/commande.dart';
import '../database-helper.dart';
import 'dart:async';


class CtrCommande {
  DatabaseHelper con = new DatabaseHelper();

  final String tableCommande = "Commande";
  final String column_idcommande ="idcommande";
  final String column_idclient_c ="idclient_c";
  final String column_datecommande ="datecommande";
  final String column_montantcommande ="montantcommande";
  final String column_datelivraison ="datelivraison";
  final String column_descriptioncommande ="descriptioncommande";
  final String column_etatcommande ="etatcommande";
  final String column_progressioncommande = "progressioncommande";
  
  

//insertion
  Future<int> saveCommande(Commande commande) async {
    var dbClient = await con.db;
    print(commande.descriptioncommande);
    int res = await dbClient.insert("Commande", commande.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Commande');
    print(list);
    return res;
  }

//deletion
  Future<int> deleteCommande(Commande commande) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("Commande");
    return res;
  }

  Future<Commande> selectCommande(Commande commande) async {
    print("Select Commande");
    print(commande.descriptioncommande);
    print(commande.etatcommande);
    var dbClient = await con.db;
    List<Map> maps = await dbClient.query(tableCommande,
        columns: [column_datecommande, column_datelivraison],
        where: "$column_datecommande = ? and $column_datelivraison = ?",
        whereArgs: [commande.datecommande, commande.datelivraison]);
    print(maps);
    if (maps.length > 0) {
      print("Commande Exist !!!");
      return commande;
    } else {
      return null;
    }
  }

}