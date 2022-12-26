import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/dbb_helpers.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [...items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: PlaceLocation(longitude: 0, latitude: 0, address: ''),
        image: pickedImage);
    items.add(newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<bool> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(longitude: 0, latitude: 0, address: ''),
              image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
    return true;
  }
}
