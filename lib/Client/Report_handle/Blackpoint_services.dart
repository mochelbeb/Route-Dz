import 'dart:io';

import 'package:RouteDz/components/Blackpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

import '../../utils/packs.dart';

class FirestoreService{
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  // $$ Ajouter un point Noir
  
  static Future<void> addBN(BlackPoint blackPoint , List<File>? pictures) async {

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
      'ApprouvedBy' : blackPoint.approuvedBy,
    });

    // 2. Upload pictures to Cloud Storage
    if (pictures != null){
      List<String> pictureUrls = await uploadPictures(pictures , documentRef.id);
      await documentRef.update({'pictures' : pictureUrls});
    }
  }

  static Future<void> uplaod(List<File> photos, String docId) async {
    final collectionRef = _firestore.collection("Blackpoints");
    final documentRef = collectionRef.doc(docId);
    if (photos.isNotEmpty){
      Logger().i('Uploading pictures');
      List<String> pictureUrls = await uploadPictures(photos , docId);
      await documentRef.update({'pictures' : pictureUrls});
    }
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
      
      final pictures = data['pictures'] != null ? List<String>.from(data['pictures']) : null;

      final comments = data['comments'] != null ? List<String>.from(data['comments']) : null;
      
      final description = data['description'];

      final etat = data['etat'];

      final approuvedBy = data['ApprouvedBy'] != null ? List<String>.from(data['ApprouvedBy']) : null;

      return BlackPoint(
        id: doc.id,
        coordinate: LatLng(coordinate.latitude, coordinate.longitude),
        date: date,
        type: type,
        pictures: pictures,
        comments: comments,
        etat: etat, 
        description: description,
        approuvedBy: approuvedBy,
      );
    }).toList();

  // Return the list of BlackPoint objects
  print('BlackPoints : $blackPoints');
  return blackPoints;
  }
  
  static Future<List<String>> uploadPictures(List<File> pictures , String docID) async {
    List<String> pictureUrls = [];
    RxInt CompletedPictures = 0.obs;
    RxDouble progress = 0.0.obs;
    int i = 0;
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Obx(() => Container(
              height: 100,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Uploading Pictures.. ${CompletedPictures.value}/${pictures.length}' , style: Styles.subtitle,),
                  SizedBox(height: 16.0),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: progress.value,
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      );


    for (var picture in pictures) {

      // Upload the picture to Cloud Storage
      Reference ref = FirebaseStorage.instance.ref().child('Signals/$docID/$i.jpg');
      UploadTask uploadTask = ref.putFile(picture);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded picture
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Store the download URL in the pictureUrls list
      pictureUrls.add(downloadUrl);
      CompletedPictures.value +=1;
      progress.value = CompletedPictures.value/ pictures.length;
      i+=1;
    }
    return pictureUrls;
  }  


  static BlackPoint? findBlackPointFromSymbol(Symbol symbol, List<BlackPoint> blackPoints) {
  var logger = Logger();
  final symbolId = symbol.data!['id'];
  logger.i("symbol id : $symbolId");
  

  
  // Iterate through the blackPoints list and find the matching BlackPoint
  for (final blackPoint in blackPoints) {
    logger.i("black point id : ${blackPoint.id}");
    if (blackPoint.id as String == symbolId) {
      return blackPoint;
    }
  }
  
  // Return null if no matching BlackPoint is found
  return null;
}

  static void ApprouverBlackPoint(User? currentUser, BlackPoint blackPoint) async {
    String? docID = blackPoint.id;
    final collectionRef = _firestore.collection("Blackpoints");
    final documentRef = collectionRef.doc(docID);

    final documentSnapshot = await documentRef.get();




    List<String>? approuvedList = List.from(documentSnapshot.data()?['ApprouvedBy'] ?? []);
    
    approuvedList.add(currentUser!.uid);

    await documentRef.update({
      'ApprouvedBy' : approuvedList,
    });

  }


  static void addCommentToBlackPoint(BlackPoint blackpoint_current, text) async {
    String? docID = blackpoint_current.id;
    final collectionRef = _firestore.collection("Blackpoints");
    final documentRef = collectionRef.doc(docID);

    final documentSnapshot = await documentRef.get();

    List<String>? comments = List.from(documentSnapshot.data()?['comments'] ?? []);

    comments.add(text);

    documentRef.update({
      'comments' : comments,
    });
  }
}
