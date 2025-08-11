import 'package:talim/Models/child_model.dart';

class Anakapi {
  static Future<List<ChildModel>> getChildren() async {
    await Future.delayed(Duration(milliseconds: 500)); // simulasi loading

    return [
      ChildModel(
          id: 1,
          name: "Budi Pratama",
          className: "TK B1",
          nisn: "0078653930123"),
      ChildModel(
          id: 2,
          name: "Aisya Nur Hidayah",
          className: "TK A1",
          nisn: "0088653233443"),
    ];
  }
}
