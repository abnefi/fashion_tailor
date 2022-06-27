import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/user.dart';
import 'package:flutter/material.dart';

class Cloud_Service_User {
  CollectionReference firestoreReference =
      FirebaseFirestore.instance.collection('User');

  Stream<QuerySnapshot> chargerToutLesUser() {
    return firestoreReference
        .orderBy('username', descending: true)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot> chargerUserExiste(User user) {
    Query query = firestoreReference;

    if (user != null) {
      query = query
          .where("email", isEqualTo: user.email)
          .where("username", isEqualTo: user.username)
          .where("password", isEqualTo: user.password);
    }
    return query
        //.orderBy(filter.sort ?? 'avgRating', descending: true)
        .limit(1)
        .snapshots();
  }

  List<User> getAllUsersFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return User.fromSnapshot(doc);
    }).toList();
  }

  Future<User> getUserByID(String userId) {
    return firestoreReference
        .doc(userId)
        .get()
        .then((DocumentSnapshot doc) => User.fromSnapshot(doc));
  }

  List<User> verifieExistanceUser(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return User.fromSnapshot(doc);
    }).toList();
  }

  Future<User> verifieExistanceUserByID(String docID) async {
    User existUser = null;
    try {
      await firestoreReference.doc(docID).get().then((doc) {
        if (doc.exists)
          existUser = User.fromSnapshot(doc);
        else
          existUser = null;
      });
      return existUser;
    } catch (e) {
      return existUser;
    }
  }

  Future<User> getUserByUser(User user) async {
    print('je suis dans le getUserByUser');
    User existUser = null;
    User existUserD = null;
    try {
      await firestoreReference
          .where("username", isEqualTo: user.username)
          .where("password", isEqualTo: user.password)
          .get()
          .then((QuerySnapshot listDocs) {
        if (listDocs.docs.isNotEmpty)
        {
          var dataUser=listDocs.docs[0];
          print('voici le user correspond dans le getUserByUser : ');
          print(dataUser);
          existUserD = new User(dataUser['id'],dataUser.id,dataUser['email'],dataUser['username'],dataUser['password'],dataUser['flaglogged']);
          print('Les données user actif concatené:');
          print(dataUser.id);
          print(dataUser['id']);
          print(dataUser['idFireStore']);
          print(dataUser['email']);
          print(dataUser['username']);
          print(dataUser['password']);
          print(dataUser['flaglogged']);
          print('Son toString :');
          print(existUserD.toString());

          print('Les données user actif du fromSnapshot:');
          //existUser = User.fromSnapshotQ(dataUser.id,dataUser.data());

          existUser = existUserD;
        }
        else
          {
          print('Aucun user ne correspond dans le getUserByUser !!!');
          existUser = null;
          }
      });
      return existUser;
    } catch (e) {
      return existUser;
    }
  }

  Future<bool> ifUserExiste(User user) async {
    bool existUser = false;
    try {
      await firestoreReference
          .where("username", isEqualTo: user.username)
          .where("password", isEqualTo: user.password)
          .get()
          .then((QuerySnapshot listDocs) {
        if (listDocs.docs.isNotEmpty)
        {
          //User user = document.toObject(User.class); pour les DocumentSnapshot
          print('Un user correspond à la recherche : ');
          print((listDocs.docs[0].data()));
          existUser = true;
        }
        else
          {
            print('Aucun user ne correspond à la recherche !!!');
            existUser = false;
          }
      });
      return existUser;
    } catch (e) {
      return existUser;
    }
  }

  Future<void> editUser(String userId, User user) {
    return firestoreReference
        .doc(userId)
        .update(user.toMap())
        .then((documentReference) {
      print('documentReference');
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> deleteUser(DocumentSnapshot doc) async {
    firestoreReference.doc(doc.id).delete();
    // clearForm();
  }

  Future<int> insertDataUser(User user) async {
    int fait=0;
    await firestoreReference
        .add(user.toMap())
        .then((DocumentReference document) {
      print(document.id);
      fait=1;
    }).catchError((e) {
      print(e);
    });
    return fait;
  }

}
