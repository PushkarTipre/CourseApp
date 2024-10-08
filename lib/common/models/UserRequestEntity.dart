class UserRequestEntity {
  String? username;
  String? description;
  String? avatar;
  String? job;

  UserRequestEntity({
    this.username,
    this.description,
    this.avatar,
    this.job,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "avatar": avatar,
        "job": job,
      };

  factory UserRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRequestEntity(
        username: json["username"],
        description: json["description"],
        avatar: json["avatar"],
        job: json["job"],
      );
}
