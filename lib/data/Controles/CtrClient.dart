import 'package:sqflite/sqflite.dart';

import '../../models/client.dart';
import '../database-helper.dart';
import 'dart:async';


class CtrClient {
  DatabaseHelper con = new DatabaseHelper();

  final String tableClient = "Client";
  final String column_idclient = "idclient";
  final String column_nomclient = "nomclient";
  final String column_prenomclient = "prenomclient";
  final String column_sexeclient = "sexeclient";
  final String column_teintclient = "teintclient";
  final String column_avatarclient = "avatarclient";
  final String column_telephoneclient = "telephoneclient";
  final String column_code_pays = "code_pays";
  final String column_ca_dos = "ca_dos";
  final String column_h_poitrine = "h_poitrine";
  final String column_lg_buste = "lg_buste";
  final String column_lg_corsage = "lg_corsage";
  final String column_lg_robe = "lg_robe";
  final String column_encolure = "encolure";
  final String column_ca_devant = "ca_devant";
  final String column_tr_poitrine = "tr_poitrine";
  final String column_ecart_sein = "ecart_sein";
  final String column_tr_de_taille = "tr_de_taille";
  final String column_lg_jupe = "lg_jupe";
  final String column_lg_pantalon = "lg_pantalon";
  final String column_lg_dos = "lg_dos";
  final String column_larg_dos = "larg_dos";
  final String column_lg_manche = "lg_manche";
  final String column_tr_de_manche = "tr_de_manche";
  final String column_poignet = "poignet";
  final String column_pente = "pente";
  final String column_idcouturier_c = "idcouturier_c";






//insertion
  Future<int> saveClient(Client client) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("Client", client.toMap());
  //  var result = await dbClient.rawInsert(
  //  'INSERT INTO $tableClient ($column_nomclient, $column_prenomclient) VALUES (\'${client.nomclient}\', \'${client.prenomclient}\')');
    print(client.prenomclient+' et '+client.nomclient +' enrégistrer avec succes .');
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Client');
    print(list);
    return res;
  }

//deletion
  Future<int> deleteClient(int id) async {
    var dbClient = await con.db;
    print('Client supprimer avec succes');
    return await dbClient.delete(tableClient, where: '$column_idclient = ?', whereArgs: [id]);
    // return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

//suppression
  Future<int> supprimerClient(Client client) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("Client");
    return res;
  }

  Future<int> updateClient(Client client) async {
    print("Client mise à jour !!!");
    var dbClient = await con.db;
    print('Client modifier avec succes');
    return await dbClient.update(tableClient, client.toMap(), where: "$column_idclient = ?", whereArgs: [client.idclient]);
  // return await dbClient.rawUpdate('UPDATE $tableClient SET $column_nomclient = \'${client.nomclient}\', $column_prenomclient = \'${client.prenomclient}\' WHERE $column_idclient = ${client.idclient}');

  }


  Future<Client> selectClient(Client client) async {
    print("Select Client");
    print(client.nomclient);
    print(client.prenomclient);
    var dbClient = await con.db;
    List<Map> maps = await dbClient.query(tableClient,
        columns: [column_nomclient, column_prenomclient],
        where: "$column_nomclient = ? and $column_prenomclient = ?",
        whereArgs: [client.nomclient, client.prenomclient]);
    print(maps);
    if (maps.length > 0) {
      print("Client Exist !!!");
      return client;
    } else {
      return null;
    }
  }


  Future<Client> getClient(int id) async {
    var dbClient = await con.db;
    List<Map> result = await dbClient.query(tableClient,
        columns: [column_idclient,column_nomclient,column_prenomclient,column_sexeclient,column_teintclient,column_avatarclient,column_telephoneclient,column_code_pays,column_ca_dos,column_h_poitrine,column_lg_buste,column_lg_corsage,column_lg_robe,column_encolure,column_ca_devant,column_tr_poitrine,column_ecart_sein,column_tr_de_taille,column_lg_jupe,column_lg_pantalon,column_lg_dos,column_larg_dos,column_lg_manche,column_tr_de_manche,column_poignet,column_pente,column_idcouturier_c],
        where: '$column_idclient = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Client.map(result.first);
    }

    return null;
  }

  Future<List> getAllClients() async {
    var dbClient = await con.db;
//    var result = await dbClient.query(tableClient, columns: [columnId, columnTitle, columnDescription]);
    var result = await dbClient.rawQuery('SELECT * FROM $tableClient');

    return result.toList();
  }

  Future<List> getAllClientsById_couturier(int iduserOnline) async {
    print(iduserOnline);
    var dbClient = await con.db;
//    var result = await dbClient.query(tableClient, columns: [columnId, columnTitle, columnDescription]);
    var result = await dbClient.rawQuery('SELECT * FROM $tableClient WHERE $column_idcouturier_c=$iduserOnline ');

    return result.toList();
  }


  Future<List<Client>> getAllClientsNew(int iduserOnline) async {
    var dbClient = await con.db;

    List<Map>
    results = await dbClient.query("Product",
        columns: [column_idclient,column_nomclient,column_prenomclient,column_sexeclient,column_teintclient,column_avatarclient,column_telephoneclient,column_code_pays,column_ca_dos,column_h_poitrine,column_lg_buste,column_lg_corsage,column_lg_robe,column_encolure,column_ca_devant,column_tr_poitrine,column_ecart_sein,column_tr_de_taille,column_lg_jupe,column_lg_pantalon,column_lg_dos,column_larg_dos,column_lg_manche,column_tr_de_manche,column_poignet,column_pente,column_idcouturier_c],
        where: '$column_idcouturier_c = ?',
        whereArgs: [iduserOnline],
        orderBy: "$column_idclient ASC");

    List<Client> clients = new List();
    results.forEach((result) {
      Client client = Client.fromMap(result);
      clients.add(client);
    });
    return clients;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableClient'));
  }


  Future close() async {
    var dbClient = await con.db;
    return dbClient.close();
  }

}