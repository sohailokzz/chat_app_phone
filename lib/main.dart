import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upwork_demo/homepage.dart';
import 'package:upwork_demo/models/firebase_helper.dart';
import 'package:upwork_demo/models/user_model.dart';
import 'package:upwork_demo/phone.dart';
import 'package:uuid/uuid.dart';

import 'firebase_options.dart';

var uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    UserModel? thisUserModel = await FirebaseHelper.getUserModel(
      currentUser.uid,
    );
    if (thisUserModel != null) {
      runApp(
        MyAppLoggedIn(
          userModel: thisUserModel,
          firebaseUser: currentUser,
        ),
      );
    } else {
      runApp(
        const MyApp(),
      );
    }
  } else {
    runApp(
      const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPhone(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyAppLoggedIn({
    super.key,
    required this.userModel,
    required this.firebaseUser,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(
        firebaseUser: firebaseUser,
        userModel: userModel,
      ),
    );
  }
}
