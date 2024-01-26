import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      throw Exception("Error signing in :${e.toString()}");
    }
  }

  Future<String> uploadImgeToStorage(String childName, Uint8List file) async {
    Reference ref;
    //we are creating a path here where we are going to store the image
    //the reason we are using  a Uint8List instead of File is to allow both the mobile
    //and web apps work in one same code base

    // String id = const Uuid().v1();
//this referance allows to store diffrent posts of the same user without over writting one with another
    ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // } else {
    //   ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // }

    // the reason we are using putData instead of putFile is b/c the file type is Uint8List
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    // we are using this url to display the uploaded image by taking it's url
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
