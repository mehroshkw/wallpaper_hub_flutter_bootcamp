import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';


class PhotosService {
  List<Photos> newsModel = [];
  Future<Photos?> getApi() async{
    final response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=all&per_page=30&page=1"),
        headers: {"Authorization": "563492ad6f917000010000012876927f901846cd8b5d658bbe09bcda"});
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      // print("Successfully called API");
      // print(response.body.toString());
      // for(Map i in data){
      //   newsModel.add(News.fromJson(i));
      // }
      return Photos.fromJson(data);
    }else{
      print("Error occured during api call");
      return Photos.fromJson(data);

    }
  }
}