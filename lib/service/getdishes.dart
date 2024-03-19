


import '../model/getdishesmodel.dart';
import 'baseservice.dart';

class GetDishesservice extends BaseApiService {
  Future<dishesModel> getdishes(String disease) async {
    try {
      final response = await sendRequest('https://api.edamam.com/search?app_id=900da95e&app_key=40698503668e0bb3897581f4766d77f9&q=$disease', method: 'GET');
      return dishesModel.fromJson(response);
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }
}