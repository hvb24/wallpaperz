import 'package:flutter/material.dart';


class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({ required this.imageurl}) ;
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Image.network(widget.imageurl),
                ),
              ),

            ],
          )),
    );
  }
}