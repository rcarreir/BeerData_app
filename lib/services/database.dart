import 'package:firebase_database/firebase_database.dart';
import 'package:tutorial_ninja/models/UserAccount.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/Account.dart';

class DatabaseService {
  //collection reference
  final String uid;
  DatabaseService({this.uid});
  final databaseReference = FirebaseDatabase.instance.reference();

//Creo el usuario en firebase con los datos levantados de la pantalla de registro.
  createUserData(String name, String surname, String email, double balance) {
    databaseReference.child("Clientes").child("Usuario").child(uid).set({
      'Nombre': name,
      'Apellido': surname,
      'Email': email,
      'Saldo': balance,
      'Teléfono': 44444444,
      'Consumo': 0.0,
    });
  }

//Creo un objeto de usuario con el snapshot leido de firebase

  UserAccount userAccountFromSnapshot(DataSnapshot snapshot) {
    return snapshot.value.map((field) {
      return UserAccount(
        name: field.data['Nombre'] ?? '',
        surname: field.data['Apellido'] ?? '',
        balance: field.data['Saldo'] ?? '',
        email: field.data['Email'] ?? '',
        consumption: field.data['Consumo'] ?? '',
        number: field.data['Numero'] ?? '',
      );
    });
  }
}
