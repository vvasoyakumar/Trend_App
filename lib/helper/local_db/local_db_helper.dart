import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trend_radar/models/local_db_model.dart';

import '../../utils/custom_print.dart';

class LocalDBHelper {
  static const dbName = "trend_radar.db";
  static const colId = "id";
  static const colVideoId = "video_id";
  static const favouriteTable = "favourite";

  static Database? db;

  static Future<void> initDB({required String tableName}) async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});

    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colVideoId TEXT)");
  }

  static Future<int?> saveVideo({required String videoId}) async {
    await initDB(tableName: favouriteTable);
    String query = "INSERT INTO $favouriteTable($colVideoId) VALUES(?)";
    List args = [videoId];
    customPrint("saveVideo ===>>> videoId : $videoId");
    return await db?.rawInsert(query, args);
  }

  static Future<int?> unSaveVideo({required int id}) async {
    await initDB(tableName: favouriteTable);
    customPrint("unSaveVideo ===>>> id : $id");
    return await db?.delete(favouriteTable, where: '$colId = ?', whereArgs: [id]);
  }

  static Future<List<LocalSaveVideoModel>> fetchAllSavedVideos() async {
    await initDB(tableName: favouriteTable);
    String query = "SELECT * FROM $favouriteTable";
    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    customPrint("fetchAllSavedVideos ===>>> $data");
    List<LocalSaveVideoModel> savedVideos =
        data.map((e) => LocalSaveVideoModel(id: e[colId], videoId: e[colVideoId])).toList();
    return savedVideos;
  }
}
