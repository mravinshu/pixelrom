import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class opendevice extends StatelessWidget {
  opendevice(
      {this.y,
      this.name,
      this.architecture,
      this.CPU,
      this.GPU,
      this.RAM,
      this.SoC,
      this.Versions,
      this.rl,
      this.url});
  final String y;
  final String name;
  final String architecture;
  final String CPU;
  final String GPU;
  final String RAM;
  final String SoC;
  final String Versions;
  final String url;
  final String rl;

  Future<void> _launchInApp(String rl) async {
    if (await canLaunch(rl)) {
      await launch(rl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceinfo = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Hero(
                      tag: url,
                      child: Center(
                        child: Image(
                          image: NetworkImage(y),
                        ),
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                    RaisedButton(
                      onPressed: () {
                        print('object');
                        _launchInApp(rl);
                      },
                      child: Text('Download Rom'),
                    )
                  ],
                ),
              ),
            ),
            Text('Device Details'),
            Center(
              child: Container(
                color: Colors.lightBlue[400],
                width: deviceinfo.size.width / 2,
                height: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: deviceinfo.size.height / 2.5,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('CPU : '),
                          ],
                        ),
                        Flexible(
                          child: Text(CPU),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('GPU : '),
                          ],
                        ),
                        Flexible(child: Text(GPU))
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('SoC : '),
                          ],
                        ),
                        Flexible(child: Text(SoC))
                      ],
                    ),
                    Text('RAM : ' + RAM),
                    Text('Rom Versions : ' + Versions),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
