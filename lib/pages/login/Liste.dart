import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashiontailor/models/user.dart';
import 'package:flutter/material.dart';

class Liste extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Utilisateurs"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('User').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Il y a des erreurs');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return !snapshot.hasData
                ? Text('PLease Wait')
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot users = snapshot.data.docs[index];
                      print('cest quoi le probleme 3');
                      return Text(users['email'] +
                          'fifa ' +
                          users['username'] +
                          ' ' +
                          users['password']);
                    },
                  );
          }
        },
      ),
    );
  }
}
