import 'package:admin_aplication/controller/food_provider.dart';
import 'package:admin_aplication/pages/widget/favorite_list.dart';
import 'package:admin_aplication/pages/widget/food_list.dart';
import 'package:admin_aplication/pages/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final prov = Provider.of<FoodProvider>(context, listen: false);
      prov.getAllFood();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'FoodAndDining Apps',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          // ignore: preferconst const const _const_constructors
          backgroundColor: const Color.fromARGB(194, 249, 7, 108),
          bottom: TabBar(
            indicatorPadding: const EdgeInsets.only(top: 25),
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: 'FoodList',
              ),
              Tab(
                text: 'Favorite',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FoodListScreen(),
            FavoriteListScreen(),
          ],
        ),
      ),
    );
  }
}
