import 'dart:convert';

UserForms userFormsFromJson(String str) => UserForms.fromJson(json.decode(str));

String userFormsToJson(UserForms data) => json.encode(data.toJson());

class UserForms {
    UserForms({
        this.status,
        this.message,
    });

    bool status;
    List<Map<String, String>> message;

    factory UserForms.fromJson(Map<String, dynamic> json) => UserForms(
        status: json["status"],
        message: List<Map<String, String>>.from(json["message"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
    };
}
