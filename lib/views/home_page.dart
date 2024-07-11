import 'package:asfasfasf/controller/notes_controller.dart';
import 'package:asfasfasf/views/add_new_note_page.dart';
import 'package:asfasfasf/views/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          appBar: AppBar(title: const Text('HomePage')),
          body: NewView(controller: _controller),
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

class NewView extends StatelessWidget {
  const NewView({
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
            onLongPress: () =>
                _controller.deleteNote(_controller.notes[index].id!),
            onTap: () => Get.to(() => DetailsView(
                  index: index,
                )),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //todo add note(title) from index
                    _controller.notes[index].title!,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //todo add note(content) from index
                    _controller.notes[index].content!,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                    // overflow: TextOverflow.visible,
                  ),
                  SizedBox(
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

class OldView extends StatelessWidget {
  const OldView({
    super.key,
    required NotesController controller,
  }) : _controller = controller;

  final NotesController _controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < _controller.notes.length; i++)
            Card(
              color: Colors.grey,
              shadowColor: Colors.black,
              elevation: 10,
              child: Column(
                children: [
                  Text(
                    _controller.notes[i].title!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 100,
                    width: 1000,
                  ),
                  Text(
                    _controller.notes[i].content!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    _controller.notes[i].timeCreated!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    _controller.notes[i].timeEdited!,
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
