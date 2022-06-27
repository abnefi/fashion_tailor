import 'package:sqflite/sqflite.dart';

import '../../models/couturier.dart';
import '../database-helper.dart';
import 'dart:async';


class CtrCouturier {
  DatabaseHelper con = new DatabaseHelper();

  final String tableCouturier ="Couturier";
  final String column_idcouturier="idcouturier";
  final String column_iduser_c="iduser_c";
  final String column_nomcouturier="nomcouturier";
  final String column_prenomcouturier="prenomcouturier";
  final String column_sexecouturier="sexecouturier";
  final String column_typecouturier="typecouturier";
  final String column_specialitecouturier="specialitecouturier";
  final String column_avatarcouturier="avatarcouturier";
  final String column_emailcouturier="avatarcouturier";
  final String column_telephonecouturier="telephonecouturier";
  final String column_adressecouturier="adressecouturier";
  final String column_localisationcouturier="localisationcouturier";

//insertion
  Future<int> saveCouturier(Couturier couturier) async {
    var dbCouturier = await con.db;
    int res = await dbCouturier.insert("Couturier", couturier.toMap());
    //  var result = await dbCouturier.rawInsert(
    //  'INSERT INTO $tableCouturier ($column_nomcouturier, $column_prenomcouturier) VALUES (\'${couturier.nomcouturier}\', \'${couturier.prenomcouturier}\')');
    print(couturier.prenomcouturier+' et '+couturier.nomcouturier +' enrégistrer avec succes .');
    List<Map> list = await dbCouturier.rawQuery('SELECT * FROM Couturier');
    print(list);
    return res;
  }

//deletion
  Future<int> deleteCouturier(int id) async {
    var dbCouturier = await con.db;
    print('Couturier supprimer avec succes');
    return await dbCouturier.delete(tableCouturier, where: '$column_idcouturier = ?', whereArgs: [id]);
    // return await dbCouturier.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

//suppression
  Future<int> supprimerCouturier(Couturier couturier) async {
    var dbCouturier = await con.db;
    int res = await dbCouturier.delete("Couturier");
    return res;
  }

  Future<int> updateCouturier(Couturier couturier) async {
    print("Couturier mise à jour !!!");
    var dbCouturier = await con.db;
    print('Couturier modifier avec succes');
    return await dbCouturier.update(tableCouturier, couturier.toMap(), where: "$column_idcouturier = ?", whereArgs: [couturier.idcouturier]);
    // return await dbCouturier.rawUpdate('UPDATE $tableCouturier SET $column_nomcouturier = \'${couturier.nomcouturier}\', $column_prenomcouturier = \'${couturier.prenomcouturier}\' WHERE $column_idcouturier = ${couturier.idcouturier}');

  }


  Future<Couturier> selectCouturier(Couturier couturier) async {
    print("Select Couturier");
    print(couturier.nomcouturier);
    print(couturier.prenomcouturier);
    var dbCouturier = await con.db;
    List<Map> maps = await dbCouturier.query(tableCouturier,
        columns: [column_nomcouturier, column_prenomcouturier],
        where: "$column_nomcouturier = ? and $column_prenomcouturier = ?",
        whereArgs: [couturier.nomcouturier, couturier.prenomcouturier]);
    print(maps);
    if (maps.length > 0) {
      print("Couturier Exist !!!");
      return couturier;
    } else {
      return null;
    }
  }


  Future<Couturier> getCouturier(int id) async {
    var dbCouturier = await con.db;
    List<Map> result = await dbCouturier.query(tableCouturier,
        columns: [column_idcouturier,column_nomcouturier,column_prenomcouturier,column_sexecouturier,column_specialitecouturier,column_avatarcouturier,column_emailcouturier,column_telephonecouturier,column_adressecouturier,column_typecouturier,column_localisationcouturier,column_iduser_c],
        where: '$column_idcouturier = ?',
        whereArgs: [id]);
//    var result = await dbCouturier.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Couturier.map(result.first);
    }

    return null;
  }

  Future<List> getAllCouturiers() async {
    var dbCouturier = await con.db;
//    var result = await dbCouturier.query(tableCouturier, columns: [columnId, columnTitle, columnDescription]);
    var result = await dbCouturier.rawQuery('SELECT * FROM $tableCouturier');

    return result.toList();
  }


  Future<int> getCount() async {
    var dbCouturier = await con.db;
    return Sqflite.firstIntValue(await dbCouturier.rawQuery('SELECT COUNT(*) FROM $tableCouturier'));
  }



  Future<List> selectCouturierByIDoneLine(int idUserOnline) async {
    print("Select id Couturier");

    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT $column_idcouturier FROM $tableCouturier WHERE $column_iduser_c=$idUserOnline');
    return result.toList();

  }


  Future close() async {
    var dbCouturier = await con.db;
    return dbCouturier.close();
  }

}