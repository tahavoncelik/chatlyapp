import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
 // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// sign user in
Future<UserCredential> signInWithEmailandPassword(String email, String password) async {
  try{
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid' : userCredential.user!.uid,
      'email' : email,
    }, SetOptions(merge: true));
    return userCredential;
    //catch errors
  }on FirebaseAuthException catch (e) {
    throw Exception(e.code);
  }
}

// create a new user
  Future<UserCredential> signUpWithEmailandPassword(String email, password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // after creating , create a new document in the users collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      });

      return userCredential;
      //catch errors
    }on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
// sign user out
Future<void> signOut() async {
  return await FirebaseAuth.instance.signOut();
}
}