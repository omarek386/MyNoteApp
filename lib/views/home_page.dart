import 'package:asfasfasf/controller/notes_controller.dart';
import 'package:asfasfasf/views/add_new_note_page.dart';
import 'package:asfasfasf/views/details_page.dart';
import 'package:asfasfasf/views/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends StatelessWidget {
  final NotesController _controller = Get.put(NotesController());

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('HomePage'),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchBarDddd());
                  },
                  icon: Icon(Icons.search)),
              popUpMenu(controller: _controller)
            ],
          ),
          body: _controller.notes.isEmpty
              ? const LoadingView()
              : NoteView(controller: _controller),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddNewNotePage());
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class popUpMenu extends StatelessWidget {
  const popUpMenu({
    super.key,
    required NotesController controller,
  }) : _controller = controller;

  final NotesController _controller;

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> dropDown = ['Delete All'].map(
      (e) {
        return PopupMenuItem(
          value: e,
          child: Text(e),
        );
      },
    ).toList();
    return PopupMenuButton(
      itemBuilder: (context) => dropDown,
      onSelected: (value) {
        switch (value) {
          case 'Delete All':
            Get.defaultDialog(
              onConfirm: () {
                _controller.deleteAllNotes();
                Get.back();
              },
              middleText: "Are you sure you want to Delete All note",
              onCancel: () => Get.back(),
            );
            break;
        }
      },
    );
  }
}

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
    required NotesController controller,
  }) : _controller = controller;

  final NotesController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: _controller.notes.length,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 20.0,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () => Get.defaultDialog(
              onConfirm: () {
                _controller.deleteNote(_controller.notes[index].id!);
                Get.back();
              },
              middleText: "Are you sure you want to Delete this note",
              onCancel: () => Get.back(),
            ),
            onTap: () => Get.to(() => DetailsPage(
                  index: index,
                )),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //todo add note(title) from index
                    _controller.notes[index].title!,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    //todo add note(content) from index
                    _controller.notes[index].content!,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                    // overflow: TextOverflow.visible,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    //todo add note(date time) from index
                    _controller.notes[index].timeEdited!,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/note.json'),
        const SizedBox(
          height: 50,
        ),
        const Text(
          "You don't have any Notes",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
