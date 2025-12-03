import 'package:flutter/material.dart';
import 'package:learn_english/models/topic.dart';
import 'package:learn_english/services/topic_service.dart';

class TopicEditScreen extends StatefulWidget {
  final Topic topic;

  TopicEditScreen({required this.topic});

  @override
  State<TopicEditScreen> createState() => TopicEditScreenState();
}

class TopicEditScreenState extends State<TopicEditScreen> {
  late TextEditingController name;
  late TextEditingController description;
  final TopicService service = TopicService();

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.topic.name);
    description = TextEditingController(text: widget.topic.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chỉnh sửa bộ từ")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Tên bộ từ",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: description,
              decoration: InputDecoration(
                labelText: "Mô tả",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await service.updateTopic(
                  widget.topic.id,
                  name.text,
                  description.text,
                );
                Navigator.pop(context);
                // Cập nhật logic ở đây
              },
              child: Text("Lưu thay đổi"),
            ),
          ],
        ),
      ),
    );
  }
}
