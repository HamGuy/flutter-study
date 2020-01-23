import 'package:dio/dio.dart';
import 'package:medium_clap_animation/post.dart';


enum HttpMethod {GET,POST,PATCH,DELETE,PUT,HEAD}

abstract class RequestAPI<T> {
  String get host;
  String get path;
  Map get param;
  Map<String,String> get header;
  HttpMethod get method;
  String get url;

  List<T> phraseData<T>(data);
}

class BaseApi<T> extends RequestAPI {
  @override
  String get host => 'https://jsonplaceholder.typicode.com/';

  @override
  HttpMethod get method => HttpMethod.GET;

  @override
  Map<String, String> get header => {};

  @override
  Map get param => {};

  @override
  String get path => '';

  @override
  String get url => host + path;

  @override
  List<T> phraseData<T>(data) {
    return null;
  }
}

class SomeAPI extends BaseApi {
  @override
  String get path => 'posts';

  @override
  List<T> phraseData<T>(data) {
    super.phraseData(data);

    final posts = data.map((json)=> Post.fromJson(json)).toList();
    return posts;
  }
}


class NetworkHelper {
  
  // 
  factory NetworkHelper() => _sharedInstance();


  Dio _dio;
  NetworkHelper._() {
  _dio = new Dio();
  }

  static NetworkHelper _instance;
  static NetworkHelper _sharedInstance() {
    if(_instance == null) {
      _instance = NetworkHelper._();
    }
    return _instance;
  }

  void request<T>(RequestAPI api, callback) async {
    var response;
    switch(api.method) {
      case HttpMethod.GET:
       response = await this._dio.get(api.url);
      break;
      default:
      break;
    }
    final content = response.data;
    var list = api.phraseData(content);
    callback(list,null);
  }

}