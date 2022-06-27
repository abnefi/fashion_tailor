import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/couturier.dart';


class Cloud_Service_Couturier {

  CollectionReference firestoreReference = FirebaseFirestore.instance.collection('Couturier');


  Stream<QuerySnapshot> chargerToutLesCouturiers() {
    return firestoreReference.orderBy('nomcouturier', descending: true)
        .limit(20)
        .snapshots();
  }


  List<Couturier> getAllCouturiersFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Couturier.fromSnapshot(doc);
    }).toList();
  }


  Future<Couturier> getCouturier(String couturierId) {
    return firestoreReference.doc(couturierId)
        .get()
        .then((DocumentSnapshot doc) => Couturier.fromSnapshot(doc));
  }


  Future<void> editCouturier(String couturierId, Couturier couturier) {
    return firestoreReference.doc(couturierId)
        .update(couturier.toMap())
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }


  Future<void> deleteCouturier(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
    // clearForm();
  }



  Future<void> insertDataCouturier(Couturier couturier) async
  {
    await firestoreReference.add(couturier.toMap())
        .then((DocumentReference document) {
      print(document.id);
    }).catchError((e) {
      print(e);
    });
  }




}