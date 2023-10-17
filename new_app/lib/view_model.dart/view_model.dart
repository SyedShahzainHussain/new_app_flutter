import 'package:flutter/material.dart';
import 'package:new_app/model/bbc_model.dart';
import 'package:new_app/model/categories_model.dart';
import 'package:new_app/repository/news_repository.dart';

class NewsViewModel  with ChangeNotifier {
  NewsRepository newsRepository = NewsRepository();


  Future<BBCModel> fetchModel(String channelName)async{
   return await newsRepository.fetchModel(channelName);
  }

   Future<CategoriesModel> getCategories(String category)async{
   return await newsRepository.getCategories(category);
  }
}
