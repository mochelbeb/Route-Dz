import 'dart:convert';

import 'package:RouteDz/utils/packs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<UserCredential?> loginWithEmail(String email, String password) async {
  try {
    UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if(user != null){
      Get.offAll(MyHomePage());
    }
    return user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found'){
      print("user not found");
    }
    else if (e.code == "wrong-password"){
      Get.defaultDialog(
        content: Text("Email or password wrong !"),
        cancel: TextButton(onPressed: (){Get.back();}, child: Text("Try Again"))
      );
    }
  }
}

Future<UserCredential?> SignupWithInfos(String username, String email, String password) async{
  try{
    UserCredential _newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if(_newUser != null){
        await _newUser.user!.updateDisplayName(username);
        final collectionRef = _firestore.collection("Users");
        final documentRef = collectionRef.doc();

          var bytes = utf8.encode(password);
          var passwordHash = sha1.convert(bytes);

        await documentRef.set({
          'email' : email,
          'username' : username,
          'password' : passwordHash.toString()
        });

        Get.defaultDialog(
          title: "Inscription Complète",
          content: Text("Compte ajouté avec succès."),
          actions: [
            TextButton(onPressed: (){Get.back();Get.back();}, child: Text("OK")),
          ]
        );

    }
    return _newUser;
  } on FirebaseAuthException catch(e){
    print(e);
  }
}

void SignOut()async{
  try{
    await _auth.signOut();
    if(_auth.currentUser == null){
      Get.offAll(LoginPage());
    }
  } catch(e){
    print(e);
  }
}

