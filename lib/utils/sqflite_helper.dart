import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'global.dart';

class SqfliteHelper {
  SqfliteHelper._privateConstructor();
  static SqfliteHelper instance = SqfliteHelper._privateConstructor();

  late Database _database;
  var dbName = 'gv52psk2.db';

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    var database = join(path, dbName);
    _database = await openDatabase(database, version: 1,
        onCreate: (Database db, version) async {
      db.execute(
        'CREATE TABLE files (id INTEGER PRIMARY KEY, fileType VARCHAR, hash VARCHAR,  dateTime VARCHAR, is_favorite VARCHAR)',
      );
    });
  }

  Future<List<GlobalFile>> loadFiles() async {
    List<GlobalFile> _tempFileList = [];
    final _value = await _database.rawQuery('SELECT * FROM files');
    _value.forEach((file) {
      int _id = file['id'] as int;
      String _fileTypeValue = file['fileType'] as String;
      String _hash = file['hash'] as String;
      String _dateTimeValue = file['dateTime'] as String;
      String _isFavoriteValue = file['is_favorite'] as String;

      var fileModel = GlobalFile(
          id: _id,
          fileType: setFileType(_fileTypeValue),
          hash: _hash,
          dateTime: DateTime.parse(_dateTimeValue),
          isFav: setFavoriteVal(_isFavoriteValue));
      _tempFileList.add(fileModel);
    });
    return _tempFileList;
  }

  Future<void> insertFiles(GlobalFile globalFile) async {
    await _database.rawInsert(
      'INSERT INTO files (fileType, hash, dateTime, is_favorite) VALUES (?,?,?,?)',
      [
        getFileType(globalFile.fileType),
        globalFile.hash,
        '${globalFile.dateTime}',
        getFavoriteVal(globalFile.isFav!),
      ],
    );
  }

  String getFavoriteVal(IsFavorite val) {
    switch (val) {
      case IsFavorite.yes:
        return '0';
      case IsFavorite.no:
        return '1';
    }
  }

  IsFavorite setFavoriteVal(String val) {
    var _tempFavoriteVal;
    switch (val) {
      case '0':
        _tempFavoriteVal = IsFavorite.yes;
        break;
      case '1':
        _tempFavoriteVal = IsFavorite.no;
        break;
    }
    return _tempFavoriteVal;
  }

  String getFileType(FileType val) {
    switch (val) {
      case FileType.image:
        return '0';
      case FileType.voice:
        return '1';
      case FileType.video:
        return '2';
      case FileType.file:
        return '3';
    }
  }

  FileType setFileType(String val) {
    var _tempFileType;
    switch (val) {
      case '0':
        _tempFileType = FileType.image;
        break;

      case '1':
        _tempFileType = FileType.voice;
        break;

      case '2':
        _tempFileType = FileType.video;
        break;

      case '3':
        _tempFileType = FileType.file;
        break;
    }
    return _tempFileType;
  }
}
