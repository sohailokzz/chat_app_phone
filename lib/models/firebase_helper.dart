import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upwork_demo/models/user_model.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModel(String uid) async {
    UserModel? userModel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }
}
