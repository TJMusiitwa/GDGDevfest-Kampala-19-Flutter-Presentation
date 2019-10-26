import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LocalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('My Faves'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/recipe_local.json'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var localRec = json.decode(snapshot.data.toString());
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: localRec == null ? 0 : localRec.length,
              itemBuilder: (BuildContext context, int index) {
                var local = localRec[index];
                return Card(
                  elevation: 0.0,
                  child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints.expand(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.3),
                            child: Hero(
                              tag: local['idMeal'],
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: local['strMealThumb'],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(local['strMeal']),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AnimatedContainer(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height: 5.0,
                                      color: Colors.amber,
                                      duration: Duration(seconds: 2),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(local['strCategory'])
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error.toString()}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
