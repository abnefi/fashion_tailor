import 'package:fashiontailor/models/modele.dart';
import 'package:fashiontailor/pages/Clients/DetailsClients.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

class AnimationSliderAccueil extends StatefulWidget {
  createState() => AnimationSliderAccueilState();
}

class AnimationSliderAccueilState extends State<AnimationSliderAccueil> {

  final PageController ctrl = PageController(viewportFraction: 0.8);

  CollectionReference db = FirebaseFirestore.instance.collection('Modele');

  Stream slides;

  
  String activeTag = 'Favorites';

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;


  @override
  void initState() {
    _queryDb();
    
    // Set state when page changes
    ctrl.addListener(() { 
      int next = ctrl.page.round();

      if(currentPage != next) { 
        setState(() {
          currentPage = next;
        });
      } 
    });
  }

  @override
  Widget build(BuildContext context) { 
      return StreamBuilder(
          stream: slides,
          initialData: [],
          builder: (context, snapshot) {

            return PageView.builder(
          
              controller: ctrl,
              itemCount: snapshot.data.docs.length + 1,
              itemBuilder: (context, int currentIdx)
              {
              if (currentIdx == 0) {
                return _buildTagPage();
              } else if (snapshot.data.docs.length >= currentIdx) {
                // Active page
                bool active = currentIdx == currentPage;
                return _buildStoryPage(snapshot.data.docs[currentIdx - 1], active);
              }

              }

          );
        }
    );
  }

  Stream _queryDb({ String tag ='Favorites' }) {
    
    // Make a Query
    Query query = db.where('genre', isEqualTo: tag);

    // Map the documents to the data payload
    slides = query.snapshots();

    // Update the active tag
    setState(() {
      activeTag = tag;
    });

  }


  // Builder Functions

  _buildStoryPage(DocumentSnapshot data, bool active) {
     // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    Modele modele = Modele.fromSnapshots(data);
    print(modele.imgmodele);

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(modele.imgmodele,scale: 2),

        ),

        boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]
      ),
      child: Center(
          child: Text(modele.nommodele, style: TextStyle(fontSize: 12, color: Colors.white))
        )
    );
  }


  _buildTagPage() {
    return Container(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
    
        children: [
          Text('Vos Modèles', style: TextStyle(fontSize: 35,color: Colors.white, fontWeight: FontWeight.bold),),
          Text('ECouture', style: TextStyle( fontSize: 30,color: Colors.white54,fontWeight:FontWeight.normal)),
          _buildButton('Favorites'),
          _buildButton('Happy'),
          _buildButton('Sad')
        ],
      )
    );
  }

  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.purple : Colors.white;
    var mTag =capitalize(tag);
    return FlatButton(color: color, child: Text('# $mTag'), onPressed: () => _queryDb(tag: tag));
  }
  
}