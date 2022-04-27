import 'package:flutter/material.dart';
import 'main.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deiceinfo = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          elevation: 0,
          title: Row(
            children: [
              Image(
                image: AssetImage('images/logo_small.png'),
                height: 70,
              ),
              Text('Pixel Experience'),
            ],
          ),
        ),
        drawer: alldrawer(deviceinfo: deiceinfo),
        body: Hero(
          tag: 'News',
          child: Card(
            child: Column(
              children: [
                Image(image: AssetImage('images/logo.png')),
                Text(
                  'News',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Panel adding soon....'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
