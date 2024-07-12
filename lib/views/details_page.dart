// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asfasfasf/controller/notes_controller.dart';

class DetailsPage extends StatelessWidget {
  final NotesController _controller = Get.find();
  int index;
  DetailsPage({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EdietPage')),
      body: Container(),
    );
  }
}
