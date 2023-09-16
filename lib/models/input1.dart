// To parse this JSON data, do
//
//     final input1 = input1FromJson(jsonString);

import 'dart:convert';

Input1 input1FromJson(String str) => Input1.fromJson(json.decode(str));

String input1ToJson(Input1 data) => json.encode(data.toJson());

class Input1 {
    Data data;
    dynamic message;

    Input1({
        required this.data,
        required this.message,
    });

    factory Input1.fromJson(Map<String, dynamic> json) => Input1(
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

  get inletSteam => null;

  get exmSteam => null;

  get ocLubOilOutlet => null;

  get turbinThrustBearing => null;

  get tbGovSide => null;

  get tbCoupSide => null;

  get pbTbnSide => null;

  get pbGenSide => null;

  get wbTbnSide => null;

  get wbGenSide => null;

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    int id;
    double inletSteam;
    double exmSteam;
    double turbinThrustBearing;
    double tbGovSide;
    double tbCoupSide;
    double pbTbnSide;
    double pbGenSide;
    double wbTbnSide;
    int wbGenSide;
    int ocLubOilOutlet;
    // DateTime createdAt;
    // DateTime updatedAt;
    // User user;

    Data({
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
        // required this.createdAt,
        // required this.updatedAt,
        // required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        inletSteam: json["inlet_steam"]?.toDouble(),
        exmSteam: json["exm_steam"]?.toDouble(),
        turbinThrustBearing: json["turbin_thrust_bearing"]?.toDouble(),
        tbGovSide: json["tb_gov_side"]?.toDouble(),
        tbCoupSide: json["tb_coup_side"]?.toDouble(),
        pbTbnSide: json["pb_tbn_side"]?.toDouble(),
        pbGenSide: json["pb_gen_side"]?.toDouble(),
        wbTbnSide: json["wb_tbn_side"]?.toDouble(),
        wbGenSide: json["wb_gen_side"],
        ocLubOilOutlet: json["oc_lub_oil_outlet"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // user: User.fromJson(json["user"]),
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
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "user": user.toJson(),
    };
}

class User {
    User();

    factory User.fromJson(Map<String, dynamic> json) => User(
    );

    Map<String, dynamic> toJson() => {
    };
}