// // splashscreen:
//
// import 'package:flutter/material.dart';
// import 'package:splashscreen/splashscreen.dart';
// void main(){
//   runApp(new MaterialApp(
//     home: new MyApp(),
//   ));
// }
//
//
//
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return new SplashScreen(
//         seconds: 14,
//         navigateAfterSeconds: new AfterSplash(),
//         title: new Text('Welcome In SplashScreen',
//           style: new TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20.0
//           ),),
//         image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
//         backgroundColor: Colors.white,
//         styleTextUnderTheLoader: new TextStyle(),
//         photoSize: 100.0,
//         onClick: ()=>print("Flutter Egypt"),
//         loaderColor: Colors.red
//     );
//   }
// }
//
//
// class ECouture extends StatelessWidget
// {
//   static VoidCallback signOut;
//   //
//   final routes = <String, WidgetBuilder>{
//     //LoginPage.tag: (context) => new LoginPage(),
//     Inscription_1.tag: (context) => Inscription_1(),
//     Inscription_2.tag: (context) => Inscription_2(),
//     Inscription.tag: (context) => Inscription(),
//     Homepage.tag: (context) => Homepage(),
//     Connexion.tag: (context) => Connexion(),
//     Accueil.tag: (context) => Accueil(signOut: signOut),
//     SousCategorieHomme.tagHomme: (context) => SousCategorieHomme('Homme'),
//     SousCategorieHomme.tagFemme: (context) => SousCategorieHomme('Femme'),
//     SousCategorieHomme.tagEnfants: (context) => SousCategorieHomme('Enfants'),
//     SousCategorieHomme.tagCouples: (context) => SousCategorieHomme('Couples'),
//     AlbumGidView.albumGridTag: (context) => AlbumGidView('cool'),
//     CreerClient.tagCreerClient: (context) => CreerClient(),
//     CreerCommande.tagCreerCommande: (context) => CreerCommande(),
//     ModifierClient.tagModifierClient: (context) => ModifierClient(),
//     ChoisirClient.tagChoisirClient: (context) => ChoisirClient(),
//     DetailsClients.tagDetailClient: (context) => DetailsClients(Client(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,0)),
//     DetailsCommandes.tagDetailsCommandes: (context) => DetailsCommandes(),
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Connexion(),
//       //home: Accueil(),
//       routes: routes,
//     );
//   }
// }
