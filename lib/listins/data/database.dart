import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as path;

part "database.g.dart";

class ListinTable extends Table {
  IntColumn get id => integer().named("id").autoIncrement()();
  TextColumn get name => text().named("name").withLength(min: 4, max: 30)();
  TextColumn get obs => text().named("obs")();
  DateTimeColumn get dateCreate => dateTime().named("dateCreate")();
  DateTimeColumn get dateUpdate => dateTime().named("dateUpdate")();
}

@DriftDatabase(tables: [ListinTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "db.sqlite"));

    return NativeDatabase.createInBackground(file);
  });
}
