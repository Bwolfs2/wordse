import 'dart:convert';

import 'package:http/http.dart' as http;

class TranslationApi {
    static final _apiKey = "AIzaSyBw3XsrJRd72AWPXOiRHaHQ47DjQ06br40";

    Future<String> translate(String word) async {
        String _url = "https://translation.googleapis.com/language/translate/v2?target=en&key=$_apiKey&q=$word";
        final response = await http.post(Uri.parse(_url));

        if(response.statusCode == 200){
            final body = json.decode(response.body);
            final translations = body['data']['translations'] as List;
            final translation = translations.first;

            return translation['translatedText'];
        } else {
            return "Erro ao obter tradução!";
        }
    }

}