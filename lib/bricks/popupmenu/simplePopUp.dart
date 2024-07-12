import 'package:flutter/material.dart';
import 'package:get/get.dart';

class popUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> dropDown = ['Delete All'].map(
      (e) {
        return PopupMenuItem(
          child: Text(e),
          value: e,
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
