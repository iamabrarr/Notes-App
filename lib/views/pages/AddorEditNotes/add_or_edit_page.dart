import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/models/notes_models.dart';
import 'package:notes/services/database.dart';
import 'package:notes/utils/size_config.dart';
import 'package:notes/views/constants/consts.dart';
import 'package:notes/views/pages/MyNotes/my_notes_page.dart';
import 'package:notes/views/widgets/custom_input_field.dart';

class AddorEditNotesPage extends StatefulWidget {
  const AddorEditNotesPage(
      {Key? key,
      required this.titleController,
      required this.descriptionController,
      this.selectedID})
      : super(key: key);
  final TextEditingController titleController, descriptionController;
  final int? selectedID;
  @override
  _AddorEditNotesPageState createState() => _AddorEditNotesPageState();
}

class _AddorEditNotesPageState extends State<AddorEditNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        leading: IconButton(
            onPressed: () {
              Get.offAll(MyNotes());
              widget.titleController.clear();
              widget.descriptionController.clear();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("Notes"),
        centerTitle: true,
      ),
      bottomSheet: Container(
        height: SizeConfig.heightMultiplier * 8,
        width: SizeConfig.widthMultiplier * 100,
        color: kPrimaryColor,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 5,
              width: SizeConfig.widthMultiplier * 80,
              // ignore: deprecated_member_use
              child: FlatButton(
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    if (widget.titleController.text.isNotEmpty) {
                      widget.selectedID != null
                          ? await NotesDatabase.instance.update(NotesModels(
                              id: widget.selectedID,
                              title: widget.titleController.text,
                              description: widget.descriptionController.text))
                          : await NotesDatabase.instance.add(NotesModels(
                              id: widget.selectedID,
                              title: widget.titleController.text,
                              description: widget.descriptionController.text));
                      widget.titleController.clear();
                      widget.descriptionController.clear();
                      Get.offAll(MyNotes());
                    }
                  },
                  child: Text(
                    widget.selectedID != null ? "Update" : "Save",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: SizeConfig.textMultiplier * 2,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 6,
              width: SizeConfig.widthMultiplier * 100,
              child: CustomInputField(
                isTitle: true,
                maxLines: 1,
                controller: widget.titleController,
                hintText: "Title",
              ),
            ),
            Expanded(
              flex: 9,
              child: CustomInputField(
                isTitle: false,
                maxLines: 1000,
                controller: widget.descriptionController,
                hintText: "Description",
              ),
            ),
            const Spacer(),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            )
          ],
        ),
      )),
    );
  }
}
