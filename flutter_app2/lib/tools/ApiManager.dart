import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiManager {

  Dio _dio;
  factory ApiManager() => _getInstance();
  static ApiManager _instance;
  ApiManager._internal(){
    var options = BaseOptions(
      baseUrl: "http://www.wanandroid.com/",
      connectTimeout: 10000,
      receiveTimeout: 3000
    );
    _dio = Dio(options);
  }

  static ApiManager _getInstance(){
    if(_instance == null){
      _instance = new ApiManager._internal();
    }
    return _instance;
  }

  static ApiManager get instance => _getInstance();


  /// 获取首页banner
  Future<Response> getHomeBanner() async {
    try{
      Response response = await _dio.get("banner/json");
      return response;
    }catch (e){
      return null;
    }
  }

  /// 获取首页文章列表
  Future<Response> getHomeArticle(int page) async {
    try {
      Response response = await _dio.get("article/list/${page}/json");
      return response;
    } catch (e) {
      return null;
    }
  }

}