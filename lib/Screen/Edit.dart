import 'package:crud_http/HttpsHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EditItem extends StatefulWidget {
  EditItem(this.post, {super.key});

  Map post;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();

    titleController.text = widget.post["title"];
    bodyController.text = widget.post["body"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete item"),
      ),
      body: Column(
        children: [
          TextField(
            maxLines: 2,
            controller: titleController,
          ),
          TextField(
            maxLines: 5,
            controller: bodyController,
          ),
          MaterialButton(
            color: Colors.red,
            onPressed: () async {
              Map<String, dynamic> dataUpDet = {
                "title": titleController.text,
                "body": bodyController.text
              };
              bool statas = await HTTPhrlper()
                  .updateItem(dataUpDet, widget.post["id"].toString());

              if (statas) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Post updated')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update the post')));
              }
            },
            child: Text("Update"),
          )
        ],
      ),
    );
  }
}
