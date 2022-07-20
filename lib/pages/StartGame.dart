import 'package:flutter/material.dart';
import 'package:bingo/main.dart';

class StartGame extends StatelessWidget {
  final String configurationJson;
  StartGame(this.configurationJson);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jogo'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Voltar'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InitialPage(configurationJson)),
            );
          },
        ),
      ),
    );
  }
}
