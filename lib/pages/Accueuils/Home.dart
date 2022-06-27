
import 'package:flutter/material.dart';
import '../Configurations/Appbarfile.dart';
import '../login/ConnexionPage.dart';

class Homepage extends StatefulWidget {
  //
  Homepage():super();

  static String tag = 'home-page';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Couture'),
      ),
      body:
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/boubou-femme.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child:
        Container(
            decoration: BoxDecoration(
              color: Color(0x0095FF).withOpacity(0.3),
            ),
            child:
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
                        child:
                        Text('E-Couture',
                          style: TextStyle(
                            fontSize: 48,
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 70, 0, 45),
                      child: Text('Vous êtes un ',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto Medium',
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Colors.white,
                          onChanged: (val){
                            //print('Client $val selected');
                            setSelectedRadio(val);
                          },
                        ),
                        Text(
                          'Client',
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
                          onChanged: (val){
                            print('Client $val selected');
                            setSelectedRadio(val);
                          },
                        ),
                        Text(
                          'Couturier(ère)',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto Medium',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 65.0),
                      width: 200.0,
                      height: 50.0,
                      child:
                      RaisedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(Connexion.tag);
                          },
                          textColor: Colors.white,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Text(
                            'Commencer',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto Medium',
                            ),
                          )
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),

    );

  }
}
