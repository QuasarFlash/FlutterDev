import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {

  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
    // Future<List<int>> topIds;
    // Source source;
    // for (source in sources){
    //   topIds = source.fetchTopIds();
    //   if (topIds != null){
    //     break;
    //   }
    // }
    // return topIds;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    for (source in sources){
      item = await source.fetchItem(id);
      if (item != null){
        break;
      }
    }
    for (var cache in caches){
      if(cache != source){
      cache.addItem(item);
      }
    }
    return item;
  }

  clearCache() async {
    for (var cache in caches){
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}