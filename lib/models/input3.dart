// To parse this JSON data, do
//
//     final input3 = input3FromJson(jsonString);

import 'dart:convert';

Input3 input3FromJson(String str) => Input3.fromJson(json.decode(str));

String input3ToJson(Input3 data) => json.encode(data.toJson());

class Input3 {
    List<Datum3> data;
    dynamic message;

    Input3({
        required this.data,
        required this.message,
    });

    factory Input3.fromJson(Map<String, dynamic> json) => Input3(
        data: List<Datum3>.from(json["data"].map((x) => Datum3.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum3 {
    int id;
    double tempWaterIn;
    double tempWaterOut;
    double tempOilIn;
    double tempOilOut;
    double vacum;
    double injector;
    double speedDrop;
    double loadLimit;
    double floIn;
    double floOut;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    Datum3({
        required this.id,
        required this.tempWaterIn,
        required this.tempWaterOut,
        required this.tempOilIn,
        required this.tempOilOut,
        required this.vacum,
        required this.injector,
        required this.speedDrop,
        required this.loadLimit,
        required this.floIn,
        required this.floOut,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory Datum3.fromJson(Map<String, dynamic> json) => Datum3(
        id: json["id"],
        tempWaterIn: json["temp_water_in"]?.toDouble(),
        tempWaterOut: json["temp_water_out"]?.toDouble(),
        tempOilIn: json["temp_oil_in"]?.toDouble(),
        tempOilOut: json["temp_oil_out"]?.toDouble(),
        vacum: json["vacum"]?.toDouble(),
        injector: json["injector"]?.toDouble(),
        speedDrop: json["speed_drop"]?.toDouble(),
        loadLimit: json["load_limit"]?.toDouble(),
        floIn: json["flo_in"]?.toDouble(),
        floOut: json["flo_out"]?.toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "temp_water_in": tempWaterIn,
        "temp_water_out": tempWaterOut,
        "temp_oil_in": tempOilIn,
        "temp_oil_out": tempOilOut,
        "vacum": vacum,
        "injector": injector,
        "speed_drop": speedDrop,
        "load_limit": loadLimit,
        "flo_in": floIn,
        "flo_out": floOut,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    int id;
    String name;
    String username;
    String email;
    String gambar;
    dynamic createdAt;
    dynamic updatedAt;
    String role;

    User({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.gambar,
        required this.createdAt,
        required this.updatedAt,
        required this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        gambar: json["gambar"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "gambar": gambar,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role": role,
    };
}
