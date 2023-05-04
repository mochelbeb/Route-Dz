import 'package:RouteDz/utils/packs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth _auth = FirebaseAuth.instance;


Future<UserCredential?> loginWithEmail(String email, String password) async {
  try {
    UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if(user != null){
      Get.to(MyHomePage());
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
      Get.defaultDialog(
        content: Text("Sign-Up success !"),
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
    print('current user is : ${_auth.currentUser}');
    if(_auth.currentUser == null){
      Get.to(LoginPage());
    }
  } catch(e){
    print(e);
  }
}

