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
        leading: IconButton(
            onPressed: () {
              Get.defaultDialog(
                confirmTextColor: Colors.black54,
                buttonColor: Colors.amber,
                onConfirm: () {
                  Get.back();
                  _controller.addNote();
                  Get.back();
                },
                middleText: "Are you sure you want to exit with out saving?",
                textConfirm: 'Save',
                textCancel: 'Discard',
                onCancel: () {
                  Get.back();
                  Get.back();
                },
              );
            },
            icon: const Icon(Icons.arrow_back)),
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
