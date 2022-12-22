import 'package:admin_aplication/controller/food_provider.dart';
import 'package:admin_aplication/model/food_model.dart';
import 'package:admin_aplication/pages/widget/fail_load_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final curentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference admin = firestore
        .collection('admin')
        .doc(curentUser.currentUser!.email)
        .collection('favorite_data');

    return Scaffold(
      body: Consumer<FoodProvider>(
        builder: (BuildContext context, FoodProvider provider, Widget? _) {
          final isLoading = provider.state == FoodProviderState.loading;
          final isError = provider.state == FoodProviderState.error;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromARGB(194, 249, 7, 108),
              ),
            );
          }
          if (isError) {
            return const FailLoadScreen();
          } else {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListView.builder(
                itemCount: provider.foodData.length,
                itemBuilder: (context, index) {
                  String image = provider.foodData[index].images!;
                  String name = provider.foodData[index].name ?? "Makanan";
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(110, 218, 218, 218),
                          blurRadius: 10.0,
                        ),
                      ]),
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          // side: BorderSide(
                          //   color: Colors.greenAccent,
                          // ),
                          borderRadius:
                              BorderRadius.circular(20.0), //<-- SEE HERE
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              image,
                              fit: BoxFit.cover,
                              scale: 2,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Color.fromARGB(194, 249, 7, 108),
                                      ),
                                      label: Text(
                                        'add to favorite',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                194, 249, 7, 108)),
                                      ),
                                      onPressed: () {
                                        admin.add({
                                          'image_food': image,
                                          'name_food': name,
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Add Favorite Successfully'),
                                            duration:
                                                Duration(milliseconds: 800),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
