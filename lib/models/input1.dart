// To parse this JSON data, do
//
//     final input1 = input1FromJson(jsonString);

import 'dart:convert';

Input1 input1FromJson(String str) => Input1.fromJson(json.decode(str));

String input1ToJson(Input1 data) => json.encode(data.toJson());

class Input1 {
    List<Datum> data;
    dynamic message;

    Input1({
        required this.data,
        required this.message,
    });

    factory Input1.fromJson(Map<String, dynamic> json) => Input1(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    int id;
    double inletSteam;
    double exmSteam;
    double turbinThrustBearing;
    double tbGovSide;
    double tbCoupSide;
    double pbTbnSide;
    double pbGenSide;
    double wbTbnSide;
    double wbGenSide;
    double ocLubOilOutlet;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    Datum({
        required this.id,
        required this.inletSteam,
        required this.exmSteam,
        required this.turbinThrustBearing,
        required this.tbGovSide,
        required this.tbCoupSide,
        required this.pbTbnSide,
        required this.pbGenSide,
        required this.wbTbnSide,
        required this.wbGenSide,
        required this.ocLubOilOutlet,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        inletSteam: json["inlet_steam"]?.toDouble(),
        exmSteam: json["exm_steam"]?.toDouble(),
        turbinThrustBearing: json["turbin_thrust_bearing"]?.toDouble(),
        tbGovSide: json["tb_gov_side"]?.toDouble(),
        tbCoupSide: json["tb_coup_side"]?.toDouble(),
        pbTbnSide: json["pb_tbn_side"]?.toDouble(),
        pbGenSide: json["pb_gen_side"]?.toDouble(),
        wbTbnSide: json["wb_tbn_side"]?.toDouble(),
        wbGenSide: json["wb_gen_side"]?.toDouble(),
        ocLubOilOutlet: json["oc_lub_oil_outlet"]?.toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "inlet_steam": inletSteam,
        "exm_steam": exmSteam,
        "turbin_thrust_bearing": turbinThrustBearing,
        "tb_gov_side": tbGovSide,
        "tb_coup_side": tbCoupSide,
        "pb_tbn_side": pbTbnSide,
        "pb_gen_side": pbGenSide,
        "wb_tbn_side": wbTbnSide,
        "wb_gen_side": wbGenSide,
        "oc_lub_oil_outlet": ocLubOilOutlet,
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
