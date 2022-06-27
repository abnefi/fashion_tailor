import 'package:flutter/material.dart';

final bodyContainerDecorationImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/image2.jpg'),
      fit: BoxFit.cover,
    ),
);

//final bodyContainerDecorationGradient = BoxDecoration(
//  gradient: LinearGradient(
//      begin: Alignment.topCenter,
//      end: Alignment.bottomCenter,
//      colors: [
//        Colors.white,
//        Colors.lightBlueAccent,
//      ]
//  ),
//);

final lastNameInput = TextFormField(
  onChanged: (String value){},
  onSaved: (String value){},
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
  onSaved: (String value){},
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
  onSaved: (String value){},
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

final passwordInput = TextFormField(
  obscureText: true,
  decoration: InputDecoration(
      labelText: 'Mot de Passe',
      labelStyle: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Roboto Medium',
          color: Colors.white
      ),
      alignLabelWithHint: true,
      prefixIcon: Icon(Icons.lock,color: Colors.white70,),
      suffixIcon: IconButton(
        onPressed: (){
        },
        icon: Icon(Icons.visibility_off),
      ),
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
