import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:realtime_communication_app/features/authentication/models/user.dart';

import '../../models/response.dart';

class UserProvider extends ChangeNotifier {
  String _fcmToken = "";
  String get fcmToken => _fcmToken;
  set fcmToken(String? token) {
    _fcmToken = token ?? "";
    notifyListeners();
  }

  String userCollection = "users";

  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  List<User> _users = [];
  List<User> get users => _users;
  set users(List<User> newUsers) {
    _users = newUsers;
    notifyListeners();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Response?> addUser({required User user}) async {
    this.user = user;

    if (await isExists(user.id!)) {
      return null;
    }

    final CollectionReference collection =
        _firestore.collection(userCollection);
    Response response = Response();
    DocumentReference documentReferencer = collection.doc();

    Map<String, dynamic> data = user.toJson();

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  Future<bool> isExists(String id) async {
    QuerySnapshot<Map<String, dynamic>> document = await _firestore
        .collection(userCollection)
        .limit(1)
        .where('id', isEqualTo: id)
        .get();
    List docs = document.docs;
    if (docs.isEmpty) {
      return false;
    }
    return true;
  }

  Future getUsers() async {
    List<User> users = [];
    QuerySnapshot document = await _firestore.collection(userCollection).get();
    List<QueryDocumentSnapshot<Object?>> docs = document.docs;
    if (docs.isEmpty) {
      return;
    }
    for (QueryDocumentSnapshot<Object?> doc in docs) {
      Map<String, dynamic> data = {
        'id': doc.get('id'),
        'fcm': doc.get('fcm'),
        'name': doc.get('name'),
        'profile_picture': doc.get('profile_picture'),
        'email': doc.get('email'),
      };
      User user = User.fromJson(data);
      if (user.email != this.user!.email) {
        users.add(user);
      }
    }
    this.users = users;
  }
}
