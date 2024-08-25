class BaseResponseEntity {
  int? code;
  String? msg;
  dynamic data; // Change the type from String? to dynamic

  BaseResponseEntity({this.code, this.msg, this.data});

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) {
    return BaseResponseEntity(
      code: json['code'],
      msg: json['msg'],
      data: json['data'], // This can be a Map, String, or anything else
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data,
    };
  }
}
