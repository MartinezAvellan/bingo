import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Config extends StatelessWidget {
  final String configurationJson;
  Config(this.configurationJson);

  @override
  Widget build(BuildContext context) {
    var jonDecoded = json.decode(configurationJson);
    print(jonDecoded['user']);
    String jsonEncode = json.encode(jonDecoded);

    var fileString = read();
    print(fileString);

    var retorno = write(jsonEncode);
    print(retorno);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(children: <Widget>[
          SizedBox(
            width: 128,
            height: 128,
            child: Image.asset("assets/pasta.png"),
          ),
        ]),
      ),
    );
  }
}

Future<String> get _path async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _file async {
  final path = await _path;
  return File(path + '/configuration.json');
}

Future<File> write(String jsonFile) async {
  final file = await _file;
  return file.writeAsString(jsonFile);
}

Future<String> read() async {
  final path = await _path;
  return File(path + '/configuration.json').readAsString();
}
