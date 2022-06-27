import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/Utils/storage_util.dart';
import '../Accueuils/AccueilPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'InscriptionPage.dart';
import '../../models/user.dart';
import '../../data/Controles/CtrUser.dart';
import 'login_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:password/password.dart';

class Connexion extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _ConnexionState createState() => _ConnexionState();
}

enum LoginStatus { notSignIn, signIn }

class _ConnexionState extends State<Connexion> implements LoginPageContract {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  String m_idUser;
  bool _validate = false;
  bool passwordVisible;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password, _titre, _prix;
  CtrUser ctrUser = new CtrUser();
  TextEditingController _passwordController;
  LoginPagePresenter _presenter;
  List<User>list_users = new List();
  User monuser;

  final algorithm = PBKDF2();

  _ConnexionState() {
    _presenter = new LoginPagePresenter(this);
  }


  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      backgroundColor: Colors.lightBlueAccent,
    ));
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      // ignore: deprecated_member_use
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }


  @override
  void initState() {
    //ctrUser.getCount();
    super.initState();
    passwordVisible = true;
    _passwordController = new TextEditingController(text: _password);
    getPref();
  }


  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;

        //const primaryColor = const Color(0xFF151026);
        const primaryColor = const Color(0xFF2196F3);

        //Appbar
        final appbar = AppBar(
          title: Text('E-Couture'),
          backgroundColor: primaryColor,
          actions: <Widget>[
            PopupMenuButton <String>(
              onSelected: ChoiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choices) {
                  return PopupMenuItem<String>(
                    value: choices,
                    child: Text(choices),
                  );
                }).toList();
              },
            )
          ],
        );

        //Fin Appbar

        final text = Text(
          'CONNEXION',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Times New Roman',
          ),
        );

        final usernameInput = TextFormField(
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.amber,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              fillColor: Color(0xFF7892A7).withOpacity(0.3),
              filled: true,
              labelText: "Nom d'utilisateur",
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Times New Roman',
                  color: Colors.white
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white70,),
              alignLabelWithHint: true,
              hintText: 'Username',
              hintStyle: TextStyle(
                color: Colors.black54,
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
          ),
          //validator: validateUsername,
          onSaved: (val) => _username = val,
        );

        final passwordInput = TextFormField(
          controller: _passwordController,
          obscureText: passwordVisible,
          onSaved: (val) => _password = val,
          cursorColor: Colors.amber,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              fillColor: Color(0xFF7892A7).withOpacity(0.3),
              filled: true,
              labelText: 'Mot de Passe',
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Times New Roman',
                  color: Colors.white
              ),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.lock, color: Colors.white70,),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                    _passwordController.text = _password;
                    print(passwordVisible);

                    /* if(passwordVisible)
                      _passwordController.text=_password;*/
                  });
                },
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.black54,
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
          ),
          // validator: (input) =>
          // input.length < 8
          //     ? 'Minimum 8 caractères'
          //     : null,
        );


        final inputButton = Container(
            width: 200.0,
            height: 50.0,
            child:
            RaisedButton(
              onPressed: _onLoading,
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)
              ),
              child:
              Text(
                'Se connecter',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto Medium',
                ),
              ),
            )
        );

        final forgotPassText = FlatButton(
          child:
          Text(
              'Mot de passe oublié ?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.bold
              )

          ),
          onPressed: () {},

        );

        final createAccount = FlatButton(
          child:
          Text(
              'Créer un compte',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              )
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Inscription.tag);
          },
        );


        final pageConnexion = new Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/modele_homme_image18.jpg'),
                fit: BoxFit.cover,
              )
          ),
          child: Container(
              // decoration: BoxDecoration(
              //   color: Color(0x0095FF).withOpacity(0.3),
              // ),
              child:
              Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child:
                  Center(
                      child:
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child:
                        ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(left: 24.0, right: 24.0),
                          children: <Widget>[
                            text,
                            SizedBox(height: 60.0),
                            usernameInput,
                            SizedBox(height: 15.0),
                            passwordInput,
                            SizedBox(height: 30.0),
                            inputButton,
                            SizedBox(height: 15.0),
                            forgotPassText,
                            SizedBox(height: 20.0),
                            createAccount,
                          ],
                        ),
                      )
                  )
              )
          ),
        );

        return new Scaffold(
          appBar: appbar,
          key: scaffoldKey,
          body: new Container(
            child: new Center(
              child: pageConnexion,
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return Accueil(para_iduserOline: m_idUser, signOut: signOut);
        break;
    }
  }


  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit(); // ignore: deprecated_member_use
    });
  }


  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Identifiant ou mot de passe incorrecte");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    /**
        if(user != null){
        savePref(1,user.username, user.password);
        _loginStatus = LoginStatus.signIn;
        }
     **/
    if (user.username == "") {
      _showSnackBar("Veiller remplir votre username");
    } else {
      _showSnackBar(user.toString());
    }
    setState(() {
      _isLoading = false;
    });

    if (user.flaglogged == "logged") {
      print("Logged");

      m_idUser = user.idFireStore;

      print("cool, passons le token :");
      print(m_idUser);

      StorageUtil.putString("token", m_idUser);

      var tokenr = StorageUtil.getString("token");
      print("Voici le token préInserer");
      print(tokenr);

      print("Voici EstInformerzzz");
      var informe=StorageUtil.getString("estImformer");
      print(informe);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Accueil(para_iduserOline: m_idUser, signOut: signOut)),
            (Route<dynamic> route) => false,
      );

    } else {
      print("Not Logged");
    }
  }


  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: new CircularProgressIndicator());
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      _submit();
    });
  }


}

String validateUsername(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}
//Here, We have set 10 digits validation on mobile number.
String validateMobile(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Mobile is Required";
  } else if (value.length != 10) {
    return "Mobile number must 10 digits";
  } else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
}

//For Email Verification we using RegEx.
String validateEmail(String value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}


class Constants {
  static const String MonCompte = 'Mon compte';
  static const String Parametres = 'Paramètres';
  static const String Partager = 'Partager';
  static const String Apropos = 'A propos';
  static const String Quitter = 'Quitter';

  static const List<String> choices = <String>[
    MonCompte, Parametres, Partager, Apropos, Quitter
  ];
}


void ChoiceAction(String choice) {
  //print ('Working');
  if (choice == 'Mon compte') {
    print('je veux manger');
  }
}
