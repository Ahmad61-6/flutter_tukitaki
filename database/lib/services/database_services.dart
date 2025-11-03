import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/models/notes.dart';

class SqfliteService {
  static Database? _db;
  static final SqfliteService _instance = SqfliteService._internal();

  // Updated service name for cleaner log filtering
  final String _serviceName = '[SqfliteService]';

  // Table and Column Names
  final String _notesTableName = 'notes';
  final String _notesIdColumnName = 'id';
  final String _notesTitleColumnName = 'title';
  final String _notesContentColumnName = 'content';

  static SqfliteService get instance => _instance;

  SqfliteService._internal();

  /// Lazily initializes the database.
  Future<Database> get database async {
    if (_db != null) {
      log('ℹ️ Returning existing database instance', name: _serviceName);
      return _db!;
    }
    _db = await _getDatabase();
    return _db!;
  }

  /// Opens the database, creating it if it doesn't exist.
  Future<Database> _getDatabase() async {
    log('🗄️ Initializing database...', name: _serviceName);
    try {
      final dbDirPath = await getDatabasesPath();
      final dbPath = join(dbDirPath, 'todo_database.db');
      final db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database db, int version) async {
          log('ℹ️ Database onCreate: Creating tables...', name: _serviceName);
          try {
            await db.execute('''
              CREATE TABLE $_notesTableName (
                $_notesIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
                $_notesTitleColumnName TEXT NOTNULL,
                $_notesContentColumnName TEXT
              )
            ''');
            log('✅ Table "notes" created successfully', name: _serviceName);
          } catch (e, s) {
            log(
              '❌ Error creating table',
              error: e,
              stackTrace: s,
              name: _serviceName,
            );
          }
        },
      );
      log('✅ Database initialized successfully', name: _serviceName);
      return db;
    } catch (e, s) {
      log(
        '❌ Error initializing database',
        error: e,
        stackTrace: s,
        name: _serviceName,
      );
      throw Exception('Failed to initialize database: $e');
    }
  }

  /// Closes the database connection.
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      log('🗄️ Database closed', name: _serviceName);
    }
  }

  // --- CRUD METHODS ---

  /// Creates a new note in the database.
  Future<Note?> createNote(Note note) async {
    try {
      final db = await database;
      final id = await db.insert(
        _notesTableName,
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log('✅ Note created with id: $id', name: _serviceName);
      return note.id == null
          ? Note(id: id, title: note.title, content: note.content)
          : note;
    } catch (e, s) {
      log('❌ Error creating note', error: e, stackTrace: s, name: _serviceName);
      return null;
    }
  }

  /// Reads a single note from the database by its ID.
  Future<Note?> getNote(int id) async {
    try {
      final db = await database;
      final maps = await db.query(
        _notesTableName,
        where: '$_notesIdColumnName = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        log('✅ Note read: $id', name: _serviceName);
        return Note.fromMap(maps.first);
      } else {
        log('⚠️ Note not found: $id', name: _serviceName);
        return null;
      }
    } catch (e, s) {
      log(
        '❌ Error reading note: $id',
        error: e,
        stackTrace: s,
        name: _serviceName,
      );
      return null;
    }
  }

  /// Reads all notes from the database.
  Future<List<Note>> getAllNotes() async {
    try {
      final db = await database;
      final maps = await db.query(_notesTableName);

      final notes = maps.map((map) => Note.fromMap(map)).toList();
      log('✅ Read ${notes.length} notes', name: _serviceName);
      return notes;
    } catch (e, s) {
      log(
        '❌ Error reading all notes',
        error: e,
        stackTrace: s,
        name: _serviceName,
      );
      return []; // Return an empty list on error
    }
  }

  /// Updates an existing note in the database.
  Future<int> updateNote(Note note) async {
    try {
      final db = await database;
      final result = await db.update(
        _notesTableName,
        note.toMap(),
        where: '$_notesIdColumnName = ?',
        whereArgs: [note.id],
      );
      log('✅ Note updated: ${note.id}', name: _serviceName);
      return result; // Returns number of rows affected
    } catch (e, s) {
      log(
        '❌ Error updating note: ${note.id}',
        error: e,
        stackTrace: s,
        name: _serviceName,
      );
      return 0;
    }
  }

  /// Deletes a note from the database by its ID.
  Future<int> deleteNote(int id) async {
    try {
      final db = await database;
      final result = await db.delete(
        _notesTableName,
        where: '$_notesIdColumnName = ?',
        whereArgs: [id],
      );
      log('✅ Note deleted: $id', name: _serviceName);
      return result; // Returns number of rows affected
    } catch (e, s) {
      log(
        '❌ Error deleting note: $id',
        error: e,
        stackTrace: s,
        name: _serviceName,
      );
      return 0;
    }
  }
}
