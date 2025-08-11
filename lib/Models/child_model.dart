class ChildModel {
  final int id;
  final String name;
  final String className;
  final String nisn;

  ChildModel({
    required this.id,
    required this.name,
    required this.className,
    required this.nisn,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'],
      name: json['name'],
      className: json['className'],
      nisn: json['nisn'],
    );
  }
}
