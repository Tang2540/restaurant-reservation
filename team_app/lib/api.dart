import "dart:async";
import "dart:convert";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:http/http.dart";

// Existing TableR class
class TableR {
  int id;
  final String name;
  String dbId = '';

  TableR(this.id, this.name);
  factory TableR.fromSnapshot(Map<String, dynamic> json) {
    var id = json['id'];
    int parseId = id is String ? int.parse(id) : id;
    return TableR(parseId, json['name'] as String);
  }

  factory TableR.fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    int parseId = id is String ? int.parse(id) : id;
    return TableR(parseId, json['name'] as String);
  }
}

class Booking {
  final int id;
  final int tableId;
  final dynamic date;
  String dbId = "";

  Booking(this.id, this.tableId, this.date);

  factory Booking.fromSnapshot(Map<String, dynamic> json) {
    var tableId = json['tableId'];
    // Convert tableId to int if it's a string
    int parsedTableId = tableId is String ? int.parse(tableId) : tableId;

    return Booking(
      json['id'] is String ? int.parse(json['id']) : json['id'],
      parsedTableId,
      json['date'] as dynamic,
    );
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    var tableId = json['tableId'];
    // Convert tableId to int if it's a string
    int parsedTableId = tableId is String ? int.parse(tableId) : tableId;

    return Booking(
      json['id'] is String ? int.parse(json['id']) : json['id'],
      parsedTableId,
      json['date'] as dynamic,
    );
  }
}

class AllBookings {
  final List<Booking> bookings;
  AllBookings(this.bookings);

  factory AllBookings.fromSnapshot(QuerySnapshot qs) {
    List<Booking> bookings;
    bookings = qs.docs.map((DocumentSnapshot ds) {
      Booking booking = Booking.fromSnapshot(ds.data() as Map<String, dynamic>);
      booking.dbId = ds.id;
      return booking;
    }).toList();
    return AllBookings(bookings);
  }

  factory AllBookings.fromJson(List<dynamic> json) {
    List<Booking> bookings =
        json.map((item) => Booking.fromJson(item)).toList();
    return AllBookings(bookings);
  }
}

class AllTables {
  final List<TableR> tables;
  AllTables(this.tables);

  factory AllTables.fromSnapshot(QuerySnapshot qs) {
    List<TableR> tables;
    tables = qs.docs.map((DocumentSnapshot ds) {
      TableR table = TableR.fromSnapshot(ds.data() as Map<String, dynamic>);
      table.dbId = ds.id;
      return table;
    }).toList();
    return AllTables(tables);
  }

  factory AllTables.fromJson(List<dynamic> json) {
    List<TableR> tables;
    tables = json.map((item) => TableR.fromJson(item)).toList();
    return AllTables(tables);
  }
}

abstract class PostService {
  Future<List<TableR>> getTables();
  Future<List<dynamic>> getTableBookings(int tableId);
}

class PostFirebaseService implements PostService {
  Client client = Client();

  @override
  Future<List<TableR>> getTables() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('tables').get();
    AllTables all = AllTables.fromSnapshot(qs);
    return all.tables..sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  Future<List<dynamic>> getTableBookings(int tableId) async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection('booking')
          .where('tableId', isEqualTo: tableId)
          .get();

      // Convert query results to list of maps
      return qs.docs.map((data) => data['date'] as dynamic).toList();
    } catch (e) {
      print('Error searching in Firebase: $e');
      return [];
    }
  }
}

class PostController {
  List<TableR> tables = List.empty();
  List<dynamic> bookings = List.empty();
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

  // New method to fetch bookings for a specific table
  Future<List<dynamic>> fetchTableBookings(int tableId) async {
    onSyncController.add(true);
    final bookings = await service.getTableBookings(tableId);
    onSyncController.add(false);
    return bookings;
  }
}
