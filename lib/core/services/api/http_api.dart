import 'package:dio/dio.dart';
import 'package:testapp/core/models/api_models.dart';

import 'api.dart';

class HttpApi implements Api {
  String serverPAth = 'www.realServerPath.com';

  Future<Response> request(String endPoint,
      {body,
      Function onSendProgress,
      Map<String, dynamic> headers,
      String type = RequestType.Get,
      Map<String, dynamic> queryParameters,
      String contentType = Headers.jsonContentType,
      ResponseType responseType = ResponseType.json}) async {
    Response response;

    final dio = Dio(BaseOptions(baseUrl: serverPAth, connectTimeout: 5000, receiveTimeout: 5000));
    final options = Options(headers: headers, contentType: contentType, responseType: responseType);

    if (onSendProgress == null) {
      onSendProgress = (int sent, int total) {
        print('$endPoint\n sent: $sent total: $total\n');
      };
    }

    try {
      switch (type) {
        case RequestType.Get:
          {
            response = await dio.get(endPoint, queryParameters: queryParameters, options: options);
          }
          break;
        case RequestType.Post:
          {
            response =
                await dio.post(endPoint, queryParameters: queryParameters, onSendProgress: onSendProgress, data: body, options: options);
          }
          break;
        case RequestType.Put:
          {
            response = await dio.put(endPoint, queryParameters: queryParameters, data: body, options: options);
          }
          break;
        case RequestType.Delete:
          {
            response = await dio.delete(endPoint, queryParameters: queryParameters, data: body, options: options);
          }
          break;
        default:
          break;
      }

      print('$type $endPoint\n$headers\nstatusCode:${response.statusCode}\n');
      return response; //map of string dynamic...

    } catch (e) {
      print('🌐🌐ERROR in http $type for $endPoint:🌐🌐\n' + e.toString());
      return null;
    }
  }

  @override
  Future<List<Comment>> getCommentsForPost(int postId) async {
    await request(EndPoint.COMMENT);

    return null;
  }

  @override
  Future<List<Post>> getPostsForUser(int userId) async {
    await request(EndPoint.COMMENT);

    return null;
  }

  @override
  Future<User> getUser(int userId) async {
    await request(EndPoint.COMMENT);
    return null;
  }

  @override
  Future<LoginResponse> login({String username, String password}) async {
    await request(EndPoint.COMMENT);
    return LoginResponse(success: false, message: 'Username not found');
  }
}

//   Future<User> registerUser({@required User user}) async {
//     final response = await request(EndPoint.REGISTER, type: RequestType.Post, body: user.toJson());
//     return response != null ? User.fromJson(response) : null;
//   }

//   Future<String> refreshToken({@required String username, String password}) async {
//     print(username + " " + password);
//     try {
//       final body = {'username': username, 'password': password, 'grant_type': 'password'};
//       final response = await request(EndPoint.TOKEN, type: RequestType.Post, headers: Header.clientAuth, contentType: Headers.formUrlEncodedContentType, body: body);
//       return response != null ? response['access_token'] : null;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<String> uploadImage({@required File image}) async {
//     final formData = FormData.fromMap({'file': await MultipartFile.fromFile(image.path, filename: 'image.png')});
//     final response = await request('upload', type: RequestType.Post, contentType: Headers.contentTypeHeader, body: formData);
//     return response['fileURL'] ?? null;
//   }

//   Future<User> getUser({@required int id}) async {
//     final response = await request(EndPoint.USER + '/$id');

//     return response != null ? User.fromJson(response) : null;
//   }
