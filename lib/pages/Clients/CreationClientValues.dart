import 'package:flutter/material.dart';

final inputstyle = TextField(
  keyboardType: TextInputType.text,
  autocorrect: true,
);

final table = Table(
  //border: TableBorder.all(),
  defaultColumnWidth: FlexColumnWidth(1.0),
  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  children: [
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('H Poitrine : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg jupe : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg Buste : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg Pantalon : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg Corsage : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg Dos : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg Robe : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Ca Dos : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Encolure : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Larg Dos : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Ca Devant : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Lg Manche : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Tr Poitrine : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Tr de Manche : ', style: TextStyle(fontSize: 12.5),),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Ecart Sein : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Poignet : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
    TableRow(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Tr de Taille : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text('Pente : '),],
              )
            ],
          ),
          Column(
            children: <Widget>[
              inputstyle
            ],
          ),
        ]
    ),
  ],
);