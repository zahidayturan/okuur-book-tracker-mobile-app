import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';


class FirebaseGoogleOperation{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;


    final bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? true;

    if (isNewUser) {
      print('User is signing in for the first time.');
      return true;
    } else {
      print('User has signed in before.');
      //check firestore info
      String userState = await FirebaseAuthOperation().checkUserInfoInFirestore();
      if(userState == "no"){
        return true;
      }
      return false;
    }
  }


  Future<void> signOutGoogle() async {
    if (_auth.currentUser != null) {
      try {
        await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
        print("googledan çıkıldı");
      } catch (e) {
        print("google hata");
        print(e.toString());
      }
    }
  }

  Future<void> disconnectGoogle() async {
      try {
        await _googleSignIn.disconnect();
      } catch (e) {
        print("google hata 1");
        print(e.toString());
      }
  }

  Future<DateTime?> getAccountCreationDate() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final creationTime = user.metadata.creationTime;
      return creationTime;
    }
    return null;
  }

  Future<void> deleteAccountForGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
      }
      print("Kullanıcı hesabı başarıyla silindi.");
    } catch (e) {
      print("Hesap silinirken bir hata oluştu: $e");
    }
  }

}
