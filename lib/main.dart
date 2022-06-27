import 'dart:io';

import 'package:fashiontailor/pages/Configurations/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//child:RadialExpansionImage(imageName: _avatarclient,description: _prenomclient,user: _idclientFirestore),



//import 'pages/logi0n_.dart';
import 'Utils/storage_util.dart';
import 'pages/Accueuils/AccueilPage.dart';
import 'pages/Accueuils/home_screen.dart';
import 'pages/Accueuils/intro_screen.dart';
import 'pages/Accueuils/splash_screen.dart';
import 'pages/Commandes/ListeCommandesParClients.dart';
import 'pages/login/ConnexionPage.dart';
import 'pages/login/InscriptionPage_1.dart';
import 'pages/login/InscriptionPage_2.dart';
import 'pages/login/InscriptionPage.dart';
import 'pages/Accueuils/SousCategorie_Homme.dart';
import 'pages/Accueuils/Home.dart';
import 'pages/Clients/DonneesClients.dart';
import 'pages/Accueuils/ModelesHomme.dart';
import 'pages/Commandes/DetailsCommandes.dart';
import 'pages/Clients/ModifierClient.dart';

import 'pages/Clients/CreationClient.dart';
import 'pages/Commandes/CreationCommande.dart';
import 'pages/Clients/ChoisirClient.dart';

import 'models/client.dart';

bool USE_FIRESTORE_EMULATOR = true;


void main() async {
  HttpOverrides.global = new MyHttpOverrides(); // A enlever apres avant mode production
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageUtil.getInstance();

  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = const Settings(
      //host: 'localhost:8080',
      //sslEnabled: false,
      persistenceEnabled: true,
    );
  }
  //final Future<void> loadedLibrary = await app.loadLibrary();
  runApp(ECouture());
}



class ECouture extends StatelessWidget
{
  static VoidCallback signOut;

  final routes = <String, WidgetBuilder>{
    Inscription_1.tag: (context) => Inscription_1(),
    Inscription_2.tag: (context) => Inscription_2(),
    Inscription.tag: (context) => Inscription(),
    Homepage.tag: (context) => Homepage(),
    Connexion.tag: (context) => Connexion(),
    Accueil.tag: (context) => Accueil(signOut: signOut),
    SousCategorieHomme.tagHomme: (context) => SousCategorieHomme('Homme'),
    SousCategorieHomme.tagFemme: (context) => SousCategorieHomme('Femme'),
    SousCategorieHomme.tagEnfants: (context) => SousCategorieHomme('Enfants'),
    SousCategorieHomme.tagCouples: (context) => SousCategorieHomme('Couples'),
    AlbumGidView.albumGridTag: (context) => AlbumGidView('cool',''),
    CreerClient.tagCreerClient: (context) => CreerClient(),
    CreerCommande.tagCreerCommande: (context) => CreerCommande(),
    ModifierClient.tagModifierClient: (context) => ModifierClient(),
    ChoisirClient.tagChoisirClient: (context) => ChoisirClient(),
    DetailsClients.tagDetailClient: (context) => DetailsClients(Client(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,0)),
    DetailsCommandes.tagDetailsCommandes: (context) => DetailsCommandes(commande: null),
    HomeScreen.tagHomeScreen: (context) => HomeScreen(),
    IntroScreen.tagIntroScreen: (context) => IntroScreen(),
    ListeCommandesParClients.taglisteCommandeParClient: (context) => ListeCommandesParClients(),
  };

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
    );
  }
}

// A enlever apres avant mode production
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}