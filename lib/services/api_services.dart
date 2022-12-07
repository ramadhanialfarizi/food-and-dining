import 'dart:convert';
import 'dart:developer';

import 'package:admin_aplication/model/food_model.dart';
import 'package:dio/dio.dart';

class APIservices {
  Future<List<FoodModel>> getAllFood() async {
    const url = 'https://yummly2.p.rapidapi.com/feeds/list';
    //const urlTwo = 'https://www.themealdb.com/api/json/v1/1/search.php?f=a';

    try {
      // Dio().options.headers['X-RapidAPI-Key'] =
      //     "539f6f9e14mshd1093a6b2b5bb84p1ecad2jsndc5cb2e82e92";
      // Dio().options.headers['X-RapidAPI-Host'] = "yummly2.p.rapidapi.com";
      // Dio().options.headers['useQueryString'] = true;
      final response = await Dio().get(
        url,
        queryParameters: {
          'limit': "24",
          'start': "0",
        },
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                "539f6f9e14mshd1093a6b2b5bb84p1ecad2jsndc5cb2e82e92",
            'X-RapidAPI-Host': "yummly2.p.rapidapi.com",
          },
        ),
      );

      // final response = await Dio()
      //     .get('https://www.themealdb.com/api/json/v1/1/categories.php');

      log(response.data.toString());

      if (response.statusCode == 200) {
        List<dynamic> foodData = jsonDecode(response.data)['feed'];

        // final Map<String, dynamic> foodData =
        //     jsonDecode(response.data)['categories'];

        List<FoodModel> foodList = [];

        for (int getData = 0; getData < foodData.length; getData++) {
          foodList.add(FoodModel.fromJson(foodData[getData]));
        }
        return foodList;
      } else {
        throw Exception('failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
