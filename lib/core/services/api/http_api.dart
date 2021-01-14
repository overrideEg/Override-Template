import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/models/server_error.dart';
import 'api.dart';

class HttpApi implements Api {
  Future<Either<ServerError, dynamic>> request(String endPoint,
      {body,
      BuildContext context,
      String serverPath = 'https://jsonplaceholder.typicode.com/',
      Function onSendProgress,
      Map<String, dynamic> headers,
      String type = RequestType.Get,
      Map<String, dynamic> queryParameters,
      String contentType = Headers.jsonContentType,
      bool retry = false,
      ResponseType responseType = ResponseType.json}) async {
    Response response;

    final dio = Dio(BaseOptions(
        baseUrl: serverPath, connectTimeout: 60000, receiveTimeout: 60000));
        
    final options = Options(
        headers: headers, contentType: contentType, responseType: responseType);

    if (onSendProgress == null) {
      onSendProgress = (int sent, int total) {
        print('$endPoint\n sent: $sent total: $total\n');
      };
    }

    try {
      switch (type) {
        case RequestType.Get:
          {
            response = await dio.get(serverPath + endPoint,
                queryParameters: queryParameters, options: options);
          }
          break;
        case RequestType.Post:
          {
            response = await dio.post(serverPath + endPoint,
                queryParameters: queryParameters,
                onSendProgress: onSendProgress,
                data: body,
                options: options);
          }
          break;
        case RequestType.Put:
          {
            response = await dio.put(endPoint,
                queryParameters: queryParameters, data: body, options: options);
          }
          break;
        case RequestType.Delete:
          {
            response = await dio.delete(endPoint,
                queryParameters: queryParameters, data: body, options: options);
          }
          break;
        default:
          break;
      }

      print('$type $endPoint\n$headers\nstatusCode:${response.statusCode}\n');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data); //map of string dynamic...
      } else {
        return Left(ServerError(response.data['message']));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response.statusCode == 401 && !retry && context != null) {
          // sending Refresh token
          Logger().w('Try to send refresh token');
          await refreshToken(context);
          return await request(endPoint,
              body: body,
              queryParameters: queryParameters,
              headers: Header.userAuth,
              context: context,
              type: type,
              contentType: contentType,
              responseType: responseType,
              retry: true);
        } else if (e.response.statusCode == 401 && retry && context != null) {
          Logger().w("Checking session expired");
          await checkSessionExpired(context: context, response: e.response);
        }
      } else {
        return Left(ServerError(e.message));
      }
      return Left(ServerError(e.response.statusMessage));
    }
  }

  checkSessionExpired({Response response, BuildContext context}) async {
    if (context != null &&
        (response.statusCode == 401 || response.statusCode == 500)) {
      final expiredMsg = response.data['message'];
      final authExpired = expiredMsg != null && expiredMsg == 'Unauthorized';

      if (authExpired) {
        // await AuthenticationService.handleAuthExpired(context: context);
      }
      return true;
    }
  }

  Future<bool> refreshToken(BuildContext context) async {
    // String email = Provider.of<AuthenticationService>(context, listen: false)
    //     .user
    //     .user
    //     .email;

    // String oldToken =
    //     Provider.of<AuthenticationService>(context, listen: false).user.token;

    // final body = {"oldtoken": oldToken, "email": email};
    // print(body);
    // var tokenResponse;
    // tokenResponse = await request(EndPoint.REFRESH_TOKEN,
    //     type: RequestType.Put,
    //     body: body,
    //     headers: Header.clientAuth,
    //     context: context);

    // print(tokenResponse);

    // User user;

    // if (tokenResponse != null && tokenResponse['token'] != null) {
    //   user = User.fromJson(tokenResponse);
    //   Provider.of<AuthenticationService>(context, listen: false)
    //       .saveUser(user: user);
    // }

    // final token = tokenResponse["token"];

    // final tokenRefreshed = token != null;

    // if (tokenRefreshed) {
    //   await Preference.setString(PrefKeys.token, token);
    // }
    // return tokenRefreshed;
    return true;
  }

  // Future<Either<ServerError, dynamic>> getUserPosts() async {
  //   final res = await request(EndPoint.TODO, serverPath: "http://server.overrideeg.net:3002/v1/");
  //   return res;
  // }

  Future<Either<ServerError, dynamic>> getUserPosts() async {
    final res = await request(EndPoint.POST, type: RequestType.Get);
    return res;
  }

  //401
  Future<Either<ServerError, dynamic>> getError401() async {
    final res = await request("xsddddd",
        serverPath: "https://wendux.github.io/", type: RequestType.Get);
    return res;
  }

  //404
  Future<Either<ServerError, dynamic>> getError404() async {
    final res = await request("v1/Invoice/all",
        serverPath: "https://beauty.remabackend.com/", type: RequestType.Get);
    return res;
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

//   Future<User> updateUser({@required User user, @required String accessToken}) async {
//     final response = await request(EndPoint.USER + '/${user.id}', type: RequestType.Put, headers: Header.userAuth(accessToken), body: user.toJson());

//     return response != null ? User.fromJson(response) : null;
//   }

//   Future<List<Category>> getCategories() async {
//     final response = await request(EndPoint.CATEGORY);
//     try {
//       return List.from(response).map((map) => Category.fromJson(map)).toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<Category> addCategory({@required Category category, @required String accessToken}) async {
//     final response = await request(EndPoint.CATEGORY, type: RequestType.Post, headers: Header.userAuth(accessToken), body: category.toJson());
//     return response != null ? Category.fromJson(response) : null;
//   }

//   Future<List<Post>> getCategoryPosts({@required int categoryID}) async {
//     final response = await request(EndPoint.POST, queryParameters: {'categoryId': categoryID});
//     try {
//       return List.from(response).map((map) => Post.fromJson(map)).toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<Post> getPost({@required int postID}) async {
//     final response = await request(EndPoint.POST + '/$postID');
//     return response != null ? Post.fromJson(response) : null;
//   }

//   Future<List<Comment>> getPostComments({@required int postID}) async {
//     final response = await request(EndPoint.POST, queryParameters: {'postId': postID});
//     try {
//       return List<Map<String, dynamic>>.from(response).map((m) => Comment.fromJson(m));
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<Comment> addComment({@required Comment comment, @required String accessToken}) async {
//     final headers = {}..addAll(Header.userAuth(accessToken));
//     final response = await request(EndPoint.COMMENT, type: RequestType.Post, headers: headers, body: comment.toJson());
//     return response != null ? Comment.fromJson(response) : null;
//   }

//   Future<Comment> updateComment({@required Comment comment, @required String accessToken}) async {
//     final headers = {}..addAll(Header.userAuth(accessToken));
//     final response = await request(EndPoint.COMMENT, type: RequestType.Put, headers: headers, body: comment.toJson());
//     return response != null ? Comment.fromJson(response) : null;
//   }

//   Future<bool> deleteCategory({int id, String accessToken}) async {
//     final response = await request(EndPoint.CATEGORY + '/$id', type: RequestType.Delete, headers: Header.userAuth(accessToken));
//     return response != null ? response['result'] == 'deleted' : false;
//   }

//   Future<bool> deleteComment({@required int commentID, @required String accessToken}) async {
//     final headers = {}..addAll(Header.userAuth(accessToken));
//     final response = await request(EndPoint.COMMENT + '/$commentID', type: RequestType.Delete, headers: headers);
//     return response != null ? response['result'] == 'deleted' : false;
//   }

//   Future<Reply> addReply({@required Reply reply, @required String accessToken}) async {
//     final headers = {}..addAll(Header.userAuth(accessToken));
//     final response = await request(EndPoint.REPLY, type: RequestType.Post, headers: headers, body: reply.toJson());
//     return response != null ? Reply.fromJson(response) : null;
//   }

//   Future<Reply> updateReply({@required Reply reply, @required String accessToken}) async {
//     final headers = {}..addAll(Header.userAuth(accessToken));
//     final response = await request(EndPoint.REPLY, type: RequestType.Put, headers: headers, body: reply.toJson());
//     return response != null ? Reply.fromJson(response) : null;
//   }

//   Future<bool> deleteReply({@required int replyID, @required String accessToken}) async {
//     final headers = {}..addAll(Header.userAuth(accessToken));
//     final response = await request(EndPoint.REPLY + '/$replyID', type: RequestType.Delete, headers: headers);
//     return response != null ? response['result'] == 'deleted' : false;
//   }

//   Future<List<Post>> getRecentlyAdded() async {
//     final response = await request(EndPoint.RECENTLYADDED);
//     try {
//       return List.from(response).map((map) => Post.fromJson(map)).toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<List<Post>> getMostWatched() async {
//     final response = await request(EndPoint.MOSTWATCHED);
//     try {
//       return List.from(response).map((map) => Post.fromJson(map)).toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<bool> sendView({int postId}) async {
//     final response = await request(EndPoint.POSTView + '/$postId', type: RequestType.Post);
//     return response['id'] != null ? true : false;
//   }
// }
