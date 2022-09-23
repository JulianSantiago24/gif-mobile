import 'package:flutter_app_gif/src/models/gif_model.dart';
import 'package:flutter_app_gif/src/services/giphy_search.dart';
import 'package:flutter_app_gif/src/services/giphy_trending.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';


class GifPage extends StatefulWidget {

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {

  Future<List<Gif>> _listadoGifts;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listadoGifts = getTrendingGifs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: TextField(
          controller: textController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            labelText: 'Search by name'
          ),
          onEditingComplete: (){
            setState(() {
              _listadoGifts = getSearchGifs('${textController.text}');
            });
          },
        ),
      ),
      body: FutureBuilder(
        future: _listadoGifts,
        builder: ( context , snapshot ) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StaggeredGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _listGifs(snapshot.data),
                    staggeredTiles: _listTile(snapshot.data),
                  )
                ),
              ]
            );
            } else if (snapshot.hasError) {
              return Text('Error en tu busqueda de GIF');
            }  
            return Center(
              child:  CircularProgressIndicator(),
            );
        })
    );
  }

  List<Widget> _listGifs( List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      gifs.add(
        Card(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.network(gif.url),  
          ), 
        )
      );
    }
    return gifs;
  }

  List<StaggeredTile> _listTile(List<Gif> data) {
    List<StaggeredTile> tiles = [];

    for (var tile in data) {
      tiles.add(
        StaggeredTile.extent(1, double.parse(tile.height)),
      );
    }
    return tiles;
  }
}

