import 'dart:async';

import 'package:fashiontailor/utils/flutkart.dart';
import 'package:fashiontailor/utils/my_navigator.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var estImformer='';
  var token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
    //Timer(Duration(seconds: 5), () => MyNavigator.goToIntro(context) );
    Timer(Duration(seconds: 3), () => ((estImformer==null)||(estImformer==''))
        ? MyNavigator.goToIntro(context)
        :  ((token==null)||(token==''))
           ? MyNavigator.goToConnexion(context)
           : MyNavigator.goToAcceuil(context)
    );

  }

  Future<void> _refreshData() async {
    await StorageUtil.getInstance();
    token = StorageUtil.getString("token");
    print("Voici le token  :"+token);
    estImformer = StorageUtil.getString("estImformer");
    print("Voici l'etat estImformer  :"+estImformer);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.content_cut,
                          color: Colors.greenAccent,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        Flutkart.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      Flutkart.store,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
