import 'package:http/http.dart' as http;

enum Http { get, put, post, delete }

class HttpApi {
  static HttpApi _instance;
  final int timeout;

  HttpApi({this.timeout});

  factory HttpApi.of({timeout = 10})=> _instance ??= HttpApi(timeout:timeout);

  Future<http.Response> httpOperation(Http operation, String endpoint, {dynamic data}) async {

      final duration = Duration(seconds: timeout);
      switch (operation) {
        case Http.get:
          {
            return await http.get(endpoint).timeout(duration);
          }
        case Http.delete:
          {
            return await http.delete(endpoint).timeout(duration);
          }
        case Http.put:
          {
            return await http.put(endpoint, body: data).timeout(duration);
          }
        case Http.post:
          {
            return await http.post(endpoint, body: data).timeout(duration);
          }
        default:
          throw ArgumentError();
      }
  }
}