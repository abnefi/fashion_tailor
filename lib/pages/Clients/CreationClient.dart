import 'package:fashiontailor/data/Cloud_Service/cs_client.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

//import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:io';
//import 'package:path/path.dart';
import '../../data/Controles/CtrClient.dart';
import '../../data/Controles/CtrCouturier.dart';
import '../../models/client.dart';
import '../../models/couturier.dart';

import 'DetailsClients.dart';
import 'ListeClients.dart';

class CreerClient extends StatefulWidget {
  static String tagCreerClient = 'tagCreerClient';
  final Client client;
  final String iduserOnline;

  CreerClient({Key key, @required this.client, this.iduserOnline})
      : super(key: key);

  @override
  _CreerClientState createState() => _CreerClientState();
}

class Constants {
  static const String MonCompte = 'Mon compte';
  static const String Parametres = 'Paramètres';
  static const String Partager = 'Partager';
  static const String Apropos = 'A propos';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String>[
    MonCompte,
    Parametres,
    Partager,
    Apropos,
    Quitter
  ];
}

void ChoiceAction(String choice) {
  if (choice == 'Mon compte') {}
}

class _CreerClientState extends State<CreerClient> {
  CtrClient ctrClient;
  CtrCouturier ctrCouturier;

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  Couturier monCouturier;
  int m_idCouturier;
  Cloud_Service_Client ctrsClient = new Cloud_Service_Client();
  var token = StorageUtil.getString("token");

  String _nomclient,
      _prenomclient,
      _sexeclient,
      _teintclient,
      _avatarclient,
      _telephoneclient,
      _code_pays;
  double _ca_dos,
      _h_poitrine,
      _lg_buste,
      _lg_corsage,
      _lg_robe,
      _encolure,
      _ca_devant,
      _tr_poitrine,
      _ecart_sein,
      _tr_de_taille,
      _lg_jupe,
      _lg_pantalon,
      _lg_dos,
      _larg_dos,
      _lg_manche,
      _tr_de_manche,
      _poignet,
      _pente;
  String _idcouturier_c;

  String _value = null;

  List<String> _values = List<String>();

  String _value1 = null;

  List<String> _values1 = List<String>();

  TextEditingController _nomclientController,
      _prenomclientController,
      _ca_dosController,
      _h_poitrineController,
      _lg_busteController,
      _lg_corsageController,
      _lg_robeController,
      _encolureController,
      _ca_devantController,
      _tr_poitrineController,
      _ecart_seinController,
      _tr_de_tailleController,
      _lg_jupeController,
      _lg_pantalonController,
      _lg_dosController,
      _larg_dosController,
      _lg_mancheController,
      _tr_de_mancheController,
      _poignetController,
      _penteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _values.addAll(["M", "F"]);

    _values1.addAll(["Noir", "Clair"]);

    if (widget.client.sexeclient.toString() == 'M') {
      _value = _values.elementAt(0);
    } else {
      _value = _values.elementAt(1);
    }

    if (widget.client.teintclient.toString() == 'Clair') {
      _value1 = _values1.elementAt(1);
    } else {
      _value1 = _values1.elementAt(0);
    }

    _telephoneclient = widget.client.telephoneclient;
    _code_pays = widget.client.code_pays;

    _nomclientController =
        new TextEditingController(text: widget.client.nomclient);
    _prenomclientController =
        new TextEditingController(text: widget.client.prenomclient);
    _ca_dosController =
        new TextEditingController(text: widget.client.ca_dos.toString());
    _h_poitrineController =
        new TextEditingController(text: widget.client.h_poitrine.toString());
    _lg_busteController =
        new TextEditingController(text: widget.client.lg_buste.toString());
    _lg_corsageController =
        new TextEditingController(text: widget.client.lg_corsage.toString());
    _lg_robeController =
        new TextEditingController(text: widget.client.lg_robe.toString());
    _encolureController =
        new TextEditingController(text: widget.client.encolure.toString());
    _ca_devantController =
        new TextEditingController(text: widget.client.ca_devant.toString());
    _tr_poitrineController =
        new TextEditingController(text: widget.client.tr_poitrine.toString());
    _ecart_seinController =
        new TextEditingController(text: widget.client.ecart_sein.toString());
    _tr_de_tailleController =
        new TextEditingController(text: widget.client.tr_de_taille.toString());
    _lg_jupeController =
        new TextEditingController(text: widget.client.lg_jupe.toString());
    _lg_pantalonController =
        new TextEditingController(text: widget.client.lg_pantalon.toString());
    _lg_dosController =
        new TextEditingController(text: widget.client.lg_dos.toString());
    _larg_dosController =
        new TextEditingController(text: widget.client.larg_dos.toString());
    _lg_mancheController =
        new TextEditingController(text: widget.client.lg_manche.toString());
    _tr_de_mancheController =
        new TextEditingController(text: widget.client.tr_de_manche.toString());
    _poignetController =
        new TextEditingController(text: widget.client.poignet.toString());
    _penteController =
        new TextEditingController(text: widget.client.pente.toString());
    _penteController =
        new TextEditingController(text: widget.client.pente.toString());

    _idcouturier_c = widget.client.idcouturier_c;
    _avatarclient = widget.client.avatarclient.toString();
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  void _onChanged1(String value) {
    setState(() {
      _value1 = value;
    });
  }

  File imageFile;

  _prendrePhoto() async {
    try {
      final picker = ImagePicker();
      final photo = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 400,
      );
      this.setState(() {
        if (photo != null) {
          imageFile = File(photo.path);
          print("L'image camera est bon");
          print(photo.path);
        } else {
          print('Aucune image sélectionnée');
        }
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  _ouvrirGallery() async {
    try {
      final picker = ImagePicker();
      final photo = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 400,
      );
      this.setState(() {
        if (photo != null) {
          imageFile = File(photo.path);
          print("L'image gallery est bon");
          print(photo.path);
        } else {
          print('Aucune image sélectionnée');
        }
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Ajouter une photo',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Prendre une photo',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      _prendrePhoto();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    child: Text(
                      'Ouvrir la Gallery',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      _ouvrirGallery();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    child: Text(
                      'Annuler',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future InsertOrUpdateClient(File _image) async {
    if (imageFile == null)
    {
      if(_avatarclient=='image2.jpg')
        {
          _avatarclient='https://firebasestorage.googleapis.com/v0/b/fashiontailor-17711.appspot.com/o/images%2Favatars%2FcouturiersClients%2Favatar.png?alt=media&token=f15d46b7-fc30-4d1c-951a-bfeb4543d114';
        }
      print("_avatarclient quand null : "+_avatarclient);

    } else
    {
      Reference ref = FirebaseStorage.instance.ref();
      String fileName = _image.path.split('/').last;

      TaskSnapshot addImg = await ref
          .child("images/avatars/couturiersClients/$fileName")
          .putFile(_image);

      if (addImg.state == TaskState.success) {
        final String downloadUrl = await addImg.ref.getDownloadURL();

        _avatarclient = downloadUrl;

      } else {
        _avatarclient='https://firebasestorage.googleapis.com/v0/b/fashiontailor-17711.appspot.com/o/images%2Favatars%2FcouturiersClients%2Favatar.png?alt=media&token=f15d46b7-fc30-4d1c-951a-bfeb4543d114';
      }
    }

    var clientsav = new Client(
        null,
        widget.iduserOnline,
        widget.client.idclientFirestore,
        _nomclient,
        _prenomclient,
        _sexeclient,
        _teintclient,
        _avatarclient,
        _telephoneclient,
        _code_pays,
        _ca_dos,
        _h_poitrine,
        _lg_buste,
        _lg_corsage,
        _lg_robe,
        _encolure,
        _ca_devant,
        _tr_poitrine,
        _ecart_sein,
        _tr_de_taille,
        _lg_jupe,
        _lg_pantalon,
        _lg_dos,
        _larg_dos,
        _lg_manche,
        _tr_de_manche,
        _poignet,
        _pente);

    var clientup = new Client(
        widget.client.idclient,
        token,
        widget.client.idclientFirestore,
        _nomclient,
        _prenomclient,
        _sexeclient,
        _teintclient,
        _avatarclient,
        _telephoneclient,
        _code_pays,
        _ca_dos,
        _h_poitrine,
        _lg_buste,
        _lg_corsage,
        _lg_robe,
        _encolure,
        _ca_devant,
        _tr_poitrine,
        _ecart_sein,
        _tr_de_taille,
        _lg_jupe,
        _lg_pantalon,
        _lg_dos,
        _larg_dos,
        _lg_manche,
        _tr_de_manche,
        _poignet,
        _pente);


    //CtrClient ctrClient = new CtrClient();
    if (widget.client.idclientFirestore == null ||
        widget.client.idclientFirestore == '') {
      ctrsClient.insertDataClient(clientsav);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListeClients(idUserOne: token),
        ),
      );
    } else {
      ctrsClient.editClient(clientup.idclientFirestore, clientup);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListeClients(idUserOne: token),
        ),
      );
    }
  }

  _decideImageView() {
    if (imageFile == null) {
      return CircleAvatar(
        backgroundImage: ((widget.client.idclientFirestore == '') ||
                (widget.client.idclientFirestore == null))
            ? AssetImage('assets/avatar.png')
            : NetworkImage(widget.client.avatarclient),
        radius: 50.0,
      );
    } else {
      return CircleAvatar(
        //backgroundImage: null,
        child: ClipOval(
            child: Image.file(
          imageFile,
        )),
        radius: 65.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    final telephoneCodePays =IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode:_code_pays,
      initialValue:_telephoneclient,
      onChanged: (phone) {
        this._telephoneclient = phone.number;
      },
      onCountryChanged: (country) {
        this._code_pays = country.code;
      },
    );

    //Appbar
    final creerClientAppbar = AppBar(
      title: Text('Nouveau Client'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          onPressed: _submit,
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
    //FinAppbar

    final sexeClient = DropdownButton(
      value: _value,
      items: _values.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: <Widget>[Text(value)],
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged(value);
      },
    );

    final teintClient = DropdownButton(
      value: _value1,
      items: _values1.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: <Widget>[Text(value)],
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged1(value);
      },
    );

    _sexeclient = sexeClient.value;
    _teintclient = teintClient.value;

    final table = Table(
      //border: TableBorder.all(),
      defaultColumnWidth: FlexColumnWidth(1.0),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        // 0: FixedColumnWidth(60), // this column has a fixed width of 50
        0: FlexColumnWidth(), // take the remaining space
        1: FlexColumnWidth(), // take the remaining space
        2: FlexColumnWidth(), // take the remaining space
        3: FlexColumnWidth(), // take the remaining space
      },
      children: [
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('H Poitrine : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _h_poitrineController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _h_poitrine = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg jupe : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_jupeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_jupe = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Buste : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_busteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_buste = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Pantalon:'),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_pantalonController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_pantalon = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Corsage:'),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_corsageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_corsage = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Dos : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_dosController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_dos = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Robe : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_robeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_robe = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Ca Dos : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _ca_dosController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _ca_dos = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Encolure : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _encolureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _encolure = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Larg Dos : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _larg_dosController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _larg_dos = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Ca Devant : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _ca_devantController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _ca_devant = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Lg Manche:'),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _lg_mancheController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _lg_manche = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Tr Poitrine : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _tr_poitrineController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _tr_poitrine = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tr d Manche:',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _tr_de_mancheController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _tr_de_manche = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Ecart Sein : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _ecart_seinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _ecart_sein = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Poignet : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _poignetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _poignet = double.parse(val),
              )
            ],
          ),
        ]),
        TableRow(children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Tr de Taille :'),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _tr_de_tailleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _tr_de_taille = double.parse(val),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Pente : '),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              TextFormField(
                controller: _penteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: validateMesure,
                onSaved: (val) => _pente = double.parse(val),
              )
            ],
          ),
        ]),
      ],
    );

    return Scaffold(
      //  resizeToAvoidBottomPadding: true,
      appBar: creerClientAppbar,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Form(
                key: formKey,
                // ignore: deprecated_member_use
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Stack(children: <Widget>[
                              _decideImageView(),
                              Positioned(
                                top: 60.0,
                                left: 70.0,
                                child: InkWell(
                                  onTap: () {
                                    return _showChoiceDialog(context);
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.add_a_photo),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(width: 1.0),
                          Expanded(
                            flex: 6,
                            child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(60),
                                // this column has a fixed width of 50
                                1: FlexColumnWidth(),
                                // take the remaining space
                              },
                              children: [
                                TableRow(children: [
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Prénom :'),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _prenomclientController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                        validator: validatePrenom,
                                        onSaved: (val) => _prenomclient = val,
                                      )
                                    ],
                                  )
                                ]),
                                TableRow(children: [
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Nom :'),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _nomclientController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                        validator: validateNom,
                                        onSaved: (val) => _nomclient = val,
                                      )
                                    ],
                                  )
                                ]),
                                TableRow(children: [
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Sexe : '),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[sexeClient],
                                  )
                                ]),
                                TableRow(children: [
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Teint : '),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[teintClient],
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        // telephone
                        width: 300, // MediaQuery.of(context).size.width
                        child: Table(
                            //Pour téléphone à cde pays
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(children: [
                                Column(
                                  children: <Widget>[telephoneCodePays],
                                ),
                              ]),
                            ])),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Mesures (cm)',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontFamily: 'Roboto Medium',
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.lightBlue,
                      height: 10,
                      thickness: 1.0,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: table,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();

        InsertOrUpdateClient(imageFile);
      });
    } else {
      //  If all data are not valid then start auto validation.
      setState(() {
        _validate = true;
      });
    }
  }
}

//Here you can see that we are returning “Name must be more than 2 character”
//if input text length is less than 3 else we are returning null.

String validateNom(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Nom est obligatoire";
  } else if (!regExp.hasMatch(value)) {
    return "Nom doit etre entre a-z et A-Z";
  }
  return null;
}

String validatePrenom(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Prénom est obligatoire";
  } else if (!regExp.hasMatch(value)) {
    return "Prénom doit etre entre a-z et A-Z";
  }
  return null;
}

//Here, We have set 10 digits validation on mobile number.
String validateTelephone(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Obligatoire";
  } else if (value.length != 8) {
    return "Numero invalide Ex:61169769";
  } else if (!regExp.hasMatch(value)) {
    return "Numero invalide";
  }
  return null;
}

//Here, We have set 10 digits validation on mobile number.
String validateMesure(String value) {
  String patttern = r'(^[0-9\.]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Obligatoire";
  } else if (value.length > 5) {
    return "Mesure incorrecte";
  } else if (!regExp.hasMatch(value)) {
    return "Mesure invalide";
  }
  return null;
}

//For Email Verification we using RegEx.
String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email obligatoire";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}
