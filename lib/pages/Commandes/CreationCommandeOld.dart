import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_commande.dart';
import 'package:fashiontailor/data/Cloud_Service/cs_tenue.dart';
import 'package:fashiontailor/models/client.dart';
import 'package:fashiontailor/models/commande.dart';
import 'package:fashiontailor/models/tenue.dart';
import 'package:fashiontailor/pages/widgets/RadialExpansionImage.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreerCommande extends StatefulWidget {
  static String tagCreerCommande = 'tagCreerCommande';

  final Client client;
  final String idCommande;

  CreerCommande({Key key, @required this.client, @required this.idCommande}) : super(key: key);

  @override
  _CreerCommandeState createState() => _CreerCommandeState();
}

class _CreerCommandeState extends State<CreerCommande> {

  String _value1 = null;
  final formKey = new GlobalKey<FormState>();
  bool _validate = false;

  final formKeyC = new GlobalKey<FormState>();
  bool _validateC = false;

  Widget ajoutTenueDialog = null;

  List<String> _values1 = List<String>();

  double prixTenue;
  double montantAvancer;
  String observation;

  Widget _ajoutTenueDialog() {}

  Client monClient;
  Cloud_Service_Tenue ctrCloudTenue = new Cloud_Service_Tenue();
  Cloud_Service_Commande ctrCloudCommande = new Cloud_Service_Commande();
  final dbFirestore = FirebaseFirestore.instance;

  var token = '';

  @override
  void initState() {
    super.initState();
    token = StorageUtil.getString("token");
    print(widget.client.idclientFirestore);
    print("Voici le token cré commande");
    print(token);

    monClient = new Client(
        widget.client.idclient,
        widget.client.idcouturier_c,
        widget.client.idclientFirestore,
        widget.client.nomclient,
        widget.client.prenomclient,
        widget.client.sexeclient,
        widget.client.teintclient,
        widget.client.avatarclient,
        widget.client.telephoneclient,
        widget.client.code_pays,
        widget.client.ca_dos,
        widget.client.h_poitrine,
        widget.client.lg_buste,
        widget.client.lg_corsage,
        widget.client.lg_robe,
        widget.client.encolure,
        widget.client.ca_devant,
        widget.client.tr_poitrine,
        widget.client.ecart_sein,
        widget.client.tr_de_taille,
        widget.client.lg_jupe,
        widget.client.lg_pantalon,
        widget.client.lg_dos,
        widget.client.larg_dos,
        widget.client.lg_manche,
        widget.client.tr_de_manche,
        widget.client.poignet,
        widget.client.pente);
    _values1.addAll([
      "Manche Courte",
      "Manche Longue",
      "Pantalon",
      "Veste",
      "Tenue locale",
      "Robe",
      "Jupe",
      "Complet"
    ]);

    _value1 = _values1.elementAt(0);

    ajoutTenueDialog = _ajoutTenueDialog();
  }

  void _deleteTenue(BuildContext context, Tenue tenue, int position) async {
    ctrCloudTenue.supprimerTenue(tenue.idtenue);
    setState(() {
      // Je reinitialise la liste snapshort
    });
  }

  void _supprimerTenue(BuildContext context, Tenue tenue, int position) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Voulez-vous supprimer la Tenue ?',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              VerticalDivider(
                color: Colors.black45,
                width: 1.0,
              ),
              FlatButton(
                child: Text(
                  'Supprimer',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 15.0),
                ),
                onPressed: () {
                  _deleteTenue(context, tenue, position);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<Null> getRefresh() async
  {
    await Future.delayed(Duration(seconds: 3));
  }

  Widget listetenues() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: StreamBuilder<QuerySnapshot>(
        //stream: ctrCloudClient.chargerToutLesClientsDuCouturier(widget.idUserOne),
        //stream: dbFirestore.collection('Tenue').snapshots(),
        stream: ctrCloudTenue.chargerLesTenuesParCommande(widget.idCommande),
        // A ecrire en cs_client apres
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Il y a des erreurs');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return !snapshot.hasData
                ? Text('PLease Wait')
                : ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot dataTenue = snapshot.data.docs[index];
                Tenue tenue = Tenue.fromSnapshots(dataTenue);
                int chiffre = 1;
                chiffre += index;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  child: Dismissible(
                    key: ValueKey(tenue),
                    background: Container(
                      child:
                      // IconSlideAction(
                      //   icon: Icons.delete,
                      //   caption: 'Supprimer',
                      //   color: Colors.redAccent,
                      // ),
                      SlidableAction(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Share',
                      ),
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _deleteTenue(context, tenue, index);
                      });

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Tenue ' + '${chiffre} supprimé'),
                        action: SnackBarAction(
                          label: 'Annulé',
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ));
                    },
                    child: Card(
                      elevation: 1.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          return _voirDetailTenue(tenue);
                        },
                        title: Text('Tenue ' + '${chiffre}'),
                        leading: CircleAvatar(
                          backgroundImage: ((tenue.imgtissu == '') ||
                              (tenue.imgtissu == null))
                              ? AssetImage('assets/avatar.png')
                              : NetworkImage(tenue.imgtissu),
                          radius: 25,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _voirDetailTenue(Tenue tenue) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              tenue.observation.toString(),
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Photo du tissu',
                    style: TextStyle(
                        fontSize: 15, color: Colors.lightBlue),
                  ),
                  SizedBox(height: 15.0,),
                  Center(
                    child: Container(
                      child: Image(
                        image: ((tenue.imgtissu=='') || (tenue.imgtissu==null))
                            ?AssetImage('assets/avatar.png')
                            :NetworkImage(tenue.imgtissu),
                        //AssetImage(tenue.imgtissu),
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: 35.0,),
                  Text(
                    'Photo du modèle',
                    style: TextStyle(
                        fontSize: 15, color: Colors.lightBlue),
                  ),
                  SizedBox(height: 15.0,),
                  Center(
                    child: Container(
                      child: Image(
                        image: ((tenue.imgmodele=='') || (tenue.imgmodele==null))
                            ?AssetImage('assets/avatar.png')
                            :NetworkImage(tenue.imgmodele),
                        //AssetImage(tenue.imgmodele),
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  Row(
                    children: <Widget>[
                      Text(
                        'Type tenue:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                          tenue.typetenue.toString()
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Observation',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            tenue.observation.toString()
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.grey[400]
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _onChanged1(String value) {
    setState(() {
      _value1 = value;
    });
  }

  DateTime _dateTime, _dateTime1;
  DateTime currentDate = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async
  {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime == null ? DateTime.now() : _dateTime,
      firstDate: currentDate,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime1 == null ? DateTime.now() : _dateTime1,
      firstDate: _dateTime == null ? DateTime.now() : _dateTime,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _dateTime1) {
      setState(() {
        _dateTime1 = picked;
      });
    }
  }


  File imageFileTissu, imageFileModele;
  final picker = ImagePicker();
  String imageFileTissuS,imageFileModeleS;




  Future InserTenue(File _imageTissu,File _imageModele) async
  {
    if (_imageTissu == null || _imageModele == null)
    {
      imageFileTissuS = 'https://ae01.alicdn.com/kf/Ha3192e1b696b40858736fcb93f5795e3i/Robes-africaines-pour-femmes-2021-Dashiki-robe-de-soir-e-l-gante-manches-courtes-v-tements.jpg_640x640.jpg';
      imageFileModeleS = 'https://ae01.alicdn.com/kf/H3fb32dda1e8e4fe9b8f8ad0893aeede53/Robes-africaines-pour-femmes-2021-robe-africaine-dentelle-col-rond-manches-longues-robe-quotidienne-robe-de.jpg_640x640.jpg';
    } else
    {
      Reference ref = FirebaseStorage.instance.ref();
      String fileNameT = _imageTissu.path.split('/').last;
      String fileNameM = _imageModele.path.split('/').last;
      print("Le nom issu du path des fichiés");
      print(fileNameT);
      print(fileNameM);

      TaskSnapshot addImgT = await ref.child("images/tenues/tissus/$fileNameT").putFile(_imageTissu);
      TaskSnapshot addImgM = await ref.child("images/tenues/modeles/$fileNameM").putFile(_imageModele);
      print("Les images ont été jouter à Firebase Storage");

      if ((addImgT.state == TaskState.success) || (addImgM.state == TaskState.success))
      {
        final String downloadUrlT = await addImgT.ref.getDownloadURL();
        final String downloadUrlM = await addImgM.ref.getDownloadURL();

        print("L'url des images ajouté sont:");
        print(downloadUrlT);
        print(downloadUrlM);

        imageFileTissuS = downloadUrlT;
        imageFileModeleS = downloadUrlM;
      }
    }

    if (token != null || token != '')
    {
      ctrCloudTenue.insertDataTenue(Tenue(null, widget.idCommande, imageFileTissuS,imageFileModeleS,_value1.toString() , prixTenue, 'Cool', observation));
      Navigator.of(context).pop();
    }


  }



  void ajoutTenue() {
    final form = formKey.currentState;

    if (form.validate())
    {
      setState(()  {
        form.save();
        print(imageFileTissu.toString());
        print(prixTenue);
        print(widget.client.idclient);

        InserTenue(imageFileTissu,imageFileModele);

      });

    } else {
      //  If all data are not valid then start auto validation.
      setState(() {
        _validate = true;
      });
    }
  }



  void ajoutCommande() {
    final form = formKeyC.currentState;

    if (form.validate())
    {
      setState(()  {
        form.save();
        print('Voici le montant avancer');
        print(montantAvancer);

        ctrCloudCommande.insertDataCommande(Commande(null, widget.idCommande, monClient.idclientFirestore,token,  DateFormat('dd/MM/yyyy').format(_dateTime), montantAvancer,  DateFormat('dd/MM/yyyy').format(_dateTime1),monClient.avatarclient,'','Desc comd', 1, 2));
        print('Commande save');

        Navigator.of(context).pop();
      });

    } else {
      //  If all data are not valid then start auto validation.
      setState(() {
        _validateC = true;
      });
    }
  }





  @override
  Widget build(BuildContext context) {

    Widget _ajoutTenueDialog() {

      final choixTenue = DropdownButton(
        value: _value1,
        items: _values1.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Row(
              children: <Widget>[
                Text(value),
              ],
            ),
          );
        }).toList(),
        onChanged: (String value) {
          _onChanged1(value);
        },
      );


      _prendrePhotoTissu() async {
        final photo = await picker.getImage(source: ImageSource.camera,
          maxWidth: 200,
          maxHeight: 200,
        );
        this.setState(() {
          if (photo != null) {
            imageFileTissu = File(photo.path);
            // super.initState();
          } else {
            print('Aucune image sélectionnée');
          }
        });
        Navigator.of(context).pop();
      }

      _ouvrirGalleryTissu() async {
        final photo = await picker.getImage(source: ImageSource.gallery,
          maxWidth: 200,
          maxHeight: 200,
        );
        this.setState(() {
          if (photo != null) {
            imageFileTissu = File(photo.path);
          } else {
            print('Aucune image sélectionnée');
          }
        });
        Navigator.of(context).pop();
      }


      _prendrePhotoModele() async {
        final photo = await picker.getImage(source: ImageSource.camera,
          maxWidth: 200,
          maxHeight: 200,
        );
        this.setState(() {
          if (photo != null) {
            imageFileModele = File(photo.path);
            // super.initState();
          } else {
            print('Aucune image sélectionnée');
          }
        });
        Navigator.of(context).pop();
      }

      _ouvrirGalleryModele() async {
        final photo = await picker.getImage(source: ImageSource.gallery,
          maxWidth: 200,
          maxHeight: 200,
        );
        this.setState(() {
          if (photo != null) {
            imageFileModele = File(photo.path);
          } else {
            print('Aucune image sélectionnée');
          }
        });
        Navigator.of(context).pop();
      }

      void _showSelectedPickerTissu(context) {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return SafeArea(
                child: Container(
                  child: new Wrap(
                    children: <Widget>[
                      new ListTile(
                          leading: new Icon(Icons.photo_library),
                          title: new Text('Gallery'),
                          onTap: () {
                            _ouvrirGalleryTissu();
                            Navigator.of(context).pop();
                          }),
                      new ListTile(
                        leading: new Icon(Icons.photo_camera),
                        title: new Text('Camera'),
                        onTap: () {
                          _prendrePhotoTissu();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      }

      void _showSelectedPickerModele(context) {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return SafeArea(
                child: Container(
                  child: new Wrap(
                    children: <Widget>[
                      new ListTile(
                          leading: new Icon(Icons.photo_library),
                          title: new Text('Gallery'),
                          onTap: () {
                            _ouvrirGalleryModele();
                            Navigator.of(context).pop();
                          }),
                      new ListTile(
                        leading: new Icon(Icons.photo_camera),
                        title: new Text('Camera'),
                        onTap: () {
                          _prendrePhotoModele();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      }

      _decideImageViewTissu(context)
      {
        if (imageFileTissu == null) {
          return Center(
            child: IconButton(
              onPressed: () {
                return _showSelectedPickerTissu(context);
              },
              icon: Icon(Icons.image),
              iconSize: 110.0,
              color: Colors.grey,
            ),
          );
        } else {
          return Center(
              child: Container(
                child: Image.file(
                  imageFileTissu,
                  height: 150,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ));
        }
      }

      _decideImageViewModele(context) {
        if (imageFileModele == null) {
          return Center(
              child: IconButton(
                onPressed: () {
                  return _showSelectedPickerModele(context);
                },
                icon: Icon(Icons.image),
                iconSize: 110.0,
                color: Colors.grey,
              ));
        } else {
          return Center(
              child: Container(
                child: Image.file(
                  imageFileModele,
                  height: 150,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ));
        }
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 600,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Ajouter une nouvelle tenue',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Prendre une photo du tissu ...',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.lightBlue),
                              ),
                              Divider(
                                color: Colors.lightBlue,
                                thickness: 1.0,
                              ),
                              _decideImageViewTissu(context),
                              Text(
                                'Choisir un modèle',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.lightBlue),
                              ),
                              Divider(
                                color: Colors.lightBlue,
                                thickness: 1.0,
                              ),
                              _decideImageViewModele(context),
                              choixTenue,
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false, decimal: false),
                                  validator: validateMonant,
                                  onSaved: (value) =>prixTenue=double.parse(value),
                                  decoration: InputDecoration(
                                    hintText: 'Prix',
                                    hintStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Roboto',
                                        color: Colors.black45),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) =>observation=value,
                                  decoration: InputDecoration(
                                    hintText: 'Observations du client',
                                    hintStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Roboto',
                                        color: Colors.black45),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'ANNULER',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: ajoutTenue,
                                    child: Text(
                                      'VALIDER',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          });
    }

    //Appbar
    final creerCommandeAppbar = AppBar(
      title: Text('Nouvelle Commande'),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: ajoutCommande),
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
    return Scaffold(
      appBar: creerCommandeAppbar,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: RadialExpansionImage(imageName: monClient.avatarclient,
                              description: monClient.prenomclient,
                              user: monClient.idclientFirestore),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(monClient.prenomclient+' '+monClient.nomclient),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(monClient.telephoneclient),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Sexe : '+monClient.sexeclient),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('Teint : '+monClient.teintclient)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    child: Form(
                      key: formKeyC,
                      // ignore: deprecated_member_use
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 50.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(color: Colors.grey[300]),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    _dateTime == null
                                        ? 'Date de commande'
                                        : _dateTime.toString(),
                                    style:
                                    TextStyle(fontSize: 18.0, color: Colors.black54),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 50.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(color: Colors.grey[300]),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.date_range,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        _selectDate1(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    _dateTime1 == null ? 'Date de livraison' : _dateTime1
                                        .toString(),
                                    style:
                                    TextStyle(fontSize: 18.0, color: Colors.black54),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              validator: validateMonant,
                              onSaved: (value)  =>montantAvancer=double.parse(value),
                              decoration: InputDecoration(
                                hintText: 'Montant avancé',
                                hintStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Roboto',
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: FlatButton.icon(
                        onPressed: () {
                          return _ajoutTenueDialog();
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Colors.red,
                        ),
                        label: Text(
                          'ajouter une tenue',
                          style:
                          TextStyle(fontSize: 12.0, color: Colors.lightBlue),
                        ),
                      )),
                  Divider(
                    color: Colors.lightBlue,
                    height: 0,
                    thickness: 1.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: listetenues(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


//Here, We have set 10 digits validation on mobile number.
String validateMonant(String value) {
  String patttern = r'(^[0-9\.]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Obligatoire";
  } else if (!regExp.hasMatch(value)) {
    return "Valeur Incorrecte";
  }
  return null;
}




class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
              child: Text('Open Dialog'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return MyDialog();
                    });
              },
            )));
  }
}



class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Color _c = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: _c,
        height: 20.0,
        width: 20.0,
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Switch'),
            onPressed: () => setState(() {
              _c == Colors.redAccent
                  ? _c = Colors.blueAccent
                  : _c = Colors.redAccent;
            }))
      ],
    );
  }
}
