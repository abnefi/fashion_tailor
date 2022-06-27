import 'package:cloud_firestore/cloud_firestore.dart';

class Couturier
{
  int    _idcouturier;
  String    _iduser_c;
  String _idcouturierFireStore;
  String _nomcouturier;
  String _prenomcouturier;
  String _sexecouturier;
  String _typecouturier;
  String _specialitecouturier;
  String _avatarcouturier;
  String _emailcouturier;
  String _telephonecouturier;
  String _adressecouturier;
  String _localisationcouturier;

  Couturier(
      this._idcouturier,
      this._idcouturierFireStore,
      this._iduser_c,
      this._nomcouturier,
      this._prenomcouturier,
      this._sexecouturier,
      this._typecouturier,
      this._specialitecouturier,
      this._avatarcouturier,
      this._emailcouturier,
      this._telephonecouturier,
      this._adressecouturier,
      this._localisationcouturier);



  Couturier.map(dynamic obj)
  {
    this._idcouturier = obj['idcouturier'];
    this._idcouturierFireStore = obj['idcouturierFireStore'];
    this._nomcouturier = obj['nomcouturier'];
    this._prenomcouturier = obj['prenomcouturier'];
    this._sexecouturier = obj['sexecouturier'];
    this._typecouturier = obj['typecouturier'];
    this._specialitecouturier = obj['specialitecouturier'];
    this._avatarcouturier= obj['avatarcouturier'];
    this._emailcouturier= obj['emailcouturier'];
    this._telephonecouturier = obj['telephonecouturier'];
    this._adressecouturier = obj['adressecouturier'];
    this._localisationcouturier = obj['localisationcouturier'];
    this._iduser_c = obj['iduser_c'];

  }

  Couturier.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {

      this._idcouturier = int.parse(snapshot.get('idcouturier'));
      this._idcouturierFireStore = snapshot.id;
      this._iduser_c = snapshot.get('iduser_c');
      this._nomcouturier = snapshot.get('nomcouturier');
      this._prenomcouturier = snapshot.get('prenomcouturier');
      this._sexecouturier = snapshot.get('sexecouturier');
      this._typecouturier = snapshot.get('typecouturier');
      this._specialitecouturier = snapshot.get('specialitecouturier');
      this._avatarcouturier= snapshot.get('avatarcouturier');
      this._emailcouturier= snapshot.get('emailcouturier');
      this._telephonecouturier = snapshot.get('telephonecouturier');
      this._adressecouturier = snapshot.get('adressecouturier');
      this._localisationcouturier = snapshot.get('localisationcouturier');
    }
  }



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idcouturier"] = _idcouturier;
    map["idcouturierFireStore"] = _idcouturierFireStore;
    map["nomcouturier"] = _nomcouturier;
    map["prenomcouturier"] = _prenomcouturier;
    map["sexecouturier"] = _sexecouturier;
    map["typecouturier"] = _typecouturier;
    map["specialitecouturier"] = _specialitecouturier;
    map["avatarcouturier"] = _avatarcouturier;
    map["emailcouturier"] = _emailcouturier;
    map["telephonecouturier"] = _telephonecouturier;
    map["adressecouturier"] = _adressecouturier;
    map["localisationcouturier"] = _localisationcouturier;
    map["iduser_c"] = _iduser_c;
    return map;
  }



  String get localisationcouturier => _localisationcouturier;

  set localisationcouturier(String value) {
    _localisationcouturier = value;
  }

  String get idcouturierFireStore => _idcouturierFireStore;

  set idcouturierFireStore(String value) {
    _idcouturierFireStore = value;
  }

  String get adressecouturier => _adressecouturier;

  set adressecouturier(String value) {
    _adressecouturier = value;
  }

  String get avatarcouturier => _avatarcouturier;

  set avatarcouturier(String value) {
    _avatarcouturier = value;
  }
  String get emailcouturier => _emailcouturier;

  set emailcouturier(String value) {
    _emailcouturier = value;
  }

  String get telephonecouturier => _telephonecouturier;

  set telephonecouturier(String value) {
    _telephonecouturier = value;
  }

  String get specialitecouturier => _specialitecouturier;

  set specialitecouturier(String value) {
    _specialitecouturier = value;
  }

  String get typecouturier => _typecouturier;

  set typecouturier(String value) {
    _typecouturier = value;
  }

  String get sexecouturier => _sexecouturier;

  set sexecouturier(String value) {
    _sexecouturier = value;
  }

  String get prenomcouturier => _prenomcouturier;

  set prenomcouturier(String value) {
    _prenomcouturier = value;
  }

  String get nomcouturier => _nomcouturier;

  set nomcouturier(String value) {
    _nomcouturier = value;
  }

  int get idcouturier => _idcouturier;

  set idcouturier(int value) {
    _idcouturier = value;
  }

  String get iduser_c => _iduser_c;

  set iduser_c(String value) {
    _iduser_c = value;
  }


}
