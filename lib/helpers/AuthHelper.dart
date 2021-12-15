import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AuthHelper{
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<bool> signUp(String email,String password) async{
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print( await userCredential.user.getIdToken());
      print( userCredential.user.uid);
      return true;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('weakPass'.tr());
      } else if (e.code == 'email-already-in-use') {
        showToast('existEmail'.tr());
      }
      else if (e.code == 'invalid-email') {
        showToast('invalidEmail'.tr());
      }
      return false;
    } catch (e) {
      showToast(e.toString());
      return false;
    }
  }
  Future<bool> signIn(String email,String password) async{
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('noUser'.tr());
        return false;
      } else if (e.code == 'wrong-password') {
        showToast('wrongPassword'.tr());
        return false;
      }
      else if (e.code == 'invalid-email') {
        showToast('invalidEmail'.tr());
        return false;
      }
    }on Exception catch (e) {
      showToast(e.toString());
      return false;
    }

  }
  User getCurrentUser(){
    return firebaseAuth.currentUser;
  }
  logout() async{
    await firebaseAuth.signOut();
  }
  /*bool isVerifiedEmail(){
    return firebaseAuth.currentUser.emailVerified;
  }*/
  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
    );
  }
}