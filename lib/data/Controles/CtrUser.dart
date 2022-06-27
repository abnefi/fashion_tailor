import '../../models/user.dart';
import 'package:sqflite/sqflite.dart';
import '../database-helper.dart';
import 'dart:async';


class CtrUser {
  DatabaseHelper con = new DatabaseHelper();

  final String tableUser = "User";
  final String columnId = "id";
  final String columnEmail = "email";
  final String columnUserName = "username";
  final String columnPassword = "password";


  Future<User>VerificationExiste (User user) async
  {
    var dbClient = await con.db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnUserName],
        where: "$columnUserName = ?",
        whereArgs: [user.username]);
    print(maps);
    if (maps.length > 0) {
      print("Utilisateur Exist deja !!!");
      return user;
    } else {
      return null;
    }
  }

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    print(user.email);
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    return res;
  }

//deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> selectUser(User user) async {
    print("Select User");
    print(user.username);
    print(user.password);
    var dbClient = await con.db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnId,columnEmail,columnUserName, columnPassword,],
        where: "$columnUserName = ? and $columnPassword = ?",
        whereArgs: [user.username, user.password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return user;
    } else {
      return null;
    }
  }




  Future<User> selectUsertoIDa(User user) async {
    print("Select User");
    print(user.username);
    print(user.password);
    var dbClient = await con.db;
    List<Map> maps = await dbClient.query(tableUser,
        //columns: [columnId,columnUserName, columnPassword],
        where: "$columnUserName = ? and $columnPassword = ?",
        whereArgs: [user.username, user.password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return new User.map(maps.first);
    } else {
      return null;
    }
  }




  Future<List> selectUsertoID(String usernam,String pass) async {
    print("Select User");

    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT * FROM $tableUser WHERE $columnUserName="$usernam" AND $columnPassword="$pass"');
    return result.toList();

  }



  Future<int> getCount() async {
    var dbClient = await con.db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableUser'));
  }




}