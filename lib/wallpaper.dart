import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'fullscreen.dart';

class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List<dynamic> images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  void fetchapi() async {
    await http.get(Uri.parse('https://pixabay.com/api/?key=29801566-6c0f1a6ad54e5b2c87fe2ac5f'),
        ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['hits'];
      });
      

    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://pixabay.com/api/?key=29801566-6c0f1a6ad54e5b2c87fe2ac5f&per_page=30&page=' + page.toString();
    await http.get(Uri.parse(url)).then(
            (value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images.addAll(result['hits']);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                  imageurl: images[index]['largeImageURL'],
                                )));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]['largeImageURL'],
                          fit: BoxFit.cover,
                      ),)
                    );
                    return Container(color: Colors.white,
                    child: Image.network(
                              images[index]['largeImageURL'],
                              fit: BoxFit.cover,
                    ));
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text('Load More',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}