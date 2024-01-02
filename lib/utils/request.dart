import 'package:dio/dio.dart';
class Request {
  static String domain = "https://jdmall.itying.com";
  var dio;
  Request(){
    final options = BaseOptions(
      baseUrl: 'https://jdmall.itying.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    dio = Dio(options);
  }
  Future get(String url) async{
    try{
      final response = await dio.get(url);
      return response;
    }catch(e){
      print(e);
    }
  }
  static String replaceUrl(String url){
    String s = url.replaceAll("\\", "/");
    String imageUrl = domain + "/" + s;
    return imageUrl;
  }
}