import 'package:sqflite/sqflite.dart';

import '../../models/tenue.dart';
import '../database-helper.dart';
import 'dart:async';


class CtrTenue {
  DatabaseHelper con = new DatabaseHelper();

  final String tableTenue = "Tenue";
  final String column_idtenue="idtenue";
  final String column_idcommande_c="idcommande_c";
  final String column_imgtissu="imgtissu";
  final String column_imgmodele="imgmodele";
  final String column_descriptiontenue="descriptiontenue";
  final String column_typemodele="typemodele";
  final String column_prixtenue="prixtenue";
  final String column_observation="observation";
  
//insertion
  Future<int> saveTenue(Tenue tenue) async {
    var dbTenue = await con.db;
    int res = await dbTenue.insert("Tenue", tenue.toMap());
    //  var result = await dbTenue.rawInsert(
    //  'INSERT INTO $tableTenue ($column_nomtenue, $column_prenomtenue) VALUES (\'${tenue.nomtenue}\', \'${tenue.prenomtenue}\')');
    print(tenue.descriptiontenue +' enrégistrer avec succes .');
    List<Map> list = await dbTenue.rawQuery('SELECT * FROM Tenue');
    print(list);
    return res;
  }

//deletion
  Future<int> deleteTenue(int id) async {
    var dbTenue = await con.db;
    print('Tenue supprimer avec succes');
    return await dbTenue.delete(tableTenue, where: '$column_idtenue = ?', whereArgs: [id]);
    // return await dbTenue.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

//suppression
  Future<int> supprimerTenue(Tenue tenue) async {
    var dbTenue = await con.db;
    int res = await dbTenue.delete("Tenue");
    return res;
  }

  Future<int> updateTenue(Tenue tenue) async {
    print("Tenue mise à jour !!!");
    var dbTenue = await con.db;
    print('Tenue modifier avec succes');
    return await dbTenue.update(tableTenue, tenue.toMap(), where: "$column_idtenue = ?", whereArgs: [tenue.idtenue]);
    // return await dbTenue.rawUpdate('UPDATE $tableTenue SET $column_nomtenue = \'${tenue.nomtenue}\', $column_prenomtenue = \'${tenue.prenomtenue}\' WHERE $column_idtenue = ${tenue.idtenue}');

  }


  Future<Tenue> selectTenue(Tenue tenue) async {
    print("Select Tenue");
    print(tenue.descriptiontenue);
    print(tenue.observation);
    var dbTenue = await con.db;
    List<Map> maps = await dbTenue.query(tableTenue,
        columns: [column_prixtenue, column_imgmodele],
        where: "$column_prixtenue = ? and $column_imgmodele = ?",
        whereArgs: [tenue.prixtenue, tenue.imgmodele]);
    print(maps);
    if (maps.length > 0) {
      print("Tenue Exist !!!");
      return tenue;
    } else {
      return null;
    }
  }


  Future<Tenue> getTenue(int id) async {
    var dbTenue = await con.db;
    List<Map> result = await dbTenue.query(tableTenue,
        columns: [column_idtenue,column_prixtenue,column_imgmodele,column_idtenue,column_imgtissu,column_observation,column_idcommande_c],
        where: '$column_idtenue = ?',
        whereArgs: [id]);
//    var result = await dbTenue.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Tenue.map(result.first);
    }

    return null;
  }

  Future<List> getAllTenues() async {
    var dbTenue = await con.db;
//    var result = await dbTenue.query(tableTenue, columns: [columnId, columnTitle, columnDescription]);
    var result = await dbTenue.rawQuery('SELECT * FROM $tableTenue');

    return result.toList();
  }


  Future<int> getCount() async {
    var dbTenue = await con.db;
    return Sqflite.firstIntValue(await dbTenue.rawQuery('SELECT COUNT(*) FROM $tableTenue'));
  }


  Future close() async {
    var dbTenue = await con.db;
    return dbTenue.close();
  }

}