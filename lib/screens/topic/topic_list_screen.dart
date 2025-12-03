import 'package:flutter/material.dart';
import 'package:learn_english/models/topic.dart';
import 'package:learn_english/screens/topic/topic_create_screen.dart';
import 'package:learn_english/screens/topic/topic_edit_screen.dart';
import 'package:learn_english/services/topic_cache.dart';
import 'package:learn_english/services/topic_service.dart';

class TopicListScreen extends StatefulWidget {
  @override
  State<TopicListScreen> createState() => TopicListScreenState();
}

class TopicListScreenState extends State<TopicListScreen> {
  final TopicService service = TopicService();
  final TopicCache cache = TopicCache();

  String search = "";
  bool gridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bộ từ của bạn"),
        actions: [
          IconButton(
            icon: Icon(gridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                gridView = !gridView;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TopicCreateScreen()),
        ),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Tìm bộ từ...",
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => search = v),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Topic>>(
              stream: service.getTopics(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final filtered = snapshot.data!
                      .where(
                        (t) =>
                            t.name.toLowerCase().contains(search.toLowerCase()),
                      )
                      .toList();

                  cache.saveTopics(snapshot.data!);

                  return gridView ? buildGrid(filtered) : buildList(filtered);
                }

                // Nếu mất mạng -> lấy từ cache
                final cached = cache.getTopics();
                return gridView ? buildGrid(cached) : buildList(cached);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(List<Topic> topics) {
    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (_, i) {
        final t = topics[i];
        return ListTile(
          title: Text(t.name),
          subtitle: Text(t.description),
          trailing: PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(value: "edit", child: Text("Sửa")),
              PopupMenuItem(value: "delete", child: Text("Xóa")),
            ],
            onSelected: (v) {
              if (v == "edit") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TopicEditScreen(topic: t)),
                );
              } else if (v == "delete")
                confirmDelete(t);
            },
          ),
        );
      },
    );
  }

  Widget buildGrid(List<Topic> topics) {
    return GridView.count(
      crossAxisCount: 2,
      children: topics.map((t) {
        return Card(
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(t.name, style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text(
                    t.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void confirmDelete(Topic t) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Xóa bộ từ?"),
        content: Text("Bạn có chắc muốn xóa '${t.name}' không?"),
        actions: [
          TextButton(
            child: Text("Hủy"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Xóa", style: TextStyle(color: Colors.red)),
            onPressed: () async {
              await service.deleteTopic(t.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
