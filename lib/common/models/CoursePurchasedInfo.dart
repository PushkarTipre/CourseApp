class CoursePurchaseResponseEntity {
  final int code;
  final bool status; // Ensure this is `bool` to match API response.
  final List<CoursePurchaseData> data;

  CoursePurchaseResponseEntity({
    required this.code,
    required this.status,
    required this.data,
  });

  factory CoursePurchaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      CoursePurchaseResponseEntity(
        code: json["code"],
        status: json["status"], // Make sure this maps correctly.
        data: (json["data"] as List<dynamic>)
            .map((x) => CoursePurchaseData.fromJson(x))
            .toList(),
      );
}

class CoursePurchaseData {
  final int id;
  final String userToken;
  final String totalAmount;
  final int courseId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String courseName;
  final String description;
  final String thumbnail;

  CoursePurchaseData({
    required this.id,
    required this.userToken,
    required this.totalAmount,
    required this.courseId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.courseName,
    required this.description,
    required this.thumbnail,
  });

  factory CoursePurchaseData.fromJson(Map<String, dynamic> json) =>
      CoursePurchaseData(
        id: json["id"] ?? 0,
        userToken: json["user_token"] ?? "",
        totalAmount: json["total_amount"] ?? "",
        courseId: json["course_id"] ?? 0,
        status: json["status"] ?? 0,
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime.now(), // Default to current date if null
        courseName: json["course_name"] ?? "",
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
      );
}
