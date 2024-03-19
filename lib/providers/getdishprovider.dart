import 'package:flutter/material.dart';
import 'package:nutriapp/service/getseletctedword.dart';

import '../model/getdishesmodel.dart';
import '../service/getdishes.dart';

class GetDishProvider extends ChangeNotifier{
  dishesModel getdishes = dishesModel();
  List<Hits>? dishList = [];
  TextEditingController diseaseController = TextEditingController();
  List<Hits>? selecteddish ;
  List<dynamic> array = [];
  String result = "";

  void getDish() async {
    try {
      getdishes = await GetDishesservice().getdishes(diseaseController.text);
      dishList = getdishes.hits;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  void getDishfromvoice() async {
    try {
      getdishes = await GetDishesservice().getdishes("sugar");
      dishList = getdishes.hits;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // void getvoicedDish() async{
  //     try {
  //     getdishes = await GetDishesservice().getdishes(result);
  //     dishList = getdishes.hits;
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  void selectedList(String label_data){
    for(var i in dishList!){
        if(i.recipe?.label == label_data){
             selecteddish = [i];
        }
    }
    notifyListeners();
  }

  void selectedWord(String word) async {
     var response  = await Getword().getSelectedWord(word);
     print("response$response");   
  diseaseController.text = response['keywords'].join('');
  notifyListeners();
  }
}