import 'dart:io';
import '../models/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  final String tableUser = "User";
  final String columnName = "email";
  final String columnUserName = "username";
  final String columnPassword = "password";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, username TEXT, password TEXT, flaglogged TEXT) ");
    // CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, username TEXT, password TEXT, flaglogged TEXT
    //        FOREIGN KEY(trackartist) REFERENCES artist(artistid)
    print("Table User is created");


    await db.execute(
        "CREATE TABLE Couturier(idcouturier INTEGER PRIMARY KEY AUTOINCREMENT, nomcouturier TEXT  ,prenomcouturier TEXT  ,sexecouturier TEXT  ,typecouturier TEXT  ,specialitecouturier TEXT ,avatarcouturier TEXT,emailcouturier TEXT,telephonecouturier INTEGER,adressecouturier TEXT,localisationcouturier TEXT, iduser_c INTEGER,FOREIGN KEY (iduser_c) REFERENCES User(iduser) )");
    print("Table Couturier is created");

    await db.execute(
        "CREATE TABLE Client(idclient INTEGER PRIMARY KEY AUTOINCREMENT, nomclient TEXT , prenomclient TEXT , sexeclient TEXT , teintclient TEXT , avatarclient TEXT ,telephoneclient TEXT , code_pays TEXT , ca_dos double , h_poitrine double , lg_buste double , lg_corsage double , lg_robe double , encolure double , ca_devant double , tr_poitrine double , ecart_sein double , tr_de_taille double , lg_jupe double , lg_pantalon double , lg_dos double , larg_dos double , lg_manche double , tr_de_manche double , poignet double , pente double ,idcouturier_c INTEGER,FOREIGN KEY (idcouturier_c) REFERENCES Couturier(idcouturier))");
    print("Table Client is created");

   await db.execute(
        "CREATE TABLE Commande(idcommande INTEGER PRIMARY KEY AUTOINCREMENT, datecommande TEXT, montantcommande INTEGER, datelivraison TEXT, etatcommande INTEGER, progrssioncommande INTEGER ,descriptioncommande TEXT, idclient_c INTEGER,FOREIGN KEY (idclient_c) REFERENCES Client(idclient) )");
    print("Table Commande is created");

    /**
    await db.execute(
        "CREATE TABLE Catalogue(idcatalogue INTEGER PRIMARY KEY AUTOINCREMENT, imgmodele_c INTEGER, detailimage TEXT, datepublie TEXT, notejaime INTEGER, idcouturier_c INTEGER, FOREIGN KEY (imgmodele_c) REFERENCES Modele(idmodele),FOREIGN KEY (idcouturier_c) REFERENCES Couturier(idcouturier) )");
    print("Table is created");
    **/


    await db.execute(
        "CREATE TABLE Modele(idmodele INTEGER PRIMARY KEY AUTOINCREMENT, imgmodele TEXT, nommodele TEXT,typemodele TEXT, genre TEXT,note INTEGER,idcouturier_c INTEGER,FOREIGN KEY (idcouturier_c) REFERENCES Couturier(idcouturier) )");
    print("Table Modele is created");


    await db.execute(
        "CREATE TABLE Tenue(idtenue INTEGER PRIMARY KEY AUTOINCREMENT, imgtissu TEXT ,idmodele_c INTEGER,prixtenue TEXT ,observation TEXT,descriptiontenue TEXT, idcommande_c INTEGER, FOREIGN KEY (idcommande_c) REFERENCES Commande(idcommande) )");
    print("Table Tenue is created");



    await db.execute(
        "CREATE TABLE ConfigCouturierpara(idconfig INTEGER PRIMARY KEY AUTOINCREMENT, idclient_c INTEGER, idmodele_c INTEGER, idcommande_c INTEGER, etatjaime INTEGER, nommodele TEXT,typemodele TEXT, genre TEXT,note INTEGER,idcouturier_c INTEGER,FOREIGN KEY (idcouturier_c) REFERENCES Couturier(idcouturier) )");

    print("Table Modele is created");




    /**************INSERTION USER*************/
    await db.execute(
        "INSERT INTO User(id, email, username, password, flaglogged) VALUES (null,'abnefi@gmail.com','abnefi' , 'labellevie' , 'logged')");
    print("User abnefi Inserer");


    /**************INSERTION COUTURIER*************/
    await db.execute(
        "INSERT INTO Couturier(idcouturier, nomcouturier ,prenomcouturier ,sexecouturier ,typecouturier ,specialitecouturier ,avatarcouturier ,emailcouturier ,telephonecouturier ,adressecouturier ,localisationcouturier , iduser_c ) VALUES (null,'HOUNSINOU','Abed' , 'M' , 'Homme' , 'Styliste' , 'Femme.png' , 'abed.hounsinou@gmail.com' , '95264781' ,'Tankpé' , 'Atinkanmin' , 1 )");
    print("COUTURIER Abed hounsinou Inserer");

    await db.execute(
        "INSERT INTO Couturier(idcouturier, nomcouturier ,prenomcouturier ,sexecouturier ,typecouturier ,specialitecouturier ,avatarcouturier ,emailcouturier ,telephonecouturier ,adressecouturier ,localisationcouturier , iduser_c ) VALUES (null,'HOUENOU','Nego' , 'M' , 'Homme' , 'Styliste' , 'Femme.png' , 'abed.hounsinou@gmail.com' , '95264781' ,'Tankpé' , 'Atinkanmin' , 1 )");
    print("COUTURIER  Nego hounsinou Inserer");






    /**************INSERTION CLIENT*************/
     //Abed hounsinou
     await db.execute(
         "INSERT INTO Client(idclient , nomclient  , prenomclient  , sexeclient  , teintclient  , avatarclient ,telephoneclient  , code_pays  , ca_dos  , h_poitrine  , lg_buste  , lg_corsage  , lg_robe  , encolure  ,ca_devant  , tr_poitrine  , ecart_sein  , tr_de_taille  , lg_jupe  , lg_pantalon  , lg_dos  ,larg_dos  , lg_manche  , tr_de_manche  , poignet  , pente , idcouturier_c ) VALUES (null,'HOUNSINOU','Abed' , 'M' , 'Noir' , 'image1.jpg' , '61169769' , 'BJ' , 2 , 3 , 5 , 1 , 23 , 8 , 3 , 10 , 5 , 5 ,3 , 2 , 6 , 9 , 11 , 3 , 5 , 7,1)");
     print("Client Abed hounsinou Inserer");

     //Nego Houenou
     await db.execute(
         "INSERT INTO Client(idclient , nomclient  , prenomclient  , sexeclient  , teintclient  , avatarclient  ,telephoneclient  , code_pays  , ca_dos  , h_poitrine  , lg_buste  , lg_corsage  , lg_robe  , encolure  , ca_devant  , tr_poitrine  , ecart_sein  , tr_de_taille  , lg_jupe  , lg_pantalon  , lg_dos  , larg_dos  , lg_manche  , tr_de_manche  , poignet  , pente, idcouturier_c ) VALUES (null,'HOUENOU', 'Nego' , 'M' , 'Noir' , 'image2.jpg' , '64469339' , 'BJ' , 2 , 3 , 5 , 1 , 23 , 8 , 3 , 10 , 5 , 5 , 3 , 2 , 6 , 9 , 11 , 3 , 5 , 7, 1)");
     print("Client Nego Houenou Inserer");


     //Fifa Hounsinou
     await db.execute(
         "INSERT INTO Client(idclient , nomclient  , prenomclient  , sexeclient  , teintclient  , avatarclient  ,telephoneclient  , code_pays  , ca_dos  , h_poitrine  , lg_buste  , lg_corsage  , lg_robe  , encolure  , ca_devant  , tr_poitrine  , ecart_sein  , tr_de_taille  , lg_jupe  , lg_pantalon  , lg_dos  , larg_dos  , lg_manche  , tr_de_manche  , poignet  , pente , idcouturier_c ) VALUES (null,'HOUNSINOU', 'Fifa' , 'M' , 'Noir' , 'image3.jpg' , '91169769' , 'BJ' , 2 , 3 , 5 , 1 , 23 , 8 , 3 , 10 , 5 , 5 , 3 , 2 , 6 , 9 , 11 , 3 , 5 , 7, 1)");
     print("Client Fifa Hounsinou Inserer");


     //Habib Lewhe
     await db.execute(
         "INSERT INTO Client(idclient , nomclient  , prenomclient  , sexeclient  , teintclient  , avatarclient  ,telephoneclient  , code_pays  , ca_dos  , h_poitrine  , lg_buste  , lg_corsage  , lg_robe  , encolure  , ca_devant  , tr_poitrine  , ecart_sein  , tr_de_taille  , lg_jupe  , lg_pantalon  , lg_dos  , larg_dos  , lg_manche  , tr_de_manche  , poignet  , pente , idcouturier_c ) VALUES (null,'LEWHE', 'Habib' , 'M' , 'Noir' , 'image4.jpg' , '62169769' , 'BJ' , 2 , 3 , 5 , 1 , 23 , 8 , 3 , 10 , 5 , 5 , 3 , 2 , 6 , 9 , 11 , 3 , 5 , 7,1)");
     print("Client Habib Lewhe Inserer");


     //Eneam IG
     await db.execute(
         "INSERT INTO Client(idclient , nomclient  , prenomclient  , sexeclient  , teintclient  , avatarclient  ,telephoneclient  , code_pays  , ca_dos  , h_poitrine  , lg_buste  , lg_corsage  , lg_robe  , encolure  , ca_devant  , tr_poitrine  , ecart_sein  , tr_de_taille  , lg_jupe  , lg_pantalon  , lg_dos  , larg_dos  , lg_manche  , tr_de_manche  , poignet  , pente , idcouturier_c ) VALUES (null,'ENEAM', 'IG' , 'M' , 'Noir' , 'boubou-femme.jpg' , '61149769' , 'BJ' , 2 , 3 , 5 , 1 , 23 , 8 , 3 , 10 , 5 , 5 , 3 , 2 , 6 , 9 , 11 , 3 , 5 , 7,2)");
     print("Client Eneam IG Inserer");

     // Creation des comptes pour les administrateurs Abed
     await db.execute(
         "INSERT INTO User(id, email, username,password ,flaglogged ) VALUES (null,'abed.hounsinou@gmail.com','abed','abednegofifa','logged')");
     print("Table User is created");

     // Creation des comptes pour les administrateurs habib
     await db.execute(
         "INSERT INTO User(id, email, username,password ,flaglogged ) VALUES (null,'habib.lewhe@gmail.com','habib','lewhe2020','logged')");
     print("Table User is created");



  }




   
/**
  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    print(user.email);
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
  Future<User> selectUser(User user) async{
    print("Select User");
    print(user.username);
    print(user.password);
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnUserName, columnPassword],
        where: "$columnUserName = ? and $columnPassword = ?",
        whereArgs: [user.username,user.password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return user;
    }else {
      return null;
    }
  }


  ***/
}
