import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/packs.dart';

class BlackPoint {
  final String? id;
  final LatLng coordinate;
  final DateTime date;
  final String type;
  final List<String> pictures;
  final String description;
  final List<String> comments;
  final String etat;

  BlackPoint({
    this.id,
    required this.coordinate,
    required this.date,
    required this.type,
    required this.pictures,
    required this.description,
    required this.comments,
    required this.etat,
  });

  Map<String, dynamic> toMap() {
    return {
      'coordinate': GeoPoint(coordinate.latitude, coordinate.longitude),
      'date': Timestamp.fromDate(date),
      'type': type,
      'pictures': pictures,
      'desciption': description,
      'comments': comments,
      'state': etat,
    };
  }
  factory BlackPoint.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BlackPoint(
      id: doc.id,
      coordinate: data['coordinate'],
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'],
      pictures: List<String>.from(data['pictures']),
      comments: data['comments'],
      etat: data['etat'], 
      description: data['description'],
    );
  }


  

  static double calculateSymbolSize(double zoom) {
  if (zoom <= 10) {
    return 0;
  } else if (zoom <= 12) {
    return 0.05;
  } else if (zoom <= 14) {
    return 0.15;
  } else if (zoom <= 16) {
    return 0.25;
  } else {
    return 0.3;
  }
}
}