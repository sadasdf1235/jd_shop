import 'dart:convert';

import 'package:jd_shop/utils/storage.dart';

class SearchService {
  static Future<void> setSearchData(dynamic value)async{
    List searchList = [];
    try{
      searchList = json.decode(await Storage.getString('searchList'));
      bool flag = searchList.any((e) => e == value);
      if(!flag){
        searchList.add(value);
      }
    }catch(e){
      searchList.add(value);
    }finally {
      await Storage.setString('searchList', json.encode(searchList));
    }
  }
  static Future<List> getSearchData()async{
    try{
      return json.decode(await Storage.getString('searchList'));
    }catch(e){
      return [];
    }
  }
  static Future<void> clearSearchList()async{
    await Storage.clear('searchList');
  }
}