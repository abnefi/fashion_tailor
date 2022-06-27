import 'package:flutter/material.dart';

class Produit
{
  String titre;
  String prix;

  Produit (this.titre,this.prix);

  Map <String,dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    map["titre"] = this.titre;
    map["prix"] = this.prix;
    return map;
  }
}
