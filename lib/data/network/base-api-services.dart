abstract class BaseApiServices {
  Future<dynamic> getApi(String token, String Url);
  Future<dynamic> postApi(String token, var data, String Url);
}
