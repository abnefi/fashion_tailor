import '../Accueuils/AccueilPage.dart';
import 'InscriptionPage_2.dart';
import '../../data/Controles/CtrCouturier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class Inscription_1 extends StatefulWidget {
  final String m_iduser;
  //
  Inscription_1({Key key, @required this.m_iduser}) : super(key: key);

  //
  static String tag = 'inscription_1-page';

  @override
  _Inscription_1State createState() => _Inscription_1State();
}

 class Couturierpart1
{
  String m_iduser_c;
  String m_nomcouturier;
  String m_prenomcouturier;
  String m_sexecouturier;
  String m_telephonecouturier;

  Couturierpart1( this.m_iduser_c,
                  this.m_nomcouturier,
                  this.m_prenomcouturier,
                  this.m_sexecouturier,
                  this.m_telephonecouturier);
}

class _Inscription_1State extends State<Inscription_1> {
  //
  final formkey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isLoading = false;
  String _iduser_c;
  String _nomcouturier,_prenomcouturier,_sexecouturier,_telephonecouturier;
  TextEditingController _nomcouturierController,_prenomcouturierController,_sexecouturierController,_telephonecouturierController;
  Couturierpart1 ctp1;
  CtrCouturier ctrCouturier;

  int selectedRadio;

  String _value = null;

  List<String> _values = List<String>();


  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
    //
    _values.addAll(["Homme", "Femme", "Mixte"]);
    _value = _values.elementAt(0);

    _iduser_c=widget.m_iduser;

  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }


  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }


  void m_sexevalue(int sv)
  {
    if(sv==1)
      _sexecouturier="M";
    else
      _sexecouturier="F";
  }

  @override
  Widget build(BuildContext context) {


    final bodyContainerDecorationImage = BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/image2.jpg'),
        fit: BoxFit.cover,
      ),
    );


    final lastNameInput = TextFormField(
      onChanged: (String value){},
      onSaved:  ( val) => _nomcouturier = val,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Nom',
          labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.person,color: Colors.white70,),
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

    final firstNameInput = TextFormField(
      onChanged: (String value){},
      onSaved: ( val) => _prenomcouturier = val,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Prénom',
          labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.person,color: Colors.white70,),
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

    final telephoneInput = TextFormField(
      onChanged: (String value){},
      onSaved: ( val) => _telephonecouturier = val,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: 'Téléphone',
          labelStyle: TextStyle(
            fontFamily: 'Roboto Medium',
            fontSize: 15.0,
            color: Colors.white,
          ),
          prefixIcon: Icon(Icons.call,color: Colors.white70,),
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
      onSaved: ( val) => _nomcouturier = val,
      decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Roboto Medium',
              color: Colors.white
          ),
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.person,color: Colors.white70,),
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

    final gender = ButtonBar(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Sexe : ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Roboto Medium'),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  activeColor: Colors.white,
                  onChanged: (val) {
                    //print('Client $val selected');
                    setSelectedRadio(val);
                  },
                ),
                Text(
                  'M',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto Medium',
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  activeColor: Colors.white,
                  onChanged: (val) {
                    //print('Client $val selected');
                    setSelectedRadio(val);
                  },
                ),
                Text(
                  'F',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto Medium',
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );


    m_sexevalue(selectedRadio);


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
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.0, right: 24.0, top: 30.0),
                            child: Column(
                              children: <Widget>[
                                lastNameInput,
                                SizedBox(
                                  height: 20.0,
                                ),
                                firstNameInput,
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[gender],
                                ),
                                telephoneInput,
                                SizedBox(
                                  height: 30.0,
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


  void _submit() {
    final form = formkey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        //print(_code_pays);print(_telephoneclient);print(widget.client.idclient);
        ctp1 = new Couturierpart1(_iduser_c,_nomcouturier,_prenomcouturier,_sexecouturier,_telephonecouturier);

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Inscription_2(m2_ctp2: ctp1)
        ),
        );

      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _validate = true;
      });
    }
  }

}
