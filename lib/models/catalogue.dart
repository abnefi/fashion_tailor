
import 'package:cloud_firestore/cloud_firestore.dart';

class Catalogue
{

  int    _idcatalogue;
  int    _idcouturier_c;
  int    _imgmodele_c;
  String _detailimage;
  String _datepublie;
  int    _notejaime;


  Catalogue(this._idcatalogue, this._idcouturier_c, this._imgmodele_c, this._detailimage,
      this._datepublie, this._notejaime);


  Catalogue.map(dynamic obj)
  {
    this._idcatalogue = obj['idcatalogue'];
    this._imgmodele_c = obj['imgmodele_c'];
    this._detailimage = obj['detailimage'];
    this._datepublie = obj['datepublie'];
    this._notejaime = obj['notejaime'];
    this._idcouturier_c = obj['idcouturier_c'];
  }



  Catalogue.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      this._idcatalogue = int.parse(snapshot.id);
      this._imgmodele_c = snapshot.get('imgmodele_c');
      this._detailimage = snapshot.get('detailimage');
      this._datepublie = snapshot.get('datepublie');
      this._notejaime = snapshot.get('notejaime');
      this._idcouturier_c = snapshot.get('idcouturier_c');
    }
  }



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idcatalogue"] =  _idcatalogue;
    map["imgmodele_c"] =  _imgmodele_c;
    map["detailimage"] =  _detailimage;
    map["datepublie"] =  _datepublie;
    map["notejaime"] =  _notejaime;
    map["idcouturier_c"] =  _idcouturier_c;
    return map;
  }





  int get idcouturier_c => _idcouturier_c;

  set idcouturier_c(int value) {
    _idcouturier_c = value;
  }

  int get notejaime => _notejaime;

  set notejaime(int value) {
    _notejaime = value;
  }

  String get datepublie => _datepublie;

  set datepublie(String value) {
    _datepublie = value;
  }

  String get detailimage => _detailimage;

  set detailimage(String value) {
    _detailimage = value;
  }

  int get imgmodele_c => _imgmodele_c;

  set imgmodele_c(int value) {
    _imgmodele_c = value;
  }

  int get idcatalogue => _idcatalogue;

  set idcatalogue(int value) {
    _idcatalogue = value;
  }

}