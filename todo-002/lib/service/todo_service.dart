// ignore_for_file: constant_identifier_names, unused_field

import 'package:sqflite/sqflite.dart';

const TBL_TODO = "tbl_todolist";
// """ : 연속된 문자열
const createTodoTable = """
CREATE TABLE $TBL_TODO (
  id TEXT,
  sdate TEXT,
  stime TEXT,
  edate TEXT,
  etime TEXT,
  complete INTEGER
)
""";

class TodoService {
  late Database _database;

  onCreateTable(db, version) async {
    return db.execute(createTodoTable);
  }

// 스키마 변경 시 기존 테이블 제거 후 새로 테이블 만들기
  onUpgradeTable(db, oldVersion, newVersion) async {
    // batch : 트랜젝션 발생할 때 이렇게 해줘
    final batch = await db.batch();
    await batch.execute("DROP TABLE $TBL_TODO");
    await batch.execute(createTodoTable);
    await batch.commit();
  }
}
