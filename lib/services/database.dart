import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userDataCollection =
      Firestore.instance.collection('userData');

  Future updateUserData(
      String name, String surname, String email, double balance) async {
    return await userDataCollection.document(uid).setData({
      'Name': name,
      'Surname': surname,
      'Email': email,
      'Balance': balance,
    });
  }
}
