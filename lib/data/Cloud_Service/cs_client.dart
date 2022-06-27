import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/client.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';

class Cloud_Service_Client {
  CollectionReference firestoreReference =
      FirebaseFirestore.instance.collection('Client');
  var storage = firebase_storage.FirebaseStorage.instance;

  Stream<QuerySnapshot> chargerToutLesClientsDuCouturier(String idCouturier) {
    return firestoreReference
        .orderBy('nomclient', descending: true)
        .where("idcouturier_c", isEqualTo: idCouturier)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot> chargerUnSeulClient(String idClient) {
    return firestoreReference
        .where("idclientFirestore", isEqualTo: idClient)
        .limit(1)
        .snapshots();
  }


  Stream<QuerySnapshot> chargerToutLesClientsFiltrerDuCouturier(
      String idCouturier, String recherche) {
    print(idCouturier);
    print(recherche);
    return firestoreReference
        .orderBy('prenomclient', descending: true)
        .where("idcouturier_c", isEqualTo: idCouturier)
        .where("prenomclient", isGreaterThanOrEqualTo: recherche)

        //.where("prenomclient", arrayContains: recherche)
        //.where("prenomclient", arrayContainsAny: recherche)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot> chargerToutLesClients() {
    return firestoreReference
        .orderBy('nomclient', descending: true)
        .limit(20)
        .snapshots();
  }

  List<Client> getAllClientsFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Client.fromSnapshots(doc);
    }).toList();
  }

  Future<Client> getClient(String clientId) {
    return firestoreReference
        .doc(clientId)
        .get()
        .then((DocumentSnapshot doc) => Client.fromSnapshots(doc));
  }

  Future<void> editClient(String clientId, Client client) {
    return firestoreReference
        .doc(clientId)
        .update(client.toMap())
        .then((documentReference) {
      print("La mise à jour s'est bien passé");
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> deleteClient(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
    // clearForm();
  }

  Future<void> supprimerClient(String idClient) async {
    firestoreReference.doc(idClient).delete();
    print('Danger, le client a été supprimer');
  }

  Future<String> getUserAvatarUrl(String _userId) async {
    String _imageSeach = _userId + '_avatar.png';
    print('hééé nom concatené:');
    print(_imageSeach);

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('avatars')
        .child('${_imageSeach}');

    var url = await ref.getDownloadURL().whenComplete(() => null);

    Clipboard.setData(ClipboardData(
      text: url,
    ));

    print('Yaooo mon url:');
    print(url);
    return url;
  }

  Future<void> insertDataClient(Client client) async {
    await firestoreReference
        .add(client.toMap())
        .then((DocumentReference document) {
      print(document.id);
      print("Le client a bien été enregistré. Merci");
    }).catchError((e) {
      print(e);
      print(
          "Une erreur s'est produite lors de l'enregistrement du client. Désolé");
    });
  }

  Future<String> uploadFile(File _image) async {
    Reference ref = FirebaseStorage.instance.ref();

    TaskSnapshot addImg = await ref.child("images/avatars").putFile(_image);
    print("L'image a été jouter à Firebase Storage");

    if (addImg.state == TaskState.success) {
      final String downloadUrl = await addImg.ref.getDownloadURL();

      print("L'url de l'image ajouter est:");
      print(downloadUrl);

      return downloadUrl;
    }
  }

//
// Future uploadToFirebase() async {
//   final CollectionReference users =
//   _firebaseFirestore.collection("Companies");
//   final String uid = _firebaseAuth.currentUser.uid;
//
//   String url = await uploadFile(
//       _image); // this will upload the file and store url in the variable 'url'
//   await users.doc(uid).update({'url': url});
//   final result = await users.doc(uid).get();
//   return result.data()["url"];
// }
//
//

}
