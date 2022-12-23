import 'package:admin_aplication/pages/widget/data_empty.dart';
import 'package:admin_aplication/pages/widget/fail_load_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  final curentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> adminStream = FirebaseFirestore.instance
        .collection('admin')
        .doc(curentUser.currentUser!.email)
        .collection('favorite_data')
        .orderBy('name_food')
        .snapshots();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference admin = firestore
        .collection('admin')
        .doc(curentUser.currentUser!.email)
        .collection('favorite_data');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: adminStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      String image = data['image_food'] ?? "image";
                      String name = data['name_food'];

                      return Card(
                        child: ListTile(
                          leading: Image.network(image),
                          title: Text(name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 20.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  // delete Favorite From cloud firestore
                                  admin.doc(document.id).delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Removing from Favorite'),
                                      duration: Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          // title: Text(Contact().contacts[index].name),
                          // subtitle: Text(Contact().contacts[index].phoneNumber),
                        ),
                      );
                    }).toList(),
                  );
                }
                if (snapshot.hasError) {
                  return FailLoadScreen();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                }

                return EmptyDataScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
