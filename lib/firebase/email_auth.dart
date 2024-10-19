import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  createUser(String user, String email, String password) async{
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      credentials.user!.sendEmailVerification();
    } catch (e) {
      print('Error al crear el usuario: ${e}');
    }
  }

  Future<bool> validateUser(String email, String password) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      if(credentials.user!.emailVerified){
        return true;
      }
    } catch (e) {
      print('Error al hacer login: ${e}');
    }
    return false;
  }
}