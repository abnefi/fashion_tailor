import '../Accueuils/AccueilPage.dart';
import 'InscriptionVariables.dart';
import 'package:flutter/cupertino.dart';
import '../../models/couturier.dart';
import '../../data/Controles/CtrCouturier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
/*import 'package:google_maps_flutter/google_maps_flutter.dart';*/

class Inscription_3 extends StatefulWidget{
  final Couturier m3_ctp3;
  Inscription_3({Key key, @required this.m3_ctp3}) : super(key: key);
  static String tag = 'inscription_2-page';

  @override
  _Inscription_3State createState() => _Inscription_3State();
}

class _Inscription_3State extends State<Inscription_3>{
  final formkey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isLoading = false;
  String _idcouturier,_iduser_c;
  String _nomcouturier,_prenomcouturier,_sexecouturier,_typecouturier,_specialitecouturier,_avatarcouturier,_emailcouturier,_telephonecouturier,_adressecouturier,_localisationcouturier;
  TextEditingController _idcouturierController,_iduser_cController,_nomcouturierController,_prenomcouturierController,_sexecouturierController,_typecouturierController,_specialitecouturierController,_telephonecouturierController,_adressecouturierController,_localisationController;
  CtrCouturier ctrCouturier = new CtrCouturier();


  String m_avatarcouturier;
  String m_emailcouturier;
  String m_adressecouturier;

  @override
  void initState() {
    super.initState();

    _iduser_c=widget.m3_ctp3.iduser_c;
    _nomcouturier=widget.m3_ctp3.nomcouturier;
    _prenomcouturier=widget.m3_ctp3.prenomcouturier;
    _sexecouturier=widget.m3_ctp3.sexecouturier;
    _telephonecouturier=widget.m3_ctp3.telephonecouturier;

    _emailcouturier=widget.m3_ctp3.emailcouturier;
    _adressecouturier=widget.m3_ctp3.adressecouturier;
    _typecouturier=widget.m3_ctp3.typecouturier;
    _specialitecouturier=widget.m3_ctp3.specialitecouturier;

  }

  @override
  Widget build(BuildContext context){

    //Appar
    final appbar = AppBar(
      title: Text('E-Couture'),
    );

    //Fin Appbar

    final nextButton = Container(
        width: 129.0,
        height: 35.0,
        child:
        RaisedButton(
          onPressed: (){
            _submit();
          },
          color: Colors.blue,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          child:
          Text(
            "Terminer",
            style: TextStyle(
              fontSize: 17.0,
              fontFamily: 'Roboto Medium',
            ),
          ),
        )
    );

    final mapButton = Container(
        width: 200.0,
        height: 40.0,
        child:
        RaisedButton(
          onPressed: (){
            _showSnackBar("Hoops, une ereur s'est produite. Verifier votre gogle maps !!! ");
          },
          color: Colors.blue,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          child:
          Text(
            "Google Map",
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Roboto Medium',
            ),
          ),
        )
    );
    final avatarInput = TextFormField(
      onChanged: (String value){},
      onSaved:  ( val) => _avatarcouturier = val,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Nom du fichier Avatar',
          labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.camera_alt ,color: Colors.white70,),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
          enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
      validator: (input) => input.isEmpty ? 'Ce champ est requis' : null,
    );
    final localisationInput = TextFormField(
      onChanged: (String value){},
      onSaved:  ( val) => _localisationcouturier = val,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Localisation',
          labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.map,color: Colors.white70,),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
          enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
      validator: (input) => input.isEmpty ? 'Ce champ est requis' : null,
    );


    return Scaffold(
        //resizeToAvoidBottomPadding: true,
        appBar: appbar,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: bodyContainerDecorationImage,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0x0095FF).withOpacity(0.35),
              ),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child:
                    Column(
                      children: <Widget>[
                        Container(

                          child: Stack(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/Rectangle 7.png'),
                                color: Colors.blue,
                              ),
                              Positioned(
                                bottom: 25.0,
                                left: 25.0,
                                child: Text(
                                  'Inscription',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Roboto Medium',
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal:24.0),
                          child:
                          Text(
                              "Pour finaliser votre inscription nous avons besoin "
                                  "de connaître l'emplacement de votre atelier \n\n"
                                  "! Vous devez etre sur votre lieu de travail",
                              style: TextStyle(
                                  fontFamily: 'Roboto Medium',
                                  fontSize: 20.0,
                                  color: Colors.white
                              )
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.0, right: 24.0, top: 40.0),
                            child: Column(
                              children: <Widget>[
                                avatarInput,
                                SizedBox(
                                  height: 20.0,
                                ),
                                mapButton,
                                SizedBox(
                                  height: 20.0,
                                ),
                                localisationInput,
                                SizedBox(
                                  height: 70.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[nextButton],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }



  void verife(Couturier m_couturier) async
  {
    var couturierTest=new Couturier(null,null, null, null, null, null, null, null, null, null, null, null, null);
    couturierTest= await ctrCouturier.selectCouturier(m_couturier);
    if(couturierTest==null)
    {

      ctrCouturier.saveCouturier(m_couturier);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Accueil(para_iduserOline: _iduser_c),
      ),);

    } else
    {
      setState(() {
        _validate = true;
      });
      _showSnackBar("Ce couturier existe déja !!!");
    }

  }


  void _submit() {
    final form = formkey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();

        var ctp2 = new Couturier(null,null,_iduser_c,_nomcouturier,_prenomcouturier,_sexecouturier,_typecouturier,_specialitecouturier,_avatarcouturier,_emailcouturier,_telephonecouturier,_adressecouturier,_localisationcouturier);

        verife(ctp2);

      }
      );
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _validate = true;
      });
    }
  }



  void _showSnackBar(String text) {
    new SnackBar(
      content: new Text(text),
    );
  }

}