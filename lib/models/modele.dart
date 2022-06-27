import 'package:cloud_firestore/cloud_firestore.dart';

class Modele
{
  String    _idmodele;
  String    _idcouturier_c;
  String _imgmodele;
  String _nommodele;
  String _typemodele;
  String _genre;
  int    _note;
  int    _isvalider;
  int    _iscatalogue;
  String _datepublie;
  String _detailimage;


  Modele(
      this._idmodele,
      this._idcouturier_c,
      this._imgmodele,
      this._nommodele,
      this._typemodele,
      this._genre,
      this._note,
      this._isvalider,
      this._iscatalogue,
      this._datepublie,
      this._detailimage);

  Modele.map(dynamic obj)
  {
    this._idmodele = obj['idmodele'];
    this._imgmodele = obj['imgmodele'];
    this._nommodele = obj['nommodele'];
    this._typemodele = obj['typemodele'];
    this._genre = obj['genre'];
    this._note = obj['note'];
    this._idcouturier_c = obj['idcouturier_c'];

  }


  Modele.fromSnapshots(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        _idmodele = snapshot.id,
        _imgmodele =snapshot.get('imgmodele'),
        _nommodele =snapshot.get('nommodele'),
        _typemodele =snapshot.get('typemodele'),
        _genre =snapshot.get('genre'),
        _note =snapshot.get('note'),
        _isvalider = snapshot.get('isvalider'),
        _iscatalogue = snapshot.get('iscatalogue'),
        _datepublie = snapshot.get('datepublie'),
        _detailimage = snapshot.get('detailimage'),
        _idcouturier_c = snapshot.get('idcouturier_c');

  // Modele.fromSnapshot(DocumentSnapshot snapshot)
  //     : assert(snapshot != null),
  //       _idmodele = snapshot.id,
  //       _imgmodele =snapshot.data()['imgmodele'],
  //       _nommodele =snapshot.data()['nommodele'],
  //       _typemodele =snapshot.data()['typemodele'],
  //       _genre =snapshot.data()['genre'],
  //       _note =snapshot.data()['note'],
  //       _idcouturier_c = snapshot.data()['idcouturier_c'];



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idmodele"] = _idmodele;
    map["imgmodele"] = _imgmodele;
    map["nommodele"] = _nommodele;
    map["typemodele"] = _typemodele;
    map["genre"] = _genre;
    map["note"] = _note;
    map["isvalider"] = _isvalider;
    map["iscatalogue"] = _iscatalogue;
    map["datepublie"] = _datepublie;
    map["detailimage"] = _detailimage;
    map["idcouturier_c"] = _idcouturier_c;
    return map;
  }


  String get detailimage => _detailimage;

  set detailimage(String value) {
    _detailimage = value;
  }

  String get datepublie => _datepublie;

  set datepublie(String value) {
    _datepublie = value;
  }

  int get iscatalogue => _iscatalogue;

  set iscatalogue(int value) {
    _iscatalogue = value;
  }

  int get isvalider => _isvalider;

  set isvalider(int value) {
    _isvalider = value;
  }

  int get note => _note;

  set note(int value) {
    _note = value;
  }

  String get genre => _genre;

  set genre(String value) {
    _genre = value;
  }

  String get typemodele => _typemodele;

  set typemodele(String value) {
    _typemodele = value;
  }

  String get nommodele => _nommodele;

  set nommodele(String value) {
    _nommodele = value;
  }

  String get imgmodele => _imgmodele;

  set imgmodele(String value) {
    _imgmodele = value;
  }

  String get idcouturier_c => _idcouturier_c;

  set idcouturier_c(String value) {
    _idcouturier_c = value;
  }

  String get idmodele => _idmodele;

  set idmodele(String value) {
    _idmodele = value;
  }
}
