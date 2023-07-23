import 'package:flutter/material.dart';
import 'package:lp/screens/text_lessons_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextCoursesList extends StatefulWidget {
  const TextCoursesList({super.key});

  @override
  State<TextCoursesList> createState() {
    return _TextCoursesListState();
  }
}

class _TextCoursesListState extends State<TextCoursesList> {
  var textCourses = [];
  var content = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("text_courses").get().then(
      (querySnapshot) {
        var dataArray = querySnapshot.docs;
        setState(() {
          textCourses = dataArray.toList();
        });
        // for (var docSnapshot in querySnapshot.docs) {

        //   print('${docSnapshot.id} => ${docSnapshot.data()}');
        // }
      },
      onError: (e) => print("Error completing: $e"),
    );
    super.initState();
  }

  void _selectCourse(course, index) {
    print(course);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => TextLessonList(
                  title: course['title'],
                  courseId: textCourses[index].id,
                  // lessons: [],
                )));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("كورسات"),
      ),
      // body: content,
      body: textCourses.isEmpty
          ? content
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: textCourses.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> course = textCourses[index].data();
                return Card(
                  color: Colors.amber,
                  child: InkWell(
                      onTap: () {
                        _selectCourse(course, index);
                      },
                      child: Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Image.network(
                            course["img"],
                            height: 120,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(course["title"])
                        ]),
                      )),
                );
              }),
    );
  }
}
