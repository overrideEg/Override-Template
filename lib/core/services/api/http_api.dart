import 'package:testapp/core/models/api_models.dart';

import 'api.dart';

class HttpApi implements Api {
  @override
  String serverPAth = 'www.realServerPath.com';

  @override
  Future<List<Comment>> getCommentsForPost(int postId) async {
    await request(serverPAth, EndPoint.COMMENT);

    return null;
  }

  @override
  Future<List<Post>> getPostsForUser(int userId) async {
    await request(serverPAth, EndPoint.COMMENT);

    return null;
  }

  @override
  Future<User> getUser(int userId) async {
    await request(serverPAth, EndPoint.COMMENT);
    return null;
  }

  @override
  Future<LoginResponse> login({String username, String password}) async {
    await request(serverPAth, EndPoint.COMMENT);
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
