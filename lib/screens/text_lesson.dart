import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';

class TextLesson extends StatefulWidget {
  const TextLesson({super.key, required this.data, required this.title});

  final Object data;
  final String title;

  @override
  State<TextLesson> createState() {
    return _TextLessonState();
  }
}

class _TextLessonState extends State<TextLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Column(
          children: [
            Text('data'),
            Row(
              children: [Text("data"), Text("data")],
            )
          ],
        ));
  }
}
