import 'baseservice.dart';

class Getword extends BaseApiService {
Future<Map<String,dynamic>> getSelectedWord(String word) async {
  try {
    var body = {"text": word};
    var response = await sendRequest('https://nutriapp-chi.vercel.app/',
        method: 'POST', body: body);
    print("response12$response");
    return response;
  } catch (e) {
    print('error>$e');
    rethrow;
  }
}

}
