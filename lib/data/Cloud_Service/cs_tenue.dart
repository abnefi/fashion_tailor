
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/tenue.dart';


class Cloud_Service_Tenue {

  CollectionReference firestoreReference = FirebaseFirestore.instance.collection('Tenue');


  Stream<QuerySnapshot> chargerToutLesTenue() {
    return firestoreReference.orderBy('descriptiontenue', descending: true)
        .limit(20)
        .snapshots();
  }


  Stream<QuerySnapshot> chargerLesTenuesParCommande(String idCommande) {
    return firestoreReference.where('idcommande_c', isEqualTo: idCommande)
        .limit(20)
        .snapshots();
  }


  List<Tenue> getAllTenuesFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Tenue.fromSnapshots(doc);
    }).toList();
  }


  Future<Tenue> getTenue(String clientId) {
    return firestoreReference.doc(clientId)
        .get()
        .then((DocumentSnapshot doc) => Tenue.fromSnapshots(doc));
  }


  Future<void> editTenue(String clientId, Tenue client) {
    return firestoreReference.doc(clientId)
        .update(client.toMap())
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }


  Future<void> deleteTenue(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
    // clearForm();
  }

  Future<void> supprimerTenue(String idTenue) async {
    firestoreReference.doc(idTenue).delete();
    print('Danger, le Tenue a été supprimer');
  }



  Future<String> insertDataTenue(Tenue tenue) async
  {
    await firestoreReference.add(tenue.toMap())
        .then((DocumentReference document) {
      print(document.id);
      return document.id;
    }).catchError((e) {
      print(e);
    });
  }




}