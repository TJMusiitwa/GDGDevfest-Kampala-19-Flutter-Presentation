import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdg_devfest_flutter/web_details.dart';
import 'package:http/http.dart' as http;

import 'models/recipe_model.dart';

class WebList extends StatefulWidget {
  @override
  _WebListState createState() => _WebListState();
}

class _WebListState extends State<WebList> {
  List data;
  Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Recipes'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          //var f = data[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return WebDetails(
                  meal: recipe.meals[index],
                );
              }));
            },
            child: Card(
              shape: RoundedRectangleBorder(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: data[index]['idMeal'],
                    child: AspectRatio(
                      aspectRatio: 4.0 / 3.0,
                      child: CachedNetworkImage(
                        imageUrl: data[index]['strMealThumb'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data[index]['strMeal'],
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                        Text(
                          data[index]['strCategory'],
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Recipe> fetchRecipes() async {
    final response = await http.get(
        "https://www.themealdb.com/api/json/v1/1/search.php?f=m",
        headers: {
          "Accept":
              "	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
        });

    setState(() {
      var foods = json
          .decode(response.body); //replace with resBody for better code reading
      data = foods['meals'];
      recipe = Recipe.fromJson(foods);
    });

    if (response.statusCode == 200) {
      Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load recipes');
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }
}
