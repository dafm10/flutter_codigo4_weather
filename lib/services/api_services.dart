import 'dart:convert';

import 'package:flutter_codigo4_weather/models/general_model.dart';
import 'package:flutter_codigo4_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class APIService {

  Future<GeneralModel?> getDataWeather(String city) async{
    String path = "$pathProduction/weather?q=$city&appid=$apiKey";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> myMap = json.decode(response.body);
      GeneralModel generalModel = GeneralModel.fromJson(myMap);
      return generalModel;
    }
  }

}