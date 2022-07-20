import 'package:bingo/pages/Config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final String configurationJson;
  LoginPage(this.configurationJson);
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 160, left: 40, right: 40),
        child: _body(context),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            textFormFieldLogin(),
            textFormFieldSenha(),
            containerButton(context)
          ],
        ));
  }

  TextFormField textFormFieldLogin() {
    return TextFormField(
        controller: _tLogin,
        validator: _validateLogin,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Login",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Informe o login"));
  }

  TextFormField textFormFieldSenha() {
    return TextFormField(
        controller: _tSenha,
        validator: _validateSenha,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Informe a senha"));
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Colors.black,
        child: Text("Login",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          _onClickLogin(context);
        },
      ),
    );
  }

  Future<AlertDialog> errorLogin(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: AppBar(
              title: Text(
                'Erro',
              ),
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            content: Text(
              "Login e/ou Senha inválido(s)",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]);
      },
    );
  }

  _onClickLogin(BuildContext context) {
    var jonDecoded = json.decode(configurationJson);
    print(jonDecoded['user']);
    final login = _tLogin.text;
    final senha = _tSenha.text;
    //print("Login: $login , Senha: $senha ");
    if (!_formKey.currentState.validate()) {
      return;
    } else if (login.isEmpty || senha.isEmpty) {
      return errorLogin(context);
    } else {
      if (login == jonDecoded['user'] && senha == jonDecoded['password']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Config(configurationJson)),
        );
      } else {
        return errorLogin(context);
      }
    }
  }
}
