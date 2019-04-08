import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

class NewsApiProvider {
  Client client = Client();
  final _url = "https://hacker-news.firebaseio.com/v0";

  Future<List<int>> fetchTopIds() async {
    final idUrl = "$_url/maxitem.json";
    final response = await client.get(idUrl);
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final itemUrl = "$_url/item/$id.json";
    final response = await client.get(itemUrl);
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
