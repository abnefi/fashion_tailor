import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Client {
  int _idclient;
  String _idcouturier_c;
  String _idclientFirestore;
  String _nomclient;
  String _prenomclient;
  String _sexeclient;
  String _teintclient;
  String _avatarclient;
  String _telephoneclient;
  String _code_pays;
  double _ca_dos;
  double _h_poitrine;
  double _lg_buste;
  double _lg_corsage;
  double _lg_robe;
  double _encolure;
  double _ca_devant;
  double _tr_poitrine;
  double _ecart_sein;
  double _tr_de_taille;
  double _lg_jupe;
  double _lg_pantalon;
  double _lg_dos;
  double _larg_dos;
  double _lg_manche;
  double _tr_de_manche;
  double _poignet;
  double _pente;

  Client(
      this._idclient,
      this._idcouturier_c,
      this._idclientFirestore,
      this._nomclient,
      this._prenomclient,
      this._sexeclient,
      this._teintclient,
      this._avatarclient,
      this._telephoneclient,
      this._code_pays,
      this._ca_dos,
      this._h_poitrine,
      this._lg_buste,
      this._lg_corsage,
      this._lg_robe,
      this._encolure,
      this._ca_devant,
      this._tr_poitrine,
      this._ecart_sein,
      this._tr_de_taille,
      this._lg_jupe,
      this._lg_pantalon,
      this._lg_dos,
      this._larg_dos,
      this._lg_manche,
      this._tr_de_manche,
      this._poignet,
      this._pente);

//les nouveau map
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
        map["idclient"],
        map["idcouturier_c"],
        map["idclientFirestore"],
        map["nomclient"],
        map["prenomclient"],
        map["sexeclient"],
        map["teintclient"],
        map["avatarclient"],
        map["ca_dos"],
        map["telephoneclient"],
        map["code_pays"],
        map["h_poitrine"],
        map["lg_buste"],
        map["lg_corsage"],
        map["lg_robe"],
        map["encolure"],
        map["ca_devant"],
        map["tr_poitrine"],
        map["ecart_sein"],
        map["tr_de_taille"],
        map["lg_jupe"],
        map["lg_pantalon"],
        map["lg_dos"],
        map["larg_dos"],
        map["lg_manche"],
        map["tr_de_manche"],
        map["poignet"],
        map["pente"]);
  }

//les nouveau client depuis un query
  factory Client.fromQuery(QueryDocumentSnapshot map) {
    return Client(
        map["idclient"],
        map["idcouturier_c"],
        map["idclientFirestore"],
        map["nomclient"],
        map["prenomclient"],
        map["sexeclient"],
        map["teintclient"],
        map["avatarclient"],
        map["ca_dos"],
        map["telephoneclient"],
        map["code_pays"],
        map["h_poitrine"],
        map["lg_buste"],
        map["lg_corsage"],
        map["lg_robe"],
        map["encolure"],
        map["ca_devant"],
        map["tr_poitrine"],
        map["ecart_sein"],
        map["tr_de_taille"],
        map["lg_jupe"],
        map["lg_pantalon"],
        map["lg_dos"],
        map["larg_dos"],
        map["lg_manche"],
        map["tr_de_manche"],
        map["poignet"],
        map["pente"]);
  }


  Client.map(dynamic obj) {
    this._idclient = obj['idclient'];
    this._nomclient = obj['nomclient'];
    this._idclientFirestore = obj['idclientFirestore'];
    this._prenomclient = obj['prenomclient'];
    this._sexeclient = obj['sexeclient'];
    this._teintclient = obj['teintclient'];
    this._avatarclient = obj['avatarclient'];
    this._telephoneclient = obj['telephoneclient'];
    this._code_pays = obj['code_pays'];
    this._ca_dos = obj['ca_dos'];
    this._h_poitrine = obj['h_poitrine'];
    this._lg_buste = obj['lg_buste'];
    this._lg_corsage = obj['lg_corsage'];
    this._lg_robe = obj['lg_robe'];
    this._encolure = obj['encolure'];
    this._ca_devant = obj['ca_devant'];
    this._tr_poitrine = obj['tr_poitrine'];
    this._ecart_sein = obj['ecart_sein'];
    this._tr_de_taille = obj['tr_de_taille'];
    this._lg_jupe = obj['lg_jupe'];
    this._lg_pantalon = obj['lg_pantalon'];
    this._lg_dos = obj['lg_dos'];
    this._larg_dos = obj['larg_dos'];
    this._lg_manche = obj['lg_manche'];
    this._tr_de_manche = obj['tr_de_manche'];
    this._poignet = obj['poignet'];
    this._pente = obj['pente'];
    this._idcouturier_c = obj['idcouturier_c'];
  }

  Client.fromSnapshots(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        _idclient = snapshot.get('idclient'),
        _idclientFirestore = snapshot.id,
        _idcouturier_c = snapshot.get('idcouturier_c'),
        _nomclient = snapshot.get('nomclient'),
        _prenomclient = snapshot.get('prenomclient'),
        _sexeclient = snapshot.get('sexeclient'),
        _teintclient = snapshot.get('teintclient'),
        _avatarclient = snapshot.get('avatarclient'),
        _telephoneclient = snapshot.get('telephoneclient'),
        _code_pays = snapshot.get('code_pays'),
        _ca_dos = double.parse(snapshot.get('ca_dos').toString()),
        _h_poitrine = double.parse(snapshot.get('h_poitrine').toString()),
        _lg_buste = double.parse(snapshot.get('lg_buste').toString()),
        _lg_corsage = double.parse(snapshot.get('lg_corsage').toString()),
        _lg_robe = double.parse(snapshot.get('lg_robe').toString()),
        _encolure = double.parse(snapshot.get('encolure').toString()),
        _ca_devant = double.parse(snapshot.get('ca_devant').toString()),
        _tr_poitrine = double.parse(snapshot.get('tr_poitrine').toString()),
        _ecart_sein = double.parse(snapshot.get('ecart_sein').toString()),
        _tr_de_taille = double.parse(snapshot.get('tr_de_taille').toString()),
        _lg_jupe = double.parse(snapshot.get('lg_jupe').toString()),
        _lg_pantalon = double.parse(snapshot.get('lg_pantalon').toString()),
        _lg_dos = double.parse(snapshot.get('lg_dos').toString()),
        _larg_dos = double.parse(snapshot.get('larg_dos').toString()),
        _lg_manche = double.parse(snapshot.get('lg_manche').toString()),
        _tr_de_manche = double.parse(snapshot.get('tr_de_manche').toString()),
        _poignet = double.parse(snapshot.get('poignet').toString()),
        _pente = double.parse(snapshot.get('pente').toString());



  // Client.fromSnapshot(DocumentSnapshot snapshot)
  //     : assert(snapshot != null),
  //       _idclient = snapshot.data()['idclient'],
  //       _idclientFirestore = snapshot.id,
  //       _idcouturier_c = snapshot.data()['idcouturier_c'],
  //       _nomclient = snapshot.data()['nomclient'],
  //       _prenomclient = snapshot.data()['prenomclient'],
  //       _sexeclient = snapshot.data()['sexeclient'],
  //       _teintclient = snapshot.data()['teintclient'],
  //       _avatarclient = snapshot.data()['avatarclient'],
  //       _telephoneclient = snapshot.data()['telephoneclient'],
  //       _code_pays = snapshot.data()['code_pays'],
  //       _ca_dos = double.parse(snapshot.data()['ca_dos'].toString()),
  //       _h_poitrine = double.parse(snapshot.data()['h_poitrine'].toString()),
  //       _lg_buste = double.parse(snapshot.data()['lg_buste'].toString()),
  //       _lg_corsage = double.parse(snapshot.data()['lg_corsage'].toString()),
  //       _lg_robe = double.parse(snapshot.data()['lg_robe'].toString()),
  //       _encolure = double.parse(snapshot.data()['encolure'].toString()),
  //       _ca_devant = double.parse(snapshot.data()['ca_devant'].toString()),
  //       _tr_poitrine = double.parse(snapshot.data()['tr_poitrine'].toString()),
  //       _ecart_sein = double.parse(snapshot.data()['ecart_sein'].toString()),
  //       _tr_de_taille = double.parse(snapshot.data()['tr_de_taille'].toString()),
  //       _lg_jupe = double.parse(snapshot.data()['lg_jupe'].toString()),
  //       _lg_pantalon = double.parse(snapshot.data()['lg_pantalon'].toString()),
  //       _lg_dos = double.parse(snapshot.data()['lg_dos'].toString()),
  //       _larg_dos = double.parse(snapshot.data()['larg_dos'].toString()),
  //       _lg_manche = double.parse(snapshot.data()['lg_manche'].toString()),
  //       _tr_de_manche = double.parse(snapshot.data()['tr_de_manche'].toString()),
  //       _poignet = double.parse(snapshot.data()['poignet'].toString()),
  //       _pente = double.parse(snapshot.data()['pente'].toString());


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idclient"] = _idclient;
    map["idclientFirestore"] = _idclientFirestore;
    map["nomclient"] = _nomclient;
    map["prenomclient"] = _prenomclient;
    map["sexeclient"] = _sexeclient;
    map["teintclient"] = _teintclient;
    map["avatarclient"] = _avatarclient;
    map["ca_dos"] = _ca_dos;
    map["telephoneclient"] = _telephoneclient;
    map["code_pays"] = _code_pays;
    map["h_poitrine"] = _h_poitrine;
    map["lg_buste"] = _lg_buste;
    map["lg_corsage"] = _lg_corsage;
    map["lg_robe"] = _lg_robe;
    map["encolure"] = _encolure;
    map["ca_devant"] = _ca_devant;
    map["tr_poitrine"] = _tr_poitrine;
    map["ecart_sein"] = _ecart_sein;
    map["tr_de_taille"] = _tr_de_taille;
    map["lg_jupe"] = _lg_jupe;
    map["lg_pantalon"] = _lg_pantalon;
    map["lg_dos"] = _lg_dos;
    map["larg_dos"] = _larg_dos;
    map["lg_manche"] = _lg_manche;
    map["tr_de_manche"] = _tr_de_manche;
    map["poignet"] = _poignet;
    map["pente"] = _pente;
    map["idcouturier_c"] = _idcouturier_c;
    return map;
  }

  @override
  String toString() {
    return 'Client{_idclient: $_idclient, _idclientFirestore: $_idclientFirestore, _nomclient: $_nomclient, _prenomclient: $_prenomclient, _sexeclient: $_sexeclient, _teintclient: $_teintclient, _avatarclient: $_avatarclient, _ca_dos: $_ca_dos, _telephoneclient: $_telephoneclient,_code_pays: $_code_pays, _h_poitrine: $_h_poitrine, _lg_buste: $_lg_buste, _lg_corsage: $_lg_corsage, _lg_robe: $_lg_robe, _encolure: $_encolure, _ca_devant: $_ca_devant, _tr_poitrine: $_tr_poitrine, _ecart_sein: $_ecart_sein, _tr_de_taille: $_tr_de_taille, _lg_jupe: $_lg_jupe, _lg_pantalon: $_lg_pantalon, _lg_dos: $_lg_dos, _larg_dos: $_larg_dos, _lg_manche: $_lg_manche, _tr_de_manche: $_tr_de_manche, _poignet: $_poignet, _pente: $_pente, _idcouturier_c:$_idcouturier_c}';
  }

  // GETTER
  int get idclient => _idclient;

  String get idclientFirestore => _idclientFirestore;

  String get idcouturier_c => _idcouturier_c;

  String get nomclient => _nomclient;

  String get prenomclient => _prenomclient;

  String get sexeclient => _sexeclient;

  String get teintclient => _teintclient;

  String get avatarclient => _avatarclient;

  double get ca_dos => _ca_dos;

  String get telephoneclient => _telephoneclient;

  String get code_pays => _code_pays;

  double get h_poitrine => _h_poitrine;

  double get lg_buste => _lg_buste;

  double get lg_corsage => _lg_corsage;

  double get lg_robe => _lg_robe;

  double get encolure => _encolure;

  double get ca_devant => _ca_devant;

  double get tr_poitrine => _tr_poitrine;

  double get ecart_sein => _ecart_sein;

  double get tr_de_taille => _tr_de_taille;

  double get lg_jupe => _lg_jupe;

  double get lg_pantalon => _lg_pantalon;

  double get lg_dos => _lg_dos;

  double get larg_dos => _larg_dos;

  double get lg_manche => _lg_manche;

  double get tr_de_manche => _tr_de_manche;

  double get poignet => _poignet;

  double get pente => _pente;

  set idclientFirestore(String value) {
    _idclientFirestore = value;
  } //SETTER
  set pente(double value) {
    _pente = value;
  }

  set poignet(double value) {
    _poignet = value;
  }

  set tr_de_manche(double value) {
    _tr_de_manche = value;
  }

  set lg_manche(double value) {
    _lg_manche = value;
  }

  set larg_dos(double value) {
    _larg_dos = value;
  }

  set lg_dos(double value) {
    _lg_dos = value;
  }

  set lg_pantalon(double value) {
    _lg_pantalon = value;
  }

  set lg_jupe(double value) {
    _lg_jupe = value;
  }

  set tr_de_taille(double value) {
    _tr_de_taille = value;
  }

  set ecart_sein(double value) {
    _ecart_sein = value;
  }

  set tr_poitrine(double value) {
    _tr_poitrine = value;
  }

  set ca_devant(double value) {
    _ca_devant = value;
  }

  set encolure(double value) {
    _encolure = value;
  }

  set lg_robe(double value) {
    _lg_robe = value;
  }

  set lg_corsage(double value) {
    _lg_corsage = value;
  }

  set lg_buste(double value) {
    _lg_buste = value;
  }

  set h_poitrine(double value) {
    _h_poitrine = value;
  }

  set telephoneclient(String value) {
    _telephoneclient = value;
  }

  set code_pays(String value) {
    _code_pays = value;
  }

  set ca_dos(double value) {
    _ca_dos = value;
  }

  set avatarclient(String value) {
    _avatarclient = value;
  }

  set teintclient(String value) {
    _teintclient = value;
  }

  set sexeclient(String value) {
    _sexeclient = value;
  }

  set prenomclient(String value) {
    _prenomclient = value;
  }

  set nomclient(String value) {
    _nomclient = value;
  }

  set idclient(int value) {
    _idclient = value;
  }

  set idcouturier_c(String value) {
    _idcouturier_c = value;
  }
}
/**
    _idclient
    _nomclient
    _prenomclient
    _sexeclient
    _teintclient
    _avatarclient
    _ca_dos
    _telephoneclient
    _h_poitrine
    _lg_buste
    _lg_corsage
    _lg_robe
    _encolure
    _ca_devant
    _tr_poitrine
    _ecart_sein
    _tr_de_taille
    _lg_jupe
    _lg_pantalon
    _lg_dos
    _larg_dos
    _lg_manche
    _tr_de_manche
    _poignet
    _pente
 **/
