import 'package:sqflite/sqflite.dart';

import '../../models/catalogue.dart';
import '../database-helper.dart';
import 'dart:async';


class CtrCatalogue {
  DatabaseHelper con = new DatabaseHelper();

  final String tableCatalogue ="Catalogue";
  final String column_idcatalogue="idcatalogue";
  final String column_imgmodele_c="imgmodele_c";
  final String column_detailimage="detailimage";
  final String column_datepublie="atepublie";
  final String column_notejaime="notejaim";
  final String column_idcouturier_c="idcouturier_c";
 
//insertion
  Future<int> saveCatalogue(Catalogue catalogue) async {
    var dbCatalogue = await con.db;
    int res = await dbCatalogue.insert("Catalogue", catalogue.toMap());
    //  var result = await dbCatalogue.rawInsert(
    //  'INSERT INTO $tableCatalogue ($column_nomcatalogue, $column_prenomcatalogue) VALUES (\'${catalogue.nomcatalogue}\', \'${catalogue.prenomcatalogue}\')');
    print(catalogue.datepublie+' et '+catalogue.detailimage +' enrégistrer avec succes .');
    List<Map> list = await dbCatalogue.rawQuery('SELECT * FROM Catalogue');
    print(list);
    return res;
  }

//deletion
  Future<int> deleteCatalogue(int id) async {
    var dbCatalogue = await con.db;
    print('Catalogue supprimer avec succes');
    return await dbCatalogue.delete(tableCatalogue, where: '$column_idcatalogue = ?', whereArgs: [id]);
    // return await dbCatalogue.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

//suppression
  Future<int> supprimerCatalogue(Catalogue catalogue) async {
    var dbCatalogue = await con.db;
    int res = await dbCatalogue.delete("Catalogue");
    return res;
  }

  Future<int> updateCatalogue(Catalogue catalogue) async {
    print("Catalogue mise à jour !!!");
    var dbCatalogue = await con.db;
    print('Catalogue modifier avec succes');
    return await dbCatalogue.update(tableCatalogue, catalogue.toMap(), where: "$column_idcatalogue = ?", whereArgs: [catalogue.idcatalogue]);
    // return await dbCatalogue.rawUpdate('UPDATE $tableCatalogue SET $column_nomcatalogue = \'${catalogue.nomcatalogue}\', $column_prenomcatalogue = \'${catalogue.prenomcatalogue}\' WHERE $column_idcatalogue = ${catalogue.idcatalogue}');

  }


  Future<Catalogue> selectCatalogue(Catalogue catalogue) async {
    print("Select Catalogue");
    print(catalogue.detailimage);
    print(catalogue.datepublie);
    var dbCatalogue = await con.db;
    List<Map> maps = await dbCatalogue.query(tableCatalogue,
        columns: [column_idcatalogue, column_imgmodele_c],
        where: "$column_idcatalogue = ? and $column_imgmodele_c = ?",
        whereArgs: [catalogue.idcatalogue, catalogue.imgmodele_c]);
    print(maps);
    if (maps.length > 0) {
      print("Catalogue Exist !!!");
      return catalogue;
    } else {
      return null;
    }
  }


  Future<Catalogue> getCatalogue(int id) async {
    var dbCatalogue = await con.db;
    List<Map> result = await dbCatalogue.query(tableCatalogue,
        columns: [column_idcatalogue, column_imgmodele_c, column_detailimage, column_datepublie, column_notejaime, column_idcouturier_c],
        where: '$column_idcatalogue = ?',
        whereArgs: [id]);
//    var result = await dbCatalogue.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Catalogue.map(result.first);
    }

    return null;
  }

  Future<List> getAllCatalogues() async {
    var dbCatalogue = await con.db;
//    var result = await dbCatalogue.query(tableCatalogue, columns: [columnId, columnTitle, columnDescription]);
    var result = await dbCatalogue.rawQuery('SELECT * FROM $tableCatalogue');

    return result.toList();
  }


  Future<int> getCount() async {
    var dbCatalogue = await con.db;
    return Sqflite.firstIntValue(await dbCatalogue.rawQuery('SELECT COUNT(*) FROM $tableCatalogue'));
  }


  Future close() async {
    var dbCatalogue = await con.db;
    return dbCatalogue.close();
  }

}