import '../Accueuils/AccueilPage.dart';
import 'InscriptionPage_3.dart';
import 'InscriptionPage_1.dart';
import '../../models/couturier.dart';
import '../../data/Controles/CtrCouturier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class Inscription_2 extends StatefulWidget {
  final Couturierpart1 m2_ctp2;
  Inscription_2({Key key, @required this.m2_ctp2}) : super(key: key);

  static String tag = 'inscription_1-page';

  @override
  _Inscription_2State createState() => _Inscription_2State();
}


class _Inscription_2State extends State<Inscription_2> {
  //
  final formkey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isLoading = false;
  String _idcouturier,_iduser_c;
  String _nomcouturier,_prenomcouturier,_sexecouturier,_typecouturier,_specialitecouturier,_avatarcouturier,_emailcouturier,_telephonecouturier,_adressecouturier,_localisationcouturier;
  TextEditingController _idcouturierController,_iduser_cController,_nomcouturierController,_prenomcouturierController,_sexecouturierController,_typecouturierController,_specialitecouturierController,_telephonecouturierController,_adressecouturierController,_localisationController;
  CtrCouturier ctrCouturier;

  String _value = null;

  List<String> _values = List<String>();

  String _value1 = null;

  List<String> _values1 = List<String>();

  @override
  void initState() {
    super.initState();

    _values.addAll(["Homme", "Femme", "Mixte"]);
    _value = _values.elementAt(0);

    _values1.addAll(["Styliste", "Brodeur", "Traditionnel"]);
    _value1 = _values1.elementAt(0);

    _iduser_c=widget.m2_ctp2.m_iduser_c;
    _nomcouturier=widget.m2_ctp2.m_nomcouturier;
    _prenomcouturier=widget.m2_ctp2.m_prenomcouturier;
    _sexecouturier=widget.m2_ctp2.m_sexecouturier;
    _telephonecouturier=widget.m2_ctp2.m_telephonecouturier;

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


  void _submit() {
    final form = formkey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();

        ctrCouturier = new CtrCouturier();


        var ctp2 = new Couturier(null,null,_iduser_c,_nomcouturier,_prenomcouturier,_sexecouturier,_typecouturier,_specialitecouturier,_avatarcouturier,_emailcouturier,_telephonecouturier,_adressecouturier,_localisationcouturier);



        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Inscription_3(m3_ctp3: ctp2,)
        ),
        );

      }
      );
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _validate = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    final bodyContainerDecorationImage = BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/image2.jpg'),
        fit: BoxFit.cover,
      ),
    );


    final localAdressInput = TextFormField(
      onChanged: (String value){},
      onSaved:  ( val) => _adressecouturier = val,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Adresse',
          labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.location_city,color: Colors.white70,),
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

    final emailInput = TextFormField(
      keyboardType: TextInputType.emailAddress,
     // validator: validateEmail,
      onSaved: ( val) => _emailcouturier = val,
      decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.mail,color: Colors.white70,),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
          enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
    );


    //Appar
    final appbar = AppBar(
      title: Text('E-Couture',
        style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    //fin Appbar

    final typeCouturier = DropdownButton(
      value: _value,
      items: _values.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: <Widget>[
              Text(
                value,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged(value);
      },
    );

    final specialiteCouturier = DropdownButton(
      value: _value1,
      items: _values1.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: <Widget>[Text(value),],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged1(value);
      },
    );


    _specialitecouturier=specialiteCouturier.value;
    _typecouturier=typeCouturier.value;


    final nextButton = Container(
        width: 129.0,
        height: 35.0,
        child: RaisedButton(
          onPressed: () {
            _submit();
          },
          color: Colors.indigoAccent,
          textColor: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            'Suivant',
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Roboto Medium',
            ),
          ),
        ));

    return Scaffold(
       // resizeToAvoidBottomPadding: true,
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
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.0, right: 24.0, top: 40.0),
                            child: Column(
                              children: <Widget>[
                                emailInput,
                                SizedBox(
                                  height: 20.0,
                                ),
                                localAdressInput,
                                SizedBox(
                                  height: 25.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Type de couturier(ère) :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Medium',
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Container(
                                      height: 25.0,
                                      decoration:
                                      BoxDecoration(color: Colors.white),
                                      child: typeCouturier,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Votre Spécialité :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Medium',
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Container(
                                      height: 25.0,
                                      decoration:
                                      BoxDecoration(color: Colors.white),
                                      child: specialiteCouturier,
                                    )
                                  ],
                                ),
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
}


String validateEmail(String value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email obligatoire";
  } else if(!regExp.hasMatch(value)){
    return "Invalid Email";
  }else {
    return null;
  }
}