import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/models/notes_models.dart';
import 'package:notes/services/database.dart';
import 'package:notes/utils/size_config.dart';
import 'package:notes/views/constants/consts.dart';
import 'package:notes/views/constants/images.dart';
import 'package:notes/views/pages/AddorEditNotes/add_or_edit_page.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  int? selectedID;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(
          "My Notes",
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder<List<NotesModels>>(
              future: NotesDatabase.instance.getNotes(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NotesModels>> snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 35,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 0),
                          child: Lottie.asset(loading,
                              height: SizeConfig.imageSizeMultiplier * 30),
                        ),
                      ),
                    ],
                  );
                }
                return snapshot.data!.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 34,
                          ),
                          Center(
                              child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.widthMultiplier * 4),
                                child: Lottie.asset(noNotesGif,
                                    height:
                                        SizeConfig.imageSizeMultiplier * 30),
                              ),
                              Text("No Notes Found !!!")
                            ],
                          ))
                        ],
                      )
                    : Expanded(
                        child: AnimationLimiter(
                          child: ListView(
                            addAutomaticKeepAlives: false,
                            cacheExtent: 120,
                            padding: EdgeInsets.only(
                                top: SizeConfig.heightMultiplier * 1),
                            shrinkWrap: true,
                            children: snapshot.data!.map((notes) {
                              return AnimationConfiguration.staggeredList(
                                position: 2,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  horizontalOffset: 40,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(AddorEditNotesPage(
                                          selectedID: notes.id,
                                          titleController: titleController,
                                          descriptionController:
                                              descriptionController,
                                        ));
                                        setState(() {
                                          titleController.text = notes.title;
                                          descriptionController.text =
                                              notes.description;
                                        });
                                      },
                                      child: Container(
                                        width: SizeConfig.widthMultiplier * 100,
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.widthMultiplier * 3,
                                            right:
                                                SizeConfig.widthMultiplier * 3,
                                            bottom:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  // offset: Offset(0, 4),
                                                  blurRadius: 2),
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier * 2,
                                          horizontal:
                                              SizeConfig.widthMultiplier * 4,
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        60,
                                                    child: Text(
                                                      notes.title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith(
                                                              color:
                                                                  kSecondaryColor),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        NotesDatabase.instance
                                                            .delete(notes.id!);
                                                      });
                                                    },
                                                    child: Icon(Icons.delete,
                                                        color: Colors
                                                            .red.shade700),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                              ),
                                              SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        90,
                                                child: Text(notes.description,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color:
                                                                Colors.black)),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
              })
        ],
      )),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: kSecondaryColor,
        onPressed: () {
          Get.to(AddorEditNotesPage(
            selectedID: selectedID,
            titleController: titleController,
            descriptionController: descriptionController,
          ));
          titleController.clear();
          descriptionController.clear();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
