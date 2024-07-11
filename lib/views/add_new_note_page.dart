import 'package:asfasfasf/controller/notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewNotePage extends StatelessWidget {
  final NotesController _controller = Get.find();

  AddNewNotePage({super.key});
  @override
  Widget build(BuildContext context) {
    _controller.titleController.text = '';
    _controller.contentController.text = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Note'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleInput(),
              contentInput(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.addNote();
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.save,
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
      style: TextStyle(fontSize: 22),
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
