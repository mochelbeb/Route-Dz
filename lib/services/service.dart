import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:RouteDz/components/Blackpoint.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class Service {



  static Future<Position> GetCurrentPosition(BuildContext context) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(); 

  }


  static Future<List<String>> getStateCode() async {
    try {
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/Fcmam5/algeria-api/develop/data/WilayaList.json'));
      final data = json.decode(response.body) as List<dynamic>;

      final wilayas = data.map((wilaya) => wilaya['name'] as String).toList();

      return wilayas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> getStateAndProvinceFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String? state = placemark.administrativeArea;
      String? province = placemark.subAdministrativeArea;
      String address = '$province, $state';
      return address;
    } else {
      return 'No address found';
    }
  } catch (e) {
    return 'Error: $e';
  }


  }

  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null){
      File selectedImage = File(pickedImage.path);
      return selectedImage;
    }
    return null;
  }


    static Future<List<File>> pickImageFrom(String input) async {
      List<File> selectedPictures = [];
      final picker = ImagePicker();
      if(input == "camera"){
        final pickedImage = await picker.pickImage(source: ImageSource.camera);
        if (pickedImage != null){
          File selectedImage = File(pickedImage.path);
          selectedPictures.add(selectedImage);
          return selectedPictures;
        }
      } else{
        final pickedImage = await picker.pickMultiImage();
        if (pickedImage != null){
          for(XFile f in pickedImage){
            File selectedImage = File(f.path);
            selectedPictures.add(selectedImage);
          }
          Logger().i(selectedPictures);
          return selectedPictures;
        }
      }
      return selectedPictures;
  }

  static Future<List<File>?> pickMultiImage() async {
    List<File>? selectedPictures;
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if(pickedFiles!= null){
      selectedPictures = [];
    }
    for (XFile f in pickedFiles){
      selectedPictures!.add(File(f.path));
    }
    
    return selectedPictures;
  }



  static Future<String?> uploadPhotoToCloud(String userId , String filePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('user_photos/$userId.jpg');
      final uploadTask = storageRef.putFile(File(filePath));
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading photo: $e');
      return null;
    }
  }

}
