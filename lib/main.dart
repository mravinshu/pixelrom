import 'package:flutter/material.dart';
import 'package:pixelexperience/device.dart';
import 'package:pixelexperience/news.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.app});
  final FirebaseApp app;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference dt;
  final refernceDatabase = FirebaseDatabase.instance;
  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    dt = database.reference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceinfo = MediaQuery.of(context);
    return Scaffold(
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
      drawer: alldrawer(deviceinfo: deviceinfo),
      body: Column(
        children: [
          Center(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => News()),
                );
              },
              child: Hero(
                tag: 'News',
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'News',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        news_text(
                          new_text: 'March Update: Plus Edition is here!',
                        ),
                        news_text(
                          new_text: 'February Review – Final Beta’s',
                        ),
                        news_text(
                          new_text: 'January Review: Hello 2021',
                        ),
                        news_text(
                          new_text: 'December Review: It has been a tough year',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          all_device(dt: dt, deviceinfo: deviceinfo)
        ],
      ),
    );
  }
}

class alldrawer extends StatelessWidget {
  const alldrawer({
    Key key,
    @required this.deviceinfo,
  }) : super(key: key);

  final MediaQueryData deviceinfo;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              radius: deviceinfo.size.width / 2,
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: drawer_row(
              device: MyApp(),
              kedaicon: Icons.home,
              home: 'Home',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: drawer_row(
              device: Devices(),
              kedaicon: Icons.phone_android,
              home: 'Devices',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: drawer_row(
              device: News(),
              kedaicon: Icons.wifi,
              home: 'News',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: drawer_row(
              kedaicon: Icons.info,
              home: 'About',
            ),
          ),
        ],
      ),
    );
  }
}

class news_text extends StatelessWidget {
  const news_text({@required this.new_text});
  final String new_text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        new_text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class drawer_row extends StatelessWidget {
  const drawer_row(
      {@required this.device, @required this.home, @required this.kedaicon});
  final String home;
  final device;
  final IconData kedaicon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => device),
        );
      },
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(
                kedaicon,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                home,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
