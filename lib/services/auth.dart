import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/services/database.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();
  dynamic usuarioFirebase;

//create user obj based un Firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  /*User _userFromFirebaseUser(FirebaseUser user, String email, String name,
      double balance, String actionToDo) {
    //actionToDo dice si se registra o se logea un usuario

    if (actionToDo == 'registro') {
      usuarioFirebase =
          User(uid: user.uid, name: name, email: email, balance: balance);
    } else if (actionToDo == 'logeo') {
      databaseReference
          .child("Clientes")
          .child("Usuario")
          .child(user.uid)
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        usuarioFirebase = User(
            uid: user.uid,
            name: values["Nombre"],
            email: values["Email"],
            balance: values["Balance"]);
      });
    }
    return usuarioFirebase;
  }*/

  //Acá creo el Stream que voy a escuchar desde el main() ante un cambio en el usuario

  Stream<User> get userStream {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

//Registrar con email y password

  Future registerEmailandPassword(String email, String password, String name,
      String surname, double balance) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //Agrego a FireBase el usuario nuevo
      await DatabaseService(uid: user.uid).createUserData(
          name, surname, email, balance); //Lo creo en Firebase database
      return _userFromFirebaseUser(
          user); //Devuelvo el usuario con formato User, este debería ser el del provider.
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Login email and password

  Future loginEmailandPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
