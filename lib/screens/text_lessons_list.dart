import 'package:flutter/material.dart';
import 'package:lp/screens/text_lesson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextLessonList extends StatefulWidget {
  const TextLessonList({
    super.key,
    required this.title,
    required this.courseId,
  });
  final String title;
  final String courseId;
  // final List<TextLesson> lessons;

  @override
  State<TextLessonList> createState() {
    return _TextLessonListState();
  }
}

class _TextLessonListState extends State<TextLessonList> {
  var lessons = [];
  var content = const Center(child: CircularProgressIndicator());
  @override
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("text_lessons")
        .where("course_id", isEqualTo: widget.courseId)
        .get()
        .then(
      (querySnapshot) {
        var dataArray = querySnapshot.docs.map((e) => e.data());
        setState(() {
          lessons = dataArray.toList();
        });
        // for (var docSnapshot in querySnapshot.docs) {
        //   print('${docSnapshot.id} => ${docSnapshot.data()}');
        // }
      },
      onError: (e) => print("Error completing: $e"),
    );
    super.initState();
  }

  void _selectLesson(lesson) {
    print(lesson['title']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => TextLesson(
                  data: lesson,
                  title: lesson['title'],
                  // lessons: [],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: lessons.isEmpty
            ? content
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> lesson = lessons[index];
                  return Card(
                      color: Colors.white54,
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          _selectLesson(lesson);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                lesson["title"],
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text("$index"),
                            ],
                          ),
                        ),
                      ));
                }));
  }
}
