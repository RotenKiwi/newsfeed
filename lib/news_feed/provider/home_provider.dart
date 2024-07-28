import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../../constants/api_key.dart';
import '../models/news_model.dart';

class HomeProvider extends ChangeNotifier {
  NewsModel? newsModel;
  final remoteConfig = FirebaseRemoteConfig.instance;

  getRemoteValue() async {
    try {
      await remoteConfig.fetchAndActivate();
      String countryCode = remoteConfig.getString('country');
      print('Country code: $countryCode');
    } catch (e) {
      print('Error fetching Remote Config: $e');
    }

    remoteConfig.setDefaults(<String, dynamic>{
      'country': 'in', // Default country code
    });
  }

  getNews() async {
    Dio dio = Dio();
    await getRemoteValue();

    try {
      final response = await dio.get(
          "https://newsapi.org/v2/top-headlines?country=${remoteConfig.getString('country')}&apiKey=${kApiKey}");
      if (response.statusCode == 200) {
        newsModel = NewsModel.fromJson(response.data);
        notifyListeners();
      } else {
        print("Unexpected status code");
      }
    } on DioException catch (e) {
      print("Exception : $e");
    }
  }
}
