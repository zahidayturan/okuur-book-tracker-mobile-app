import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseGoogleOperation{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    return user;
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

}
