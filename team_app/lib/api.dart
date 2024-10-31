import "dart:async";
import "dart:convert";
import "package:http/http.dart";

class TableR {
  int id;
  final String name;
  List date;

  TableR(this.id, this.name, this.date);
  factory TableR.fromJson(Map<String, dynamic> json) {
    return TableR(
        json['id'] as int, json['name'] as String, json['date'] as List);
  }
}

class AllTables {
  final List<TableR> tables;
  AllTables(this.tables);
  factory AllTables.fromJson(List<dynamic> json) {
    List<TableR> tables;
    tables = json.map((item) => TableR.fromJson(item)).toList();
    return AllTables(tables);
  }
}

abstract class PostService {
  Future<List<TableR>> getTables();
}

class PostHttpService implements PostService {
  Client client = Client();

  @override
  Future<List<TableR>> getTables() async {
    final res = await client.get(Uri.parse("http://localhost:3000/tables"));

    if (res.statusCode == 200) {
      var all = AllTables.fromJson(json.decode(res.body));
      return all.tables;
    }

    throw Exception("Fail to load posts");
  }
}

class PostController {
  List<TableR> tables = List.empty();
  final PostService service;

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  PostController(this.service);

  Future<List<TableR>> fetchTables() async {
    onSyncController.add(true);
    tables = await service.getTables();
    onSyncController.add(false);
    return tables;
  }
}
