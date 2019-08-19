import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/movies/movie_list.dart';
import 'package:myapp/util/blue_button.dart';
import 'package:myapp/util/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var showProgress = false;

  final _tLogin = TextEditingController(text: "gabriel@qweqwe.com");
  final _tSenha = TextEditingController(text: "qweqwe");

  File _fileCamera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: _onClickFoto,
          )
        ],
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      margin: EdgeInsets.all(20),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Login",
            style: TextStyle(fontSize: 22),
          ),
          TextField(
            controller: _tLogin,
            style: TextStyle(fontSize: 22, color: Colors.blue),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            "Senha",
            style: TextStyle(fontSize: 22),
          ),
          TextField(
            controller: _tSenha,
            style: TextStyle(fontSize: 22, color: Colors.blue),
            obscureText: true,
          ),
          SizedBox(
            height: 80,
          ),
          Center(
            child: BlueButton(
              "LOGIN",
              () => _onClickLogin(context),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: BlueButton(
              "CADASTRE-SE",
              () => _onClickCadastro(context),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _fileCamera == null
                  ? Text('sem imagem')
                  : Image.file(_fileCamera),
            ),
          )
        ],
      ),
    );
  }

  _onClickLogin(BuildContext context) async {
    push(context, MovieList());
  }

  _onClickCadastro(BuildContext context) async {
    // push(context, MovieList());
  }

  _onClickFoto() async {
    var fileCamera = await ImagePicker.pickImage(source: ImageSource.camera);
    if (fileCamera != null)
      setState(() {
        _fileCamera = fileCamera;
      });
  }
}
