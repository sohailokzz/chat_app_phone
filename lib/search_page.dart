import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upwork_demo/models/user_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: "Full Name",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton(
            onPressed: () {
              setState(() {});
            },
            color: Theme.of(context).colorScheme.secondary,
            child: const Text("Search"),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("fullName", isEqualTo: searchController.text)
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;

                  if (datasnapshot.docs.isNotEmpty) {
                    Map<String, dynamic> userMap =
                        datasnapshot.docs[0].data() as Map<String, dynamic>;

                    UserModel searchUser = UserModel.fromMap(userMap);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        backgroundImage: NetworkImage(
                          searchUser.profileImage!,
                        ),
                      ),
                      title: Text(
                        searchUser.fullName!,
                      ),
                      subtitle: Text(
                        searchUser.phoneNumber!,
                      ),
                    );
                  } else {
                    return const Text('No result found');
                  }
                } else if (snapshot.hasError) {
                  return const Text("An error occured!");
                } else {
                  return const Text("No results found!");
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
          )
        ],
      ),
    );
  }
}
