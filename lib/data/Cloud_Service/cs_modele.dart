
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/modele.dart';


class Cloud_Service_Modele {

  CollectionReference firestoreReference = FirebaseFirestore.instance.collection('Modele');


  Stream<QuerySnapshot> chargerToutLesModelesDuCouturier(String idCouturier) {
    return firestoreReference.orderBy('nommodele', descending: true)
        .where("idcouturier_c", isEqualTo: idCouturier)
        .limit(20)
        .snapshots();
  }


  Stream<QuerySnapshot> chargerToutLesModeles() {
    return firestoreReference.orderBy('nommodele', descending: true)
        .limit(20)
        .snapshots();
  }
  Stream<QuerySnapshot> chargerToutLesModelesAleatoire() {
    return firestoreReference.orderBy('nommodele', descending: true)
        .limit(20)
        .snapshots();
  }


  List<Modele> getListeForAllModeles(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Modele.fromSnapshots(doc);
    }).toList();
  }

  List<Modele> getListeForAllModelesCatalogue(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Modele.fromSnapshots(doc);
    }).toList();
  }

  List<Modele> getListeForAllModelesFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Modele.fromSnapshots(doc);
    }).toList();
  }


  Future<Modele> getModele(String modeleId) {
    return firestoreReference.doc(modeleId)
        .get()
        .then((DocumentSnapshot doc) => Modele.fromSnapshots(doc));
  }


  Future<void> editModele(String modeleId, Modele modele) {
    return firestoreReference.doc(modeleId)
        .update(modele.toMap())
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }


  Future<void> deleteModele(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
    // clearForm();
  }


  Future<void> insertDataModele(Modele modele) async
  {
    await firestoreReference.add(modele.toMap())
        .then((DocumentReference document) {
      print(document.id);
      return document.id;
    }).catchError((e) {
      print(e);
    });
  }


}