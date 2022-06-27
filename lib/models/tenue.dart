import 'package:cloud_firestore/cloud_firestore.dart';

class Tenue
{
  String _idtenue;
  String _idcommande_c;
  String _imgtissu;
  String _imgmodele;
  String _typetenue;
  double _prixtenue;
  String _descriptiontenue;
  String _observation;


  Tenue(this._idtenue, this._idcommande_c, this._imgtissu, this._imgmodele,
      this._typetenue, this._prixtenue, this._descriptiontenue, this._observation);

  Tenue.map(dynamic obj)
  {
    this._idtenue = obj['idtenue'];
    this._imgtissu = obj['imgtissu'];
    this._imgmodele = obj['imgmodele'];
    this._typetenue = obj['typetenue'];
    this._prixtenue = obj['prixtenue'];
    this._observation = obj['observation'];
    this._descriptiontenue = obj['descriptiontenue'];
    this._idcommande_c = obj['idcommande_c'];

  }


  Tenue.fromSnapshots(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        _idtenue = snapshot.id,
        _imgtissu = snapshot.get('imgtissu'),
        _imgmodele = snapshot.get('imgmodele'),
        _typetenue = snapshot.get('typetenue'),
        _prixtenue = double.parse(snapshot.get('prixtenue').toString()),
        _observation = snapshot.get('observation'),
        _descriptiontenue = snapshot.get('descriptiontenue'),
        _idcommande_c = snapshot.get('idcommande_c');


  // Tenue.fromSnapshot(DocumentSnapshot snapshot)
  //     : assert(snapshot != null),
  //       _idtenue = snapshot.id,
  //       _imgtissu = snapshot.data()['imgtissu'],
  //       _imgmodele = snapshot.data()['imgmodele'],
  //       _typetenue = snapshot.data()['typetenue'],
  //       _prixtenue = double.parse(snapshot.data()['prixtenue'].toString()),
  //       _observation = snapshot.data()['observation'],
  //       _descriptiontenue = snapshot.data()['descriptiontenue'],
  //       _idcommande_c = snapshot.data()['idcommande_c'];




  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idtenue"] = _idtenue;
    map["imgtissu"] = _imgtissu;
    map["imgmodele"] = _imgmodele;
    map["typetenue"] = _typetenue;
    map["prixtenue"] = _prixtenue;
    map["observation"] = _observation;
    map["descriptiontenue"] = _descriptiontenue;
    map["idcommande_c"] = _idcommande_c;
    return map;
  }


  String get descriptiontenue => _descriptiontenue;

  set descriptiontenue(String value) {
    _descriptiontenue = value;
  }

  String get observation => _observation;

  set observation(String value) {
    _observation = value;
  }

  double get prixtenue => _prixtenue;

  set prixtenue(double value) {
    _prixtenue = value;
  }

  String get typetenue => _typetenue;

  set typetenue(String value) {
    _typetenue = value;
  }

  String get imgmodele => _imgmodele;

  set imgmodele(String value) {
    _imgmodele = value;
  }

  String get imgtissu => _imgtissu;

  set imgtissu(String value) {
    _imgtissu = value;
  }

  String get idcommande_c => _idcommande_c;

  set idcommande_c(String value) {
    _idcommande_c = value;
  }

  String get idtenue => _idtenue;

  set idtenue(String value) {
    _idtenue = value;
  }
}