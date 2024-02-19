import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as path;
import "package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart";

import "../models/listin.dart";

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

  Future<int> insertListin(Listin listin) async {
    ListinTableCompanion novaLinha = ListinTableCompanion(
      name: Value(listin.name),
      obs: Value(listin.obs),
      dateCreate: Value(listin.dateCreate),
      dateUpdate: Value(listin.dateUpdate),
    );
    return await into(listinTable).insert(novaLinha);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "db.sqlite"));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  });
}
