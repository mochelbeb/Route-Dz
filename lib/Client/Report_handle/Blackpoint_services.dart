import 'package:RouteDz/components/Blackpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/packs.dart';

class FirestoreService{
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  // $$ Ajouter un point Noir
  
  static Future<void> addBN(BlackPoint blackPoint) async {
    final collectionRef = _firestore.collection("Blackpoints");
    final documentRef = collectionRef.doc();
    
    await documentRef.set({
      'coordinate' : GeoPoint(blackPoint.coordinate.latitude, blackPoint.coordinate.longitude),
      'date' : Timestamp.fromDate(blackPoint.date),
      'type' : blackPoint.type,
      'pictures' : blackPoint.pictures,
      'description' : blackPoint.description,
      'comments': blackPoint.comments,
      'etat' : blackPoint.etat,
    });

  }

  // $$ Get data (black points) from database


  static Future<List<BlackPoint>> getBlackPoints() async {
    final collectionRef = _firestore.collection("Blackpoints");
    final snapshot = await collectionRef.get();
    final blackPoints = snapshot.docs.map((doc) {
      final data = doc.data();
      final coordinate = data['coordinate'];
      final date = (data['date'] as Timestamp).toDate();
      final type = data['type'];
      final pictures = List<String>.from(data['pictures']);
      final comments = List<String>.from(data['comments']);
      final description = data['description'];
      final etat = data['etat'];

      return BlackPoint(
        id: doc.id,
        coordinate: LatLng(coordinate.latitude, coordinate.longitude),
        date: date,
        type: type,
        pictures: pictures,
        comments: comments,
        etat: etat, 
        description: description,
      );
    }).toList();

  // Return the list of BlackPoint objects
  return blackPoints;
  }  
}
