import 'dart:convert';

import 'package:new_app/model/bbc_model.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/model/categories_model.dart';

class NewsRepository {
  Future<BBCModel> fetchModel(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=4edca92a893d48ed80f2acbcd64666b3';
    BBCModel? data;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        data = BBCModel.fromJson(body);
      }
    } catch (e) {
      throw Exception('Error');
    }
    return data!;
  }

  Future<CategoriesModel> getCategories(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=4edca92a893d48ed80f2acbcd64666b3';

    CategoriesModel? categoryModel;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        categoryModel = CategoriesModel.fromJson(body);
      }
    } catch (e) {
      throw Exception("Error");
    }
    return categoryModel!;
  }
}
