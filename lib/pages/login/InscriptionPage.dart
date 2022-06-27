import 'ConnexionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/Controles/CtrUser.dart';
import '../../data/Cloud_Service/cs_user.dart';
import '../../models/user.dart';
import 'package:password/password.dart';

class Inscription extends StatefulWidget {
  static String tag = 'inscription-page';

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool passwordVisible;

  String _email, _username, _password;
  TextEditingController _passwordController;
  final algorithm = PBKDF2();

  Cloud_Service_User ctrCloudUser = new Cloud_Service_User();

  CtrUser ctrUser = new CtrUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
    _passwordController = new TextEditingController(text: _password);
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    //Appbar
    final appbar = AppBar(
      title: Text('E-Couture'),
      actions: <Widget>[
        PopupMenuButton<String>(
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
      'INSCRIPTION',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontFamily: 'Roboto Medium',
      ),
    );

    final usernameInput = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Nom d'utilisateur",
          labelStyle: TextStyle(
              fontSize: 15.0, fontFamily: 'Roboto Medium', color: Colors.white),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.white70,
          ),
          alignLabelWithHint: true,
          hintText: 'Username',
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      validator: validateUsername,
      onSaved: (val) => _username = val,
    );

    final emailInput = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Votre eamail",
          labelStyle: TextStyle(
              fontSize: 15.0, fontFamily: 'Roboto Medium', color: Colors.white),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white70,
          ),
          alignLabelWithHint: true,
          hintText: 'Votre email',
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      validator: validateEmail,
      onSaved: (val) => _email = val,
    );

    final passwordInput = TextFormField(
      obscureText: passwordVisible,
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: 'Mot de Passe',
          labelStyle: TextStyle(
              fontSize: 15.0, fontFamily: 'Roboto Medium', color: Colors.white),
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white70,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                passwordVisible = !passwordVisible;
                _passwordController.text = _password;
              });
            },
          ),
          hintText: 'Votre Mot de Passe',
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      validator: (input) => input.length < 8 ? 'Minimum 8 caractères' : null,
      onSaved: (val) => _password = val,
    );

    final passwordInputs = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Verification de Passe',
          labelStyle: TextStyle(
              fontSize: 15.0, fontFamily: 'Roboto Medium', color: Colors.white),
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white70,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.visibility_off),
          ),
          hintText: 'Ressaisir votre mot de passe',
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      validator: (input) => input.length < 8 ? 'Minimum 8 caractères' : null,
    );

    final inputButton = Container(
        width: 200.0,
        height: 50.0,
        child: RaisedButton(
          onPressed: _submit,
          color: Colors.blue,
          textColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: Text(
            'Valider',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Roboto Medium',
            ),
          ),
        ));

    final forgotPassText = FlatButton(
      child: Text('Mot de passe oublié ?',
          style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              wordSpacing: 2.0,
              fontWeight: FontWeight.bold)),
      onPressed: () {},
    );

    final olderAccount = FlatButton(
      child: Text('Deja un compte',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.of(context).pushNamed(Connexion.tag);
      },
    );

    return Scaffold(
        appBar: appbar,
        key: scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/tenue-jaune-femme.jpg'),
            fit: BoxFit.cover,
          )),
          child: Container(
              decoration: BoxDecoration(
                color: Color(0x0095FF).withOpacity(0.3),
              ),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(left: 24.0, right: 24.0),
                        children: <Widget>[
                          text,
                          SizedBox(height: 55.0),
                          usernameInput,
                          SizedBox(height: 15.0),
                          emailInput,
                          SizedBox(height: 15.0),
                          passwordInput,
                          //SizedBox(height: 15.0),
                          //passwordInputs,
                          SizedBox(height: 30.0),
                          inputButton,
                          SizedBox(height: 20.0),
                          olderAccount,
                        ],
                      ),
                    ),
                  ))),
        ));
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void verife(User m_user) async {
    //userTest= await ctrUser.VerificationExiste(m_user);
    bool userTest = await ctrCloudUser.ifUserExiste(m_user);
    print('Mon userTest est:');
    print(userTest);

    if (userTest == false)
    {
      print('Jenregistre ici le nouveau utilisateur');
     // ctrUser.saveUser(m_user);
      ctrCloudUser.insertDataUser(m_user);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Connexion(),
        ),
      );
    } else {
      setState(() {
        _validate = true;
      });
      print("Ce nom d'utilisateur existe déja !!!");
      _showSnackBar("Ce nom d'utilisateur existe déja !!!");
    }
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      //final hash= Password.hash(_passwordController.toString(), algorithm);
      setState(() {
        _isLoading = true;
        form.save();
        var user = new User(null,null, _email, _username, _password, null);

        verife(user);

        _isLoading = false;
      });
    } else {
//    If all data are not valid then start auto validation.
    print("Tout les champs ne sont pas valide");
      setState(() {
        _validate = true;
      });
    }
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
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

void _showSnackBar(String text) {
  new SnackBar(
    content: new Text(text),
  );
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
  //print ('Working');
  if (choice == 'Mon compte') {
    print('je veux manger');
  }
}
