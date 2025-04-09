class CourseCategoryResponseEntity {
  int? code;
  String? msg;
  List<CourseCategory>? data;

  CourseCategoryResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory CourseCategoryResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseCategoryResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<CourseCategory>.from(
                json["data"].map((x) => CourseCategory.fromJson(x))),
      );
}

class CourseCategory {
  String? title;
  int? id;

  CourseCategory({
    this.title,
    this.id,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) => CourseCategory(
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
      };
}
