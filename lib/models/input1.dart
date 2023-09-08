// To parse this JSON data, do
//
//     final category = categoryFromJson(jsondouble);

import 'dart:convert';

List<Input1> input1FromJson(String str) => List<Input1>.from(
      json.decode(str).map(
            (x) => Input1.fromJson(x),
          ),
    );

String input1ToJson(List<Input1> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class Input1 {
  int id;
  int user_id;
  double inlet_steam;	
  double exm_steam;
  double turbin_thrust_bearing;	
  double tb_gov_side;	
  double tb_coup_side;	
  double pb_tbn_side;	
  double pb_gen_side;	
  double wb_tbn_side;	
  double wb_gen_side;	
  double oc_lub_oil_outlet;

  Input1({
    required this.id,
    required this.user_id,
    required this.inlet_steam,	
    required this.exm_steam,
    required this.turbin_thrust_bearing,	
    required this.tb_gov_side,	
    required this.tb_coup_side,	
    required this.pb_tbn_side,	
    required this.pb_gen_side,	
    required this.wb_tbn_side,	
    required this.wb_gen_side,	
    required this.oc_lub_oil_outlet,
  });



  factory Input1.fromJson(Map<String, dynamic> json) => Input1(
        id: json["id"],
        user_id: json["user_id"],
        inlet_steam: json["inlet_steam"], 
        exm_steam: json["exm_steam"],
        turbin_thrust_bearing: json["turbin_thrust_bearing"],
        tb_gov_side: json["tb_gov_side"],
        tb_coup_side: json["tb_coup_side"],
        pb_tbn_side: json["pb_tbn_side"],
        pb_gen_side: json["pb_gen_side"],
        wb_tbn_side: json["wb_tbn_side"],
        wb_gen_side: json["wb_gen_side"],
        oc_lub_oil_outlet: json["oc_lub_oil_outlet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,	
        "inlet_steam": inlet_steam,
        "exm_steam": exm_steam,
        "turbin_thrust_bearing": turbin_thrust_bearing,
        "tb_gov_side": tb_gov_side,
        "tb_coup_side": tb_coup_side,
        "pb_tbn_side": pb_tbn_side,
        "pb_gen_side": pb_gen_side,
        "wb_tbn_side": wb_gen_side,
        "wb_gen_side": wb_gen_side,
        "oc_lub_oil_outlet": oc_lub_oil_outlet,
      };
}
