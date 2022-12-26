import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shapshot;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places.'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder<bool>(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),

          //builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
          builder: (ctx, snapshot) => snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: const Center(
                    child: Text('Got no places yet, start adding some!'),
                  ),
                  builder: (ctx, greatPlaces, ch) =>
                      greatPlaces.items.length <= 5
                          ? ch!
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlaces.items[i].image,
                                  ),
                                ),
                                title: Text(greatPlaces.items[i].title),
                                onTap: () {
                                  // Go to detail page ...
                                },
                                //),
                              ),
                            ),
                  // body: const Center(
                  //   child: CircularProgressIndicator(),
                  //),
                ),
        ));
  }
}
