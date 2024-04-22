// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeRepository{


StartsVisit()async{
   try {
      Uri apiUrl = Uri.parse(Globalvireables.timeAPI);

      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);
        await SQLHelper.saveStartTime(jsonResponse.toString());

      Globalvireables.startTime = jsonResponse.toString();

    
    } catch (_) {
      DateTime now = DateTime.now();
      String startTime = DateFormat('hh:mm a').format(now);
      await SQLHelper.saveStartTime(startTime);

    }
// try{
//   String json = jsonEncode(data);
//   print(json);
//   String url = await AppUrl.GetHomeData();
// dynamic response = await _apiServices.getPostApiResponse1(url,json);
// return response = HomeNewModel.fromJson(response);

// }catch(e){
// throw e ;
// }
}



}
