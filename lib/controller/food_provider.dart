import 'package:admin_aplication/model/food_model.dart';
import 'package:admin_aplication/services/api_services.dart';
import 'package:flutter/material.dart';

enum FoodProviderState {
  none,
  loading,
  error,
}

class FoodProvider extends ChangeNotifier {
  FoodProviderState _state = FoodProviderState.none;
  FoodProviderState get state => _state;

  final APIservices apiServices = APIservices();
  List<FoodModel> foodData = <FoodModel>[];

  void changeState(FoodProviderState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void getAllFood() async {
    changeState(FoodProviderState.loading);

    try {
      foodData = await apiServices.getAllFood();
      notifyListeners();

      changeState(FoodProviderState.none);
    } on Exception catch (e) {
      //log(e.toString());
      changeState(FoodProviderState.error);
    }
  }
}
