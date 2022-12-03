import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPhrlper {
  ///Fatching All items
  Future<List<Map>> fetchitem() async {
    List<Map> items = [];
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      String jsonString = response.body;

      List data = jsonDecode(jsonString);

      items = data.cast<Map>();
    }
// /get data from API
    return items;
  }

  ///get on of the item
  Future<Map> getItem(itemId) async {
    Map item = {};

    //Get the item from the API
    http.Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));

    if (response.statusCode == 200) {
      //get the data from the response
      String jsonString = response.body;
      //Convert to List<Map>
      item = jsonDecode(jsonString);
    }

    return item;
  }

  /// Add new items
  Future<bool> addItem(Map data) async {
    bool status = false;

    //Add the item to the database, call the API
    http.Response response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 201) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  /// update an item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    //Update the item, call the API
    http.Response response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  /// delete item
  Future<bool> deleteitem(String itemId) async {
    bool statas = false;
    http.Response response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));
    if (response.statusCode == 200) {
      statas = true;
    }

    ///delete item from API
    return statas;
  }
}
