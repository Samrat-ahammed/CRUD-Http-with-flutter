import 'package:crud_http/HttpsHelper.dart';
import 'package:crud_http/Screen/additem.dart';
import 'package:crud_http/Screen/get.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  PostList({super.key});
  Future<List<Map>> _future = HTTPhrlper().fetchitem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post on API"),
      ),
      body: FutureBuilder<List<Map>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          ///check error

          if (snapshot.hasError) {
            return Text("Some errar${snapshot.error}");
          }
          if (snapshot.hasData) {
            List<Map> post = snapshot.data;

            return ListView.builder(
              itemCount: post.length,
              itemBuilder: (context, index) {
                Map thisItem = post[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Color.fromARGB(255, 57, 220, 139),
                    title: Text(
                      thisItem["title"],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      thisItem["body"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetails(
                              thisItem["id"].toString(),
                            ),
                          ));
                    },
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );

          ///has data

          ///on screen a Loding
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPost(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
