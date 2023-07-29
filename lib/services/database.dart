import 'package:brew_maate/models/brew.dart';
import 'package:brew_maate/models/user_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  DatabaseService.withoutUID() : uid = '';

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  //brew list from snapshots
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          sugar: doc.get('sugar') ?? '',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugar: snapshot.get('sugar'),
        strength: snapshot.get('strength'));
  }

  //add user data
  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get user_data {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
