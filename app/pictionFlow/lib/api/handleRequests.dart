import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//TEMP JWT:
var jwt;
var userid;

enum reqs {
  REGISTER,
  SIGNIN,
  AUTHENTICATE,
}

class Requester {
  String _baseurl;
  Requester(
    String baseurl,
  ) {
    this._baseurl = baseurl;
  }
  Future<dynamic> post(reqs requestType, String jsonDataString) async {
    var postresponse;
    try {
      final uri = Uri.parse(_baseurl + retrievePath(requestType));
      final Map<String, dynamic> headers = {
        'Authorization': jwt,
        'origin': userid
      };
      final body = {'data': jsonDataString};

      http.Response response =
          await http.post(uri, headers: headers, body: body);

      int status = response.statusCode;

      switch (status) {
        case 200:
          postresponse = json.decode(response.body.toString());
          break;
        case 403:
          //temporary catch and throw in same function
          throw UnauthorisedException(response.headers.toString());
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } on BadRequestException catch (bre) {
      return bre.toString();
    } on UnauthorisedException catch (ue) {
      return ue.toString();
    } on SocketException {
      throw FetchDataException('Bad Internet Connection');
    } on Exception {
      return "Something Went Wrong with post";
    }

    return postresponse;
  }

  static String retrievePath(reqs requestType) {
    switch (requestType) {
      case reqs.REGISTER:
        return 'newuser';
      case reqs.AUTHENTICATE:
        return 'auth';
      case reqs.SIGNIN:
        return 'signin';
    }

    throw BadRequestException("From retrievePath in Requester: ");
  }
}

class ApiException implements Exception {
  final _message;
  final _prefix;

  ApiException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends ApiException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
