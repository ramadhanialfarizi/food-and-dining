import 'package:admin_aplication/controller/food_provider.dart';
import 'package:admin_aplication/model/food_model.dart';
import 'package:admin_aplication/pages/widget/fail_load_screen.dart';
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
  @override
  Widget build(BuildContext context) {
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
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
                            provider.foodData[index].images!,
                            fit: BoxFit.fill,
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
                                    provider.foodData[index].name ?? "Makanan",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(194, 249, 7, 108),
                                    ),
                                    label: Text(
                                      'add to favorite',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(194, 249, 7, 108)),
                                    ),
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
