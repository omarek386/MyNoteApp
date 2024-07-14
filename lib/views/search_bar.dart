import 'package:asfasfasf/controller/notes_controller.dart';
import 'package:asfasfasf/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchBarDddd extends SearchDelegate {
  NotesController controller = Get.find<NotesController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestList = query.isEmpty
        ? controller.notes
        : controller.notes.where(
            (element) {
              return element.title!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  element.content!.toLowerCase().contains(query.toLowerCase());
            },
          ).toList();
    return Container(
      padding: const EdgeInsets.all(10),
      child: StaggeredGridView.countBuilder(
        itemCount: suggestList.length,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(DetailsPage(
                index: index,
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(10, 10),
                    blurRadius: 15,
                  )
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestList[index].title!,
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
                    suggestList[index].content!,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(controller.notes[index].timeEdited!)
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      ),
    );
  }
}
