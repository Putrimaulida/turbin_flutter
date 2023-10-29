
class LoginError {
  String? message;
  Errors? errors;

  LoginError({this.message, this.errors});

  LoginError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
