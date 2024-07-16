// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asfasfasf/views/ediet_view.dart';
import 'package:asfasfasf/views/home_page.dart';
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
      appBar: AppBar(
        title: const Text('Details '),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => EditPage(index: index)),
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                confirmTextColor: Colors.black54,
                                buttonColor: Colors.amber,
                                onConfirm: () {
                                  _controller
                                      .deleteNote(_controller.notes[index].id!);
                                  Get.offAll(HomePage());
                                },
                                middleText:
                                    "Are you sure you want to Delete this note",
                                onCancel: () => Get.back(),
                              );
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.delete,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextButton(
                            onPressed: () {
                              _controller.shareNote(
                                _controller.notes[index].title!,
                                _controller.notes[index].content!,
                              );
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.share,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Created :  ${_controller.notes[index].timeCreated!}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Content Word Count :  ${_controller.notes[index].contentWordCount.toString()}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Content Character Count :  ${_controller.notes[index].contentCharCount.toString()}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 150,
                              ),
                              const Text(
                                "Created by Omar Khalifa",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                );
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: GetBuilder<NotesController>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    _controller.notes[index].title!,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Last Edited : ${_controller.notes[index].timeEdited!}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableText(
                    _controller.notes[index].content!,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TitleText() {
    return Text(
      _controller.notes[index].title!,
      style: const TextStyle(
          fontSize: 27, fontWeight: FontWeight.bold, letterSpacing: 1),
    );
  }

  Widget ContentText() {
    return Text(_controller.notes[index].content!,
        style: const TextStyle(
          fontSize: 22,
        ));
  }
}
