import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pixelexperience/deviceopen.dart';
import 'package:pixelexperience/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Devices extends StatefulWidget {
  Devices({this.app});
  final FirebaseApp app;
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
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
    final ref = refernceDatabase.reference().child('Device');
    MediaQueryData deviceinfo = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [all_device(dt: dt, deviceinfo: deviceinfo)],
      ),
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
      drawer: alldrawer(
        deviceinfo: deviceinfo,
      ),
    );
  }
}

class all_device extends StatelessWidget {
  const all_device({
    Key key,
    @required this.dt,
    @required this.deviceinfo,
  }) : super(key: key);

  final DatabaseReference dt;
  final MediaQueryData deviceinfo;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: new FirebaseAnimatedList(
          shrinkWrap: true,
          query: dt,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return GestureDetector(
              onTap: () {
                String y = snapshot.value['url'];
                String s = "https://download.pixelexperience.org/";
                s = s + y;
                print(s);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => opendevice(
                      y: snapshot.value['Image'],
                      name: snapshot.value['Name'],
                      architecture: snapshot.value['Architecture'],
                      CPU: snapshot.value['CPU'],
                      GPU: snapshot.value['GPU'],
                      SoC: snapshot.value['SoC'],
                      RAM: snapshot.value['RAM'],
                      Versions: snapshot.value['Versions'],
                      url: snapshot.value['url'],
                      rl: s,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Hero(
                  tag: snapshot.value['url'],
                  child: new Card(
                    child: Container(
                      color: Colors.grey[800],
                      width: deviceinfo.size.width,
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(snapshot.value['Image']),
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.value['Name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
