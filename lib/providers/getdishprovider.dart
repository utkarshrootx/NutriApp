import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nutriapp/service/getseletctedword.dart';

import '../model/getdishesmodel.dart';
import '../model/menumodel.dart';
import '../service/getdishes.dart';
import '../service/menuservice.dart';

class GetDishProvider extends ChangeNotifier {
  dishesModel getdishes = dishesModel();
  List<Dishes>? dishList = [];
  TextEditingController diseaseController = TextEditingController();
  TextEditingController dishNameController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<Dishes>? selecteddish;
  List<dynamic> array = [];
  MenuModal menudata = MenuModal();
  String result = "";
  String wordlast = '';
  List<String> keyword = [];
  int cartNumber = 0;
  List<dynamic> selectedmenuItem = [];
  List<dynamic> orderlist = [];
  num totaleamount = 0;

  void getDish() async {
    try {
      getdishes = await GetDishesservice().getdishes(diseaseController.text);
      dishList = getdishes.dishes;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void getDishfromvoice(String Lastword) async {
    try {
      getdishes = await GetDishesservice().getdishes(wordlast);
      dishList = getdishes.dishes;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void selectedList(String label_data) {
    for (var i in dishList!) {
      if (i.lable == label_data) {
        selecteddish = [i];
      }
    }
    notifyListeners();
  }

  void clearfunction() {
    diseaseController.clear();
    notifyListeners();
  }

  void getLastword(word) {
    wordlast = word;
    notifyListeners();
  }

  void selectedWord(String word) async {
    try {
      getdishes = await GetDishesservice().getdishes(word);
      var response = await GetDishesservice().getkeyword(word);
      print("response12$response");
      for (var i in response['keywords']!) {
        print("word45$i");
        keyword.add(i);
      }
      dishList = getdishes.dishes;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void getMenu() async {
    try {
      menudata = await GetMenusservice().getMenu();
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void modifydish(List<dynamic> selecteddish) {
    print(selecteddish[0].dishName);
    dishNameController.text = selecteddish[0].dishName;
    ingredientsController.text = selecteddish[0].ingredients;
    caloriesController.text = selecteddish[0].calories.toString();
    priceController.text = selecteddish[0].price.toString();
    notifyListeners();
  }

  Future<bool> submitMenu() async {
    var response = await GetMenusservice().submitMenu(
        dishNameController.text,
        ingredientsController.text,
        double.parse(caloriesController.text),
        int.parse(priceController.text));
    print('response234$response');
    return true;
  }

  Future<bool> deleteDish(int dish) async {
    var response = await GetMenusservice().deleteDish(dish);
    return true;
  }

  void removefilter(index) {
    keyword.remove(index);
    notifyListeners();
    String remainingText = keyword.join(' ');
    getDishfromvoice(remainingText);
  }

  void addDishtocart() {
    cartNumber = cartNumber + 1;
    notifyListeners();
  }

  void subtractDish() {
    cartNumber = cartNumber - 1;
    notifyListeners();
  }

  void clear() {
    dishNameController.clear();
    ingredientsController.clear();
    caloriesController.clear();
    priceController.clear();
    notifyListeners();
  }

  void addtoorder(List<dynamic> selecteditemtocart) {
    orderlist.add(selecteditemtocart);
    for (int index = 0; index < orderlist.length; index++) {
      totaleamount += orderlist[index][0][0].price!;
    }

    notifyListeners();
  }
}
