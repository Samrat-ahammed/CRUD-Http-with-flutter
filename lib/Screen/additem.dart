import 'package:crud_http/HttpsHelper.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 2,
            ),
            TextField(
              controller: bodyController,
              maxLines: 5,
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, String> dataToUpdate = {
                    'title': titleController.text,
                    'body': bodyController.text,
                  };

                  bool status = await HTTPhrlper().addItem(dataToUpdate);

                  if (status) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Post added')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add the post')));
                  }
                },
                child: Text("Add"))
          ],
        ),
      )),
    );
  }
}
