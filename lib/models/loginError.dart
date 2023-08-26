import 'dart:convert';

class LoginError {
  String? message;
  Errors? errors;

  LoginError({this.message, this.errors});

  LoginError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? username;
  List<String>? password;

  Errors({this.username, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json['username'] != null) {
      username = List.from(json['username']);
    }
    if (json['password'] != null) {
      password = List.from(json['password']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
