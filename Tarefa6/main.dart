import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nome = "", email = "", celular = "", genero = "";
  int idade = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('meuFormFlutter'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(key: _key, child: criarForm()),
          ),
        ),
      ),
    );
  }

  Widget criarForm() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Nome Completo'),
          maxLength: 40,
          validator: validarNome,
          onSaved: (String? val) {
            nome = val!;
          },
        ),
        new TextField(
            decoration: new InputDecoration(hintText: 'Celular'),
            keyboardType: TextInputType.phone,
            maxLength: 10),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            maxLength: 40,
            validator: validarEmail,
            onSaved: (String? val) {
              email = val!;
            }),
        new Column(
          children: [
            Text("Gênero"),
            RadioListTile(
              title: Text("Homem"),
              value: "homem",
              groupValue: genero,
              onChanged: (value) {
                setState(() {
                  genero = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Mulher"),
              value: "mulher",
              groupValue: genero,
              onChanged: (value) {
                setState(() {
                  genero = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Não-Binário"),
              value: "nao-binario",
              groupValue: genero,
              onChanged: (value) {
                setState(() {
                  genero = value.toString();
                });
              },
            ),
            Text("Idade"),
            Divider(),
            Slider(
              value: idade.toDouble(),
              max: 110,
              divisions: 110,
              label: idade.round().toString(),
              onChanged: (double value) {
                setState(() {
                  idade = value.toInt();
                });
              },
            ),
          ],
        ),
        new SizedBox(height: 15.0),
        new ElevatedButton(
          onPressed: sendForm,
          child: new Text('Enviar'),
        )
      ],
    );
  }

  String? validarNome(String? value) {
    String padrao = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(padrao);

    if (value!.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }

    return null;
  }

  String? validarCelular(String? value) {
    String padrao = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(padrao);

    if (value!.length == 0) {
      return "Informe o celular";
    } else if (value.length != 10) {
      return "O celular deve ter 10 dígitos";
    } else if (!regExp.hasMatch(value)) {
      return "O número do celular so deve conter dígitos";
    }

    return null;
  }

  String? validarEmail(String? value) {
    String padrao =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(padrao);

    if (value!.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  sendForm() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print("Nome $nome");
      print("Ceclular $celular");
      print("Email $email");
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
