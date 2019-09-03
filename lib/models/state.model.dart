import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  FirebaseUser loggedInUser;

  StateModel() {
    getUserSession();
  }

  void getUserSession() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser() != null) {
      FirebaseUser user = await _auth.currentUser();
      loggedInUser = user;
      notifyListeners();
    }
  }

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void setUser(FirebaseUser user) {
    loggedInUser = user;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}