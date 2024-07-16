// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asfasfasf/controller/notes_controller.dart';

class EditPage extends StatelessWidget {
  int index;
  EditPage({
    super.key,
    required this.index,
  });
  final NotesController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.titleController.text = _controller.notes[index].title!;
    _controller.contentController.text = _controller.notes[index].content!;
    log(_controller.notes[index].title.toString());
    log(_controller.notes[index].id.toString());
    log(_controller.notes[index].timeCreated.toString());
    return Scaffold(
      appBar: AppBar(
          title: const Text('Edit'),
          leading: IconButton(
              onPressed: () {
                if (_controller.titleController.text !=
                        _controller.notes[index].title ||
                    _controller.contentController.text !=
                        _controller.notes[index].content) {
                  Get.defaultDialog(
                    confirmTextColor: Colors.black54,
                    buttonColor: Colors.amber,
                    onConfirm: () {
                      Get.back();
                      _controller.updateNote(
                          id: _controller.notes[index].id!,
                          timeCreated: _controller.notes[index].timeCreated!);
                      Get.back();
                    },
                    middleText:
                        "Are you sure you want to exit with out saving?",
                    textConfirm: 'Save',
                    textCancel: 'Discard',
                    onCancel: () {
                      Get.back();
                      Get.back();
                    },
                  );
                } else {
                  Get.back();
                }
              },
              icon: const Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: <Widget>[
              titleInput(),
              contentInput(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.updateNote(
              id: _controller.notes[index].id!,
              timeCreated: _controller.notes[index].timeCreated!);
        },
        child: const Icon(
          Icons.edit_note_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget titleInput() {
    return TextField(
      controller: _controller.titleController,
      style: const TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
    );
  }

  Widget contentInput() {
    return TextField(
      style: const TextStyle(fontSize: 22),
      maxLines: null,
      controller: _controller.contentController,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Content',
        hintStyle: TextStyle(
          fontSize: 22,
        ),
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}
