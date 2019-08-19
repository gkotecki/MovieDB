import 'package:flutter/material.dart';

enviaAlerta(context, String mensagem, String botao) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(mensagem),
        // content: SingleChildScrollView(
        //   child: ListBody(
        //     children: <Widget>[
        //       Text(mensagem),
        //     ],
        //   ),
        // ),
        actions: <Widget>[
          FlatButton(
            child: Text(botao),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}