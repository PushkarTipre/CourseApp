import 'dart:developer';

class CheckVideoAccessResponseEntity {
  final int? code;
  final String? msg;
  final bool? hasAccess;

  CheckVideoAccessResponseEntity({
    this.code,
    this.msg,
    this.hasAccess,
  });

  factory CheckVideoAccessResponseEntity.fromJson(Map<String, dynamic> json) {
    log('Parsed JSON Response: $json'); // Log the parsed response.

    // Safely access the nested 'has_access' field inside 'data'.
    bool hasAccessValue =
        json['data'] != null && json['data']['has_access'] != null
            ? json['data']['has_access']
            : false;

    return CheckVideoAccessResponseEntity(
      code: json['code'],
      msg: json['msg'],
      hasAccess: hasAccessValue, // Use the parsed value here.
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'has_access': hasAccess,
    };
  }
}
