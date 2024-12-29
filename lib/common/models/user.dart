import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRequestEntity {
  int? type;
  String? name;
  String? description;
  String? email;
  String? phone;
  String? avatar;
  String? open_id;
  int? online;

  LoginRequestEntity({
    this.type,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.avatar,
    this.open_id,
    this.online,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "description": description,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "open_id": open_id,
        "online": online,
      };
}

//api post response msg
class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserProfile? data;

  UserLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: UserProfile.fromJson(json["data"]),
      );
}

// login result
class UserProfile {
  String? unique_id;
  String? access_token;
  String? token;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;
  String? job;
  String? id;

  UserProfile({
    this.unique_id,
    this.access_token,
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type,
    this.job,
    this.id,
  });

  UserProfile copyWith({
    String? unique_id,
    String? access_token,
    String? token,
    String? name,
    String? description,
    String? avatar,
    int? online,
    int? type,
    String? job,
    String? id,
  }) {
    return UserProfile(
      unique_id: unique_id ?? this.unique_id,
      access_token: access_token ?? this.access_token,
      token: token ?? this.token,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      online: online ?? this.online,
      type: type ?? this.type,
      job: job ?? this.job,
      id: id ?? this.id,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      unique_id: json["unique_id"],
      access_token: json["access_token"],
      token: json["token"],
      name: json["name"],
      description: json["description"],
      avatar: json["avatar"],
      online: json["online"],
      type: json["type"],
      job: json["job"],
      id: json["id"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "unique_id": unique_id,
        "access_token": access_token,
        "token": token,
        "name": name,
        "description": description,
        "avatar": avatar,
        "online": online,
        "type": type,
        "job": job,
        "id": id,
      };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      token: data?['token'],
      name: data?['name'],
      avatar: data?['avatar'],
      description: data?['description'],
      online: data?['online'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}
