import 'package:crud_http/HttpsHelper.dart';
import 'package:crud_http/Screen/Edit.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  PostDetails(this.itemId, {Key? key}) : super(key: key) {
    _futurePost = HTTPhrlper().getItem(itemId);
  }

  String itemId;
  late Future<Map> _futurePost;
  late Map post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post detils"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditItem(post),
                  ),
                );
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                bool delete = await HTTPhrlper().deleteitem(itemId);
                if (delete) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Post delete')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Something is wrong')));
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditItem(post),
                  ),
                );
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: _futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              post = snapshot.data!;

              return Container(
                color: Color.fromARGB(255, 126, 251, 238),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        post["title"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(
                        post["body"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
