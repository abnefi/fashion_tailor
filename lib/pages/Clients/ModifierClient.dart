import 'CreationClientValues.dart';
import 'package:flutter/material.dart';

class ModifierClient extends StatefulWidget {

  static String tagModifierClient = 'tagModifierClient';

  @override
  _ModifierClientState createState() => _ModifierClientState();
}

class _ModifierClientState extends State<ModifierClient> {

  String _value = null ;
  List<String> _values = List<String>();

  String _value1 = null ;
  List<String> _values1 = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _values.addAll(["M","F"]);
    _value = _values.elementAt(0);

    _values1.addAll(["Noir","Clair"]);
    _value1 = _values1.elementAt(0);
  }

  void _onChanged(String value){
    setState(() {
      _value = value;
    });
  }

  void _onChanged1(String value){
    setState(() {
      _value1 = value;
    });
  }


  @override
  Widget build(BuildContext context) {

    //Appbar
    final creerClientAppbar = AppBar(
      title: Text('Nouveau Client'),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: null
        ),
      ],
      leading:
      IconButton(
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
      items: _values.map((String value){
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: <Widget>[
              Text(value)
            ],
          ),
        );
      }).toList(),
      onChanged: (String value){_onChanged(value);},
    );

    final teintClient = DropdownButton(
      value: _value1,
      items: _values1.map((String value){
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: <Widget>[
              Text(value)
            ],
          ),
        );
      }).toList(),
      onChanged: (String value){_onChanged1(value);},
    );

    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      appBar: creerClientAppbar,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child:
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/modele_femme_image1.jpg'),
                            radius: 45,
                          ),
                        ),
                        SizedBox(width: 15.0),
                        Container(
                          width: 210,
                          child:
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[Text('Nom : '),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        inputstyle
                                      ],
                                    )
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[Text('Telephone : '),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        inputstyle
                                      ],
                                    )
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[Text('Sexe : '),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        sexeClient
                                      ],
                                    )
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[Text('Teint : '),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        teintClient
                                      ],
                                    )
                                  ]
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15.0),
                    child:
                    Text(
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
            ],
          )
      ),
    );
  }
}
