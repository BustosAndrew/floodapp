import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flood/UI/homescreen.dart';
import 'package:flood/UI/login.dart';
import 'package:get/get.dart';

class AuthRepo extends GetxController {
  AuthRepo() {
    print('AuthenticationRepository instance created');
  }

  static AuthRepo get instance => Get.find();

  //varibales
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) async {
    // logout();
    print(user);
    if (user == null) {
      Get.offAll(() => const LoginForm());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password, int? household, String? language) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Now we will immediately update Firestore
      await createUserDocument(userCredential.user!.uid, household, language);

      // And then we will explicitly call _setInitialScreen
      _setInitialScreen(userCredential.user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('FIREBASE AUTH EXCEPTION - ${e.message}');
      throw Exception('Error creating user');
    }
  }

  Future<void> createUserDocument(
      String userId, int? household, String? language) async {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Begin a batch
      WriteBatch batch = FirebaseFirestore.instance.batch();

      batch.set(userDocRef, {
        'householdSize': household ?? 1,
        'language': language ?? 'English',
        'water': 0,
        'food': 0,
        'energy': 0,
      });

      // Commit the batch
      await batch.commit();
    } catch (e) {
      print("Error creating user document: $e");
    }
  }

  Future<UserCredential> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
