
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/commande.dart';


class Cloud_Service_Commande {

  CollectionReference firestoreReference = FirebaseFirestore.instance.collection('Commande');


  Stream<QuerySnapshot> chargerToutLesCommandes() {
    return firestoreReference.orderBy('datecommande', descending: true)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot> chargerLesCommandeParCouturier(String idCouturier) {
    return firestoreReference.where('idcouturier_c', isEqualTo: idCouturier)
        .orderBy('datecommande', descending: false)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot> chargerLesCommandeParFiltrerCouturier(String idCouturier, String recherche) {
    return firestoreReference.where('idcouturier_c', isEqualTo: idCouturier)
        .where('intitule', isGreaterThanOrEqualTo: recherche)
        .limit(20)
        .snapshots();
  }

  List<Commande> getAllCommandesFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Commande.fromSnapshots(doc);
    }).toList();
  }


  Future<Commande> getCommande(String commandeId) {
    return firestoreReference.doc(commandeId)
        .get()
        .then((DocumentSnapshot doc) => Commande.fromSnapshots(doc));
  }


  Future<void> editCommande(String commandeId, Commande commande) {
    return firestoreReference.doc(commandeId)
        .update(commande.toMap())
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> editCommandeDateCommande(String commandeId, String dateCommande) {
    return firestoreReference.doc(commandeId)
        .update({"datecommande":dateCommande})
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> editCommandeDateLivraison(String commandeId, String dateLivraison) {
    return firestoreReference.doc(commandeId)
        .update({"datelivraison":dateLivraison})
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }


  Future<void> deleteCommande(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
  }


  Future<void> supprimerCommande(String idCommande) async {
    firestoreReference.doc(idCommande).delete();
    print('Danger, la Commande a été supprimer');
  }



  Future<String> insertDataCommande(Commande commande) async
  {
    await firestoreReference.add(commande.toMap())
        .then((DocumentReference document) {
      print(document.id);
      return document.id;
    }).catchError((e) {
      print(e);
    });
  }

  Future<int> nombreTotalactuelleCommande() async
  {
    int nbre=0;
     nbre= await firestoreReference.snapshots().length.whenComplete(() => null);
     print(nbre);
    return nbre;
  }




}