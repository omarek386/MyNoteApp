import 'dart:developer';
import 'package:share/share.dart';

import 'package:asfasfasf/controller/database_service.dart';
import 'package:asfasfasf/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:string_stats/string_stats.dart';

class NotesController extends GetxController {
  final MySqlDatabaseService _database = MySqlDatabaseService();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<Note> notes = <Note>[];
  int contentWordCount = 0;
  int contentCharCount = 0;

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  getAllNotes() async {
    notes = await _database.getNotesList();
    update();
  }

  isEmpty() {
    if (notes.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void addNote() async {
    String title = titleController.text;
    String content = contentController.text;
    String timeCreated =
        DateFormat('MMM dd yyy  HH:mm:ss').format(DateTime.now());
    String timeEdited =
        DateFormat('MMM dd yyy  HH:mm:ss').format(DateTime.now());
    Note note = Note(
        content: content,
        timeCreated: timeCreated,
        timeEdited: timeEdited,
        title: title);
    await _database.addNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = '';
    contentController.text = '';
    getAllNotes();
    //* print
    log('note added $note == $notes');

    Get.back();
  }

  deleteNote(int id) async {
    Note note = Note(id: id);
    await _database.deleteNote(note);
    getAllNotes();
  }

  deleteAllNotes() async {
    await _database.deleteAllNotes();
    getAllNotes();
  }

  updateNote({required int id, required String timeCreated}) async {
    String title = titleController.text;
    String content = contentController.text;
    String timeEdited =
        DateFormat('MMM dd yyy  HH:mm:ss').format(DateTime.now());
    Note note = Note(
        id: id,
        content: content,
        timeEdited: timeEdited,
        title: title,
        timeCreated: timeCreated);
    await _database.updateNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = '';
    contentController.text = '';
    getAllNotes();
    Get.back();
  }

  void shareNote(String title, String content) {
    Share.share('''$title 
    $content
    Made By omar Khalifa''');
  }
}
