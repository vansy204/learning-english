import 'package:flutter/material.dart';
import 'package:learn_english/features/topic/services/topic_service.dart';


class TopicCreateScreen extends StatefulWidget {
  @override
  State<TopicCreateScreen> createState() => TopicCreateScreenState();
}

class TopicCreateScreenState extends State<TopicCreateScreen> {
  final name = TextEditingController();
  final description = TextEditingController();
  final TopicService service = TopicService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tạo bộ từ mới")),
      body: Padding(padding: EdgeInsets.all(16),
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
              await service.createTopic(
                name.text,
                description.text,
              );
              Navigator.pop(context);
            },
            child: Text("Tạo bộ từ"),
          ),
        ],
      ),
      ),
    );
  }
}
