import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upwork_demo/chat_view.dart';
import 'package:upwork_demo/data/all_contacts.dart';
import 'package:upwork_demo/models/user_model.dart';
import 'package:upwork_demo/phone.dart';
import 'package:upwork_demo/search_page.dart';

class MyHome extends StatefulWidget {
  const MyHome({
    super.key,
    required this.userModel,
    required this.firebaseUser,
  });

  final UserModel userModel;
  final User firebaseUser;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: const Text(
          'My Home',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return const MyPhone();
                }),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SearchPage(
                  userModel: widget.userModel,
                  firebaseUser: widget.firebaseUser,
                );
              },
            ),
          );
        },
        child: const Icon(
          Icons.search,
        ),
      ),
      body: ListView.builder(
        itemCount: allContacts.length,
        itemBuilder: (context, index) {
          return buildAllContacts(
            context,
            index,
          );
        },
      ),
    );
  }

  Widget buildAllContacts(
    BuildContext context,
    int index,
  ) {
    Map allContactList = allContacts[index];
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatView(
              title: allContactList["title"],
              image: allContactList["image"],
            ),
          ),
        );
      },
      leading: Container(
        height: 52,
        width: 52,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            allContactList["image"],
          ),
        ),
      ),
      title: Text(
        allContactList["title"],
      ),
      subtitle: Text(
        allContactList["message"],
      ),
    );
  }

  Widget allContactDesigns(
    BuildContext context,
    int index,
  ) {
    Map allContactList = allContacts[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: MediaQuery.of(context).size.width,
        height: 280,
        decoration: BoxDecoration(
          color: const Color(0XFFD6F0F5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF00CEE3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                allContactList["title"],
              ),
            ),
            Center(
              child: Image.asset(
                allContactList["image"],
              ),
            )
          ],
        ),
      ),
    );
  }
}
