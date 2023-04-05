import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

class CategoryService {
  List<Photos> newsModel = [];
  Future<Photos?> getCatApi(String category) async{
    final response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$category&per_page=30&page=1"),
        headers: {"Authorization": "563492ad6f917000010000012876927f901846cd8b5d658bbe09bcda"});
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return Photos.fromJson(data);
    }else{
      return Photos.fromJson(data);
    }
  }
}