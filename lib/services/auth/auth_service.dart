import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Firebase Auth ve Firestore instance'ları
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Geçerli kullanıcıyı döndürür
  User? get currentUser => _auth.currentUser;

//Geçerli kullanıcı adını döndürür
  Future<String?> getUserName() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("Kullanıcı oturum açmamış.");
      }
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      return userDoc.get('username');
    } catch (e) {
      print("Kullanıcı adı alınamadı: $e");
      return null;
    }
  }

  // Email ve şifre ile giriş yapma metodu
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Firestore'da kullanıcı bilgilerini güncelleme/ekleme (merge ile)
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("Bu e-posta ile kayıtlı kullanıcı bulunamadı.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Hatalı şifre girdiniz.");
      } else {
        throw Exception("Giriş sırasında bir hata oluştu: ${e.message}");
      }
    } catch (e) {
      throw Exception("Beklenmeyen bir hata oluştu.");
    }
  }

  // Email ve şifre ile kayıt olma metodu
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
        "username": username
      }, SetOptions(merge: true));

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Google ile kayıt olma metodu
  Future<UserCredential> registerWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception("Google hesabı seçilmedi.");
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Kullanıcı Firestore'da kayıtlı değilse ekle
      DocumentSnapshot userDoc = await _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        await _firestore.collection("Users").doc(userCredential.user!.uid).set({
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
          "displayName": userCredential.user!.displayName,
          "photoURL": userCredential.user!.photoURL,
        });
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Google ile giriş yapma metodu
  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception("Google hesabı seçilmedi.");
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  // Parola sıfırlama emaili gönderme metodu
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Kullanıcıyı çıkış yaptıran metot
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
