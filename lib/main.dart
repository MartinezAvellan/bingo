import 'package:flutter/material.dart';
import 'package:bingo/pages/StartGame.dart';
import 'package:bingo/pages/login.dart';
import 'package:flutter/services.dart' show rootBundle;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String configurationJson =
      await rootBundle.loadString('assets/configuration.json');
  runApp(new MaterialApp(
    home: InitialPage(configurationJson),
  ));
}

class InitialPage extends StatelessWidget {
  final String configurationJson;
  InitialPage(this.configurationJson);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            FlatButton(
              height: 32,
              minWidth: 32,
              padding: EdgeInsets.only(top: 120, left: 40, right: 40),
              child: Image.asset("assets/play.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StartGame(configurationJson)),
                );
              },
            ),
            FlatButton(
              height: 16,
              minWidth: 16,
              padding: EdgeInsets.only(top: 60, left: 40, right: 40),
              child: Image.asset("assets/configuration.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(configurationJson)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
