// To parse this JSON data, do
//
//     final input2 = input2FromJson(jsonString);

import 'dart:convert';

Input2 input2FromJson(String str) => Input2.fromJson(json.decode(str));

String input2ToJson(Input2 data) => json.encode(data.toJson());

class Input2 {
    List<Datum2> data;
    dynamic message;

    Input2({
        required this.data,
        required this.message,
    });

    factory Input2.fromJson(Map<String, dynamic> json) => Input2(
        data: List<Datum2>.from(json["data"].map((x) => Datum2.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum2 {
    int id;
    double turbinSpeed;
    double rotorVibMonitor;
    double axialDisplacementMonitor;
    double mainSteam;
    double stageSteam;
    double exhaust;
    double lubOil;
    double controlOil;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    Datum2({
        required this.id,
        required this.turbinSpeed,
        required this.rotorVibMonitor,
        required this.axialDisplacementMonitor,
        required this.mainSteam,
        required this.stageSteam,
        required this.exhaust,
        required this.lubOil,
        required this.controlOil,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory Datum2.fromJson(Map<String, dynamic> json) => Datum2(
        id: json["id"],
        turbinSpeed: json["turbin_speed"]?.toDouble(),
        rotorVibMonitor: json["rotor_vib_monitor"]?.toDouble(),
        axialDisplacementMonitor: json["axial_displacement_monitor"]?.toDouble(),
        mainSteam: json["main_steam"]?.toDouble(),
        stageSteam: json["stage_steam"]?.toDouble(),
        exhaust: json["exhaust"]?.toDouble(),
        lubOil: json["lub_oil"]?.toDouble(),
        controlOil: json["control_oil"]?.toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "turbin_speed": turbinSpeed,
        "rotor_vib_monitor": rotorVibMonitor,
        "axial_displacement_monitor": axialDisplacementMonitor,
        "main_steam": mainSteam,
        "stage_steam": stageSteam,
        "exhaust": exhaust,
        "lub_oil": lubOil,
        "control_oil": controlOil,
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
