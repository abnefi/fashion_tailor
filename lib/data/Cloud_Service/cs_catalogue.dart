
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/catalogue.dart';


class Cloud_Service_Catalogue {

  CollectionReference firestoreReference = FirebaseFirestore.instance.collection('Catalogue');


  Stream<QuerySnapshot> chargerToutLesCatalogues() {
    return firestoreReference.orderBy('datepublie', descending: true)
        .limit(20)
        .snapshots();
  }


  List<Catalogue> getAllCataloguesFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Catalogue.fromSnapshot(doc);
    }).toList();
  }


  Future<Catalogue> getCatalogue(String catalogueId) {
    return firestoreReference.doc(catalogueId)
        .get()
        .then((DocumentSnapshot doc) => Catalogue.fromSnapshot(doc));
  }


  Future<void> editCatalogue(String catalogueId, Catalogue catalogue) {
    return firestoreReference.doc(catalogueId)
        .update(catalogue.toMap())
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }


  Future<void> deleteCatalogue(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
    // clearForm();
  }



  Future<void> insertDataCatalogue(Catalogue catalogue) async
  {
    await firestoreReference.add(catalogue.toMap())
        .then((DocumentReference document) {
      print(document.id);
    }).catchError((e) {
      print(e);
    });
  }




}