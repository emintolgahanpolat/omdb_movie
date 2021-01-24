import 'package:flutter/material.dart';
import 'package:omdb/model/movie.dart';
import 'package:omdb/util/app_preference.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Search> favList = List<Search>();

  @override
  void initState() {
    super.initState();
    getFavorite();
  }

  void getFavorite() async {
    AppPreference.favoriteList.then((value) {
      setState(() {
        favList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favori Film&Dizi"),
      ),
      body: buildFavList(),
    );
  }

  Padding buildFavList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.690,
        ),
        itemCount: favList.length,
        itemBuilder: (context, index) {
          Search result = favList[index];
          return Card(
            child: Stack(
              children: [
                Image.network(
                  result.poster,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.7),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            result.title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Favorilerden Kaldır"),
                                    content: Text(
                                        "${result.title} favorilerden kaldırmak istediğinine emin misin?"),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            AppPreference
                                                    .removeItemFromFavorite(
                                                        result)
                                                .then((value) {
                                              setState(() {
                                                favList = value;
                                              });
                                            });
                                          },
                                          child: Text("Evet")),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Hayırr"))
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
