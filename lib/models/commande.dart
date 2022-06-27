import 'package:cloud_firestore/cloud_firestore.dart';

class Commande
{
  String _idcommande;
  String _idcommandeTenue;
  String _idclient_c;
  String _idcouturier_c;
  String _datecommande; //avance
  double _montantcommande;
  String _datelivraison;
  String _imgClient;
  String _intitule;
  String _descriptioncommande;
  int    _etatcommande;
  int    _progressioncommande;


  Commande(
      this._idcommande,
      this._idcommandeTenue,
      this._idclient_c,
      this._idcouturier_c,
      this._datecommande,
      this._montantcommande,
      this._datelivraison,
      this._imgClient,
      this._intitule,
      this._descriptioncommande,
      this._etatcommande,
      this._progressioncommande);

  Commande.map(dynamic obj)
  {
    this._idcommande = obj['idcommande'];
    this._idcommandeTenue = obj['idcommandeTenue'];
    this._datecommande = obj['datecommande'];
    this._montantcommande = obj['montantcommande'];
    this._datelivraison = obj['datelivraison'];
    this._etatcommande = obj['etatcommande'];
    this._imgClient = obj['imgClient'];
    this._intitule = obj['intitule'];
    this._progressioncommande = obj['progressioncommande'];
    this._descriptioncommande = obj['descriptioncommande'];
    this._idclient_c = obj['idclient_c'];
    this._idcouturier_c = obj['idcouturier_c'];
  }



  Commande.fromSnapshots(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        _idcommande = snapshot.id,
        _idcommandeTenue = snapshot.get('idcommandeTenue'),
        _idclient_c = snapshot.get('idclient_c'),
        _idcouturier_c = snapshot.get('idcouturier_c'),
        _datecommande = snapshot.get('datecommande'),
        _montantcommande = double.parse(snapshot.get('montantcommande').toString()),
        _datelivraison = snapshot.get('datelivraison'),
        _imgClient = snapshot.get('imgClient'),
        _intitule = snapshot.get('intitule'),
        _etatcommande = int.parse(snapshot.get('etatcommande').toString()),
        _progressioncommande = int.parse(snapshot.get('progressioncommande').toString()),
        _descriptioncommande = snapshot.get('descriptioncommande');


  // Commande.fromSnapshot(DocumentSnapshot snapshot)
  //     : assert(snapshot != null),
  //       _idcommande = snapshot.id,
  //       _idcommandeTenue = snapshot.data()['idcommandeTenue'],
  //       _idclient_c = snapshot.data()['idclient_c'],
  //       _idcouturier_c = snapshot.data()['idcouturier_c'],
  //       _datecommande = snapshot.data()['datecommande'],
  //       _montantcommande = double.parse(snapshot.data()['montantcommande'].toString()),
  //       _datelivraison = snapshot.data()['datelivraison'],
  //       _imgClient = snapshot.data()['imgClient'],
  //       _intitule = snapshot.data()['intitule'],
  //       _etatcommande = int.parse(snapshot.data()['etatcommande'].toString()),
  //       _progressioncommande = int.parse(snapshot.data()['progressioncommande'].toString()),
  //       _descriptioncommande = snapshot.data()['descriptioncommande'];



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idcommande"] = _idcommande;
    map["idcommandeTenue"] = _idcommandeTenue;
    map["datecommande"] = _datecommande;
    map["montantcommande"] = _montantcommande;
    map["datelivraison"] = _datelivraison;
    map["etatcommande"] = _etatcommande;
    map["progressioncommande"] = _progressioncommande;
    map["imgClient"] = _imgClient;
    map["intitule"] = _intitule;
    map["descriptioncommande"] = _descriptioncommande;
    map["idclient_c"] = _idclient_c;
    map["idcouturier_c"] = _idcouturier_c;
    return map;
  }


  String get imgClient => _imgClient;

  set imgClient(String value) {
    _imgClient = value;
  }


  String get intitule => _intitule;

  set intitule(String value) {
    _intitule = value;
  }

  String get idcommandeTenue => _idcommandeTenue;

  set idcommandeTenue(String value) {
    _idcommandeTenue = value;
  }

  int get progressioncommande => _progressioncommande;

  set progressioncommande(int value) {
    _progressioncommande = value;
  }

  int get etatcommande => _etatcommande;

  set etatcommande(int value) {
    _etatcommande = value;
  }

  String get descriptioncommande => _descriptioncommande;

  set descriptioncommande(String value) {
    _descriptioncommande = value;
  }

  String get datelivraison => _datelivraison;

  set datelivraison(String value) {
    _datelivraison = value;
  }

  double get montantcommande => _montantcommande;

  set montantcommande(double value) {
    _montantcommande = value;
  }

  String get datecommande => _datecommande;

  set datecommande(String value) {
    _datecommande = value;
  }

  String get idcouturier_c => _idcouturier_c;

  set idcouturier_c(String value) {
    _idcouturier_c = value;
  }

  String get idclient_c => _idclient_c;

  set idclient_c(String value) {
    _idclient_c = value;
  }

  String get idcommande => _idcommande;

  set idcommande(String value) {
    _idcommande = value;
  }
}