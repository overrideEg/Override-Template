import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:either_option/either_option.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/models/server_error.dart';
import 'package:testapp/core/services/auth/authentication_service.dart';
import 'api.dart';

class HttpApi implements Api {
  Future<Either<ServerError, dynamic>> request(
      String endPoint, BuildContext context,
      {body,
      bool refresh = false,
      String serverPath = 'http://debug.overrideeg.net:3342/v1/',
      // String serverPath = 'http://192.168.1.14:3015/v1/',
      Function? onSendProgress,
      Map<String, dynamic>? headers,
      String type = RequestType.Get,
      Map<String, dynamic>? queryParameters,
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

    if (context != null && !refresh) {
      bool logged =
          Provider.of<AuthenticationService>(context, listen: false).userLoged;

      if (logged) {
        String token =
            Provider.of<AuthenticationService>(context, listen: false)
                .user!
                .token!;
        if (token != null) {
          String userToken = token.split('.')[1];
          switch (userToken.length % 4) {
            case 1:
              break; // this case can't be handled well, because 3 padding chars is illeagal.
            case 2:
              userToken = userToken + "==";
              break;
            case 3:
              userToken = userToken + "=";
              break;
          }
          var decodedToken = base64.decode(userToken);

          var tokenJson = json.decode(utf8.decode(decodedToken));
          DateTime time =
              DateTime.fromMillisecondsSinceEpoch(tokenJson['exp'] * 1000);
          if (time.isBefore(DateTime.now())) {
            await refreshToken(context);
          }
        }
      }
    }
    try {
      switch (type) {
        // case RequestType.Get:
        //   {
        //     response = await dio.get(serverPath + endPoint,
        //         queryParameters: queryParameters, options: options);
        //   }
        //   break;
        case RequestType.Post:
          {
            response = await dio.post(serverPath + endPoint,
                queryParameters: queryParameters,
                onSendProgress: onSendProgress.call(),
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
          {
            response = await dio.get(serverPath + endPoint,
                queryParameters: queryParameters, options: options);
            break;
          }
      }

      print('$type $endPoint\n$headers\nstatusCode:${response.statusCode}\n');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data); //map of string dynamic...
      } else {
        return Left(ServerError(response.data['message']));
      }
    } on DioError catch (e) {
      if (e.response! != null) {
        if (e.response!.statusCode == 401 && !retry && context != null) {
          // sending Refresh token
          Logger().w('Try to send refresh token');
          await refreshToken(context);
          return await request(endPoint, context,
              body: body,
              queryParameters: queryParameters,
              headers: Header.userAuth,
              type: type,
              contentType: contentType,
              responseType: responseType,
              retry: true);
        } else if (e.response!.statusCode == 401 && retry && context != null) {
          Logger().w("Checking session expired");
          await checkSessionExpired(context: context, response: e.response!);
        }
      } else {
        return Left(ServerError(e.message));
      }
      // return Left(ServerError(e.response.statusMessage));
      return Left(ServerError(e.response!.data["message"]));
    }
  }

  Future<void> refreshToken(BuildContext context) async {
    String email = Provider.of<AuthenticationService>(context, listen: false)
        .user!
        .user!
        .email!;

    String oldToken =
        Provider.of<AuthenticationService>(context, listen: false).user!.token!;

    final body = {"oldtoken": oldToken, "email": email};
    print(body);
    var tokenResponse;
    tokenResponse = await request(EndPoint.REFRESH_TOKEN, context,
        type: RequestType.Put,
        body: body,
        headers: Header.clientAuth,
        refresh: true);
    // print(tokenResponse);
    User user;

    tokenResponse.fold((error) => print(error), (data) {
      user = User.fromJson(data);
      Provider.of<AuthenticationService>(context, listen: false)
          .saveUser(user: user);
    });

    // return true;
  }

  requestToken(BuildContext context, {required String mackAddress}) async {
    final res = await request(
      EndPoint.REQUEST_TOKEN + "/$mackAddress",
      context,
      type: RequestType.Post,
      headers: Header.clientAuth,
    );
    return res;
  }

  Future<Either<ServerError, dynamic>> getHome(BuildContext context) async {
    final res = await request(
      EndPoint.HOME,
      context,
      type: RequestType.Get,
      headers: Header.userAuth,
    );
    return res;
  }

  checkSessionExpired(
      {required Response response, required BuildContext context}) async {
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

  signIn(BuildContext context, {required Map<String, dynamic> body}) async {
    final res = await request(
      EndPoint.AUTH,
      context,
      body: body,
      headers: Header.clientAuth,
      type: RequestType.Post,
    );

    return res;
  }

  Future<Either<ServerError, dynamic>> getOnBoarding(
      BuildContext context) async {
    final res = await request(
      EndPoint.ONBOARDING,
      context,
      headers: Header.clientAuth,
      type: RequestType.Get,
    );

    return res;
  }

  updateUser(BuildContext context, {required Map<String, dynamic> body}) async {
    final res = await request(
      EndPoint.USER + '/${body['uid']}',
      context,
      body: body,
      headers: Header.userAuth,
      type: RequestType.Put,
    );

    return res;
  }

  Future<Either<ServerError, dynamic>> resendActiveCode(
      BuildContext context) async {
    final res = await request(
      EndPoint.RESEND_CODE,
      context,
      headers: Header.userAuth,
      type: RequestType.Get,
    );

    return res;
  }

  verifyUser(BuildContext context, {required String code}) async {
    final res = await request(
      EndPoint.VERIFY_USER + '/$code',
      context,
      headers: Header.userAuth,
      type: RequestType.Post,
    );

    return res;
  }

  uploadMultiImage(BuildContext context,
      {required List<MultipartFile> files}) async {
    var body = FormData.fromMap({"files": files});

    final res = await request(
        EndPoint.UPLOAD_MULTIPLE_IMAGE,
        // serverPath: 'http://server.overrideeg.net:3333/File/',
        context,
        headers: Header.clientAuth,
        type: RequestType.Post,
        body: body);

    Logger().i('>> File Upload Starting');

    return res;
  }

  uploadImage(BuildContext context, {required MultipartFile file}) async {
    var body = FormData.fromMap({"file": file});

    final res = await request(
        EndPoint.UPLOAD_IMAGE,
        // serverPath: 'http://server.overrideeg.net:3333/File/',
        context,
        headers: Header.clientAuth,
        type: RequestType.Post,
        body: body);

    Logger().i('>> File Upload Starting');
    return res;
  }

  upload(BuildContext context, {required File file}) async {
    MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
    FormData body = FormData.fromMap({"file": multipartFile});
    final res = await request(EndPoint.UPLOAD_IMAGE, context,
        headers: Header.clientAuth, type: RequestType.Post, body: body);
    Logger().i('>> File Upload Starting');
    return res;
  }

  contactUs(BuildContext context, Map<String, dynamic> value) async {
    return await request(
      EndPoint.CONTACTUS,
      context,
      body: value,
      headers: Header.userAuth,
      type: RequestType.Post,
    );
  }

  updateFcmToken(BuildContext context,
      {required Map<String, dynamic> body, required String userId}) async {
    final res = await request(
      EndPoint.UPDATE_FCM + "/$userId",
      context,
      headers: Header.userAuth,
      type: RequestType.Put,
      body: body,
    );
    return res;
  }

  getNotificationsForUser(BuildContext context) async {
    final res = await request(
      EndPoint.NOTIFICATION,
      context,
      headers: Header.userAuth,
      type: RequestType.Get,
    );
    return res;
  }
}
