import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'models/recipe_model.dart';

class WebDetails extends StatefulWidget {
  final Meals meal;
  final bool isFavourite;
  final void Function(bool isFavourite) onFavouriteChanged;

  const WebDetails(
      {Key key, this.meal, this.onFavouriteChanged, this.isFavourite})
      : super(key: key);

  @override
  _WebDetailsState createState() => _WebDetailsState();
}

class _WebDetailsState extends State<WebDetails> {
  final List<Meals> _favouriteRecipes = [];

  bool isFavourited = false;

  @override
  void initState() {
    super.initState();
    isFavourited = widget.isFavourite;
  }

  void toggleFavourite() {
    setState(() {
      isFavourited = !isFavourited;
      widget.onFavouriteChanged(isFavourited);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _getAppBarHeight(BuildContext context) =>
        MediaQuery.of(context).size.height * 0.3;
    final Size screenSize = MediaQuery.of(context).size;
    final bool fullWidth = screenSize.width < 500;
    final bool isFavourite = _favouriteRecipes.contains(widget.meal);
    const double _kFabHalfSize = 28.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _getAppBarHeight(context) + _kFabHalfSize,
            child: Hero(
                tag: widget.meal.idMeal,
                child: CachedNetworkImage(
                  imageUrl: widget.meal.strMealThumb,
                  fit: BoxFit.fitWidth,
                )),
          ),
          CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: _getAppBarHeight(context) - _kFabHalfSize,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share(
                          'Hey check out this recipe I got from this app built in Flutter 😋\n' +
                              widget.meal.strSource);
                    },
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Icon(Icons.email),
                      ),
                      PopupMenuItem(
                        child: IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            Share.share(
                                'Hey check out this recipe I got from this app built in Flutter 😋\n' +
                                    widget.meal.strSource);
                          },
                        ),
                      )
                    ],
                  )
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.2),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: _kFabHalfSize),
                      width: fullWidth ? null : 500,
                      child: Material(
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 40),
                            child: Table(
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(64)
                              },
                              children: <TableRow>[
                                TableRow(
                                  children: <Widget>[
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: SizedBox(
                                        height: 32,
                                        width: 32,
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Text(
                                        widget.meal.strMeal,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline,
                                      ),
                                    )
                                  ],
                                ),
                                TableRow(children: <Widget>[
                                  const SizedBox(),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24, bottom: 4),
                                      child: Chip(
                                        label: Text(widget.meal.strTags ?? ""),
                                      ))
                                ]),
                                TableRow(children: <Widget>[
                                  const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                    ),
                                    child: Text(
                                      widget.meal.strInstructions,
                                      style: Theme.of(context).textTheme.body1,
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ]),
                                TableRow(children: <Widget>[
                                  const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24, bottom: 4),
                                    child: Text(
                                      'Ingredients',
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  )
                                ]),
                                _buildIngredientRow(widget.meal.strMeasure1,
                                    widget.meal.strIngredient1),
                                _buildIngredientRow(widget.meal.strMeasure2,
                                    widget.meal.strIngredient2),
                                _buildIngredientRow(widget.meal.strMeasure3,
                                    widget.meal.strIngredient3),
                                _buildIngredientRow(widget.meal.strMeasure4,
                                    widget.meal.strIngredient4),
                                _buildIngredientRow(widget.meal.strMeasure5,
                                    widget.meal.strIngredient5),
                                _buildIngredientRow(widget.meal.strMeasure6,
                                    widget.meal.strIngredient6),
                                _buildIngredientRow(widget.meal.strMeasure7,
                                    widget.meal.strIngredient7),
                                _buildIngredientRow(widget.meal.strMeasure8,
                                    widget.meal.strIngredient8),
                                _buildIngredientRow(widget.meal.strMeasure9,
                                    widget.meal.strIngredient9),
                                _buildIngredientRow(widget.meal.strMeasure10,
                                    widget.meal.strIngredient10),
                                _buildIngredientRow(widget.meal.strMeasure11,
                                    widget.meal.strIngredient11),
                                _buildIngredientRow(widget.meal.strMeasure12,
                                    widget.meal.strIngredient12),
                                _buildIngredientRow(widget.meal.strMeasure13,
                                    widget.meal.strIngredient13),
                                _buildIngredientRow(widget.meal.strMeasure14,
                                    widget.meal.strIngredient14),
                                _buildIngredientRow(widget.meal.strMeasure15,
                                    widget.meal.strIngredient15),
                                _buildIngredientRow(widget.meal.strMeasure15,
                                    widget.meal.strIngredient15),
                                _buildIngredientRow(widget.meal.strMeasure16,
                                    widget.meal.strIngredient16),
                                _buildIngredientRow(widget.meal.strMeasure17,
                                    widget.meal.strIngredient17),
                                /* _buildIngredientRow(widget.meal.strMeasure18,
                                    widget.meal.strIngredient18),
                                _buildIngredientRow(widget.meal.strMeasure19,
                                    widget.meal.strIngredient19),
                                _buildIngredientRow(widget.meal.strMeasure20,
                                    widget.meal.strIngredient20), */
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      child: FloatingActionButton(
                        child: Icon(isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

TableRow _buildIngredientRow(String measure, String ingredient) {
  return TableRow(children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(measure ?? ''),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(ingredient ?? ''),
    )
  ]);
}
