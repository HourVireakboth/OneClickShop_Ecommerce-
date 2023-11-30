import 'dart:convert';

VerfiySms verfiySmsFromJson(String str) => VerfiySms.fromJson(json.decode(str));

String verfiySmsToJson(VerfiySms data) => json.encode(data.toJson());

class VerfiySms {
    String? otp;

    VerfiySms({
        this.otp,
    });

    factory VerfiySms.fromJson(Map<String, dynamic> json) => VerfiySms(
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
    };
}