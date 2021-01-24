import 'package:flutter/material.dart';
import 'package:omdb/model/movie.dart';
import 'package:omdb/page/fav.dart';
import 'package:omdb/util/app_preference.dart';
import 'package:omdb/util/dio_client.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Search> favList = List<Search>();
  List<Search> movies = List<Search>();

  TextEditingController _controller = TextEditingController(text: "");

  Future<List<Search>> searchMovies(String keyword) async {
    var response =
        await DioClient.instance.get("${ClientURL.searchMovie}$keyword");
    setState(() {
      movies = BaseResponse.fromJson(response.data).search ?? [];
    });
    return BaseResponse.fromJson(response.data).search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
            color: Colors.black.withOpacity(0.8),
            child: SafeArea(child: buildSearchBar(context))),
      ),
      body:
          movies.isEmpty ? Center(child: Text("Liste Boş")) : buildFetchData(),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: _controller,
                    validator: (value) =>
                        value.isEmpty ? "Arama alanı boş olamaz" : null,
                    style: Theme.of(context).textTheme.subtitle2,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      print("asc");
                      searchMovies(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Film & Dizi Ara",
                    ),
                  ),
                ),
              ),
              FlatButton(
                  child: Text("Ara"),
                  onPressed: () {
                    searchMovies(_controller.text);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FavoritePage();
                    }));
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFetchData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.690,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Search result = movies[index];
          var isFav = favList
                  .indexWhere((element) => element.imdbId == result.imdbId) !=
              -1;
          return Container(
            padding: EdgeInsets.all(4),
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
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onTap: () {
                            if (isFav) {
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
                                                  isFav = false;
                                                  favList = value;
                                                });
                                              });
                                            },
                                            child: Text("Evet")),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Hayır"))
                                      ],
                                    );
                                  });
                            } else {
                              AppPreference.addItemFavorite(result)
                                  .then((value) {
                                setState(() {
                                  isFav = true;
                                  favList = value;
                                });
                              });
                            }
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
