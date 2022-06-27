import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  int _id;
  String _idFireStore;
  String _email;
  String _username;
  String _password;
  String _flaglogged;



  User(this._id,this._idFireStore, this._email, this._username, this._password, this._flaglogged);

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._idFireStore = obj['idFireStore'];
    this._email = obj['email'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._flaglogged = obj['flagLogged'];
  }


  User.fromSnapshots(DocumentSnapshot snapshot) {
    if (snapshot != null)
    {
      this._id = int.parse(snapshot.get('id'));
      this._idFireStore = snapshot.id;
      this._email = snapshot.get('email');
      this._username = snapshot.get('username');
      this._password = snapshot.get('password');
      this._flaglogged = snapshot.get('flagLogged');
    }
  }

  User.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null)
    {
      this._id = int.parse(snapshot['id']);
      this._idFireStore = snapshot.id;
      this._email = snapshot['email'];
      this._username = snapshot['username'];
      this._password = snapshot['password'];
      this._flaglogged = snapshot['flagLogged'];
    }
  }

  int    get id => _id;
  String get email => _email;
  String get username => _username;
  String get password => _password;
  String get flaglogged => _flaglogged;
  String get idFireStore => _idFireStore;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["idFireStore"] = _idFireStore;
    map["email"] = _email;
    map["username"] = _username;
    map["password"] = _password;
    map["flaglogged"] = _flaglogged;
    return map;
  }


  static fromSnapshotQ(String id,Map<String, dynamic> snapshot)
  {
    User user = null;
    if (snapshot != null)
    {
      user.id = int.parse(snapshot['id']);
      user.idFireStore = id;
      user.email = snapshot['email'];
      user.username = snapshot['username'];
      user.password = snapshot['password'];
      user.flaglogged = snapshot['flagLogged'];
    }
    return user;
  }

  set flaglogged(String value) {
    _flaglogged = value;
  }

  set idFireStore(String value) {
    _idFireStore = value;
  }

  set password(String value) {
    _password = value;
  }

  set username(String value) {
    _username = value;
  }

  set email(String value) {
    _email = value;
  }

  set id(int value) {
    _id = value;
  }



}
