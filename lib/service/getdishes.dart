import '../model/getdishesmodel.dart';
import 'baseservice.dart';

class GetDishesservice extends BaseApiService {
  Future<dishesModel> getdishes(String disease) async {
    try {
      var body = {"text": disease};
      final response = await sendRequest(
          'https://aijaz.pythonanywhere.com/audio_dishes',
          method: 'POST',
          body: body);
      return dishesModel.fromJson(response);
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }

  Future<dishesModel> getdishesonsearch(String disease) async {
    try {
      var body = {
        "keywords": [disease]
      };
      final response = await sendRequest(
          'https://aijaz.pythonanywhere.com/recipes',
          method: 'POST',
          body: body);
      return dishesModel.fromJson(response);
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getkeyword(String word) async {
    try {
      var body = {"text": word};

      var response = await sendRequest(
          'https://aijaz.pythonanywhere.com/keywords_from_audio',
          method: 'POST',
          body: body);
      print("response12$response");
      return response;
    } catch (e) {
      print('error>$e');
      rethrow;
    }
  }
}
