import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _info = "Informe seus Dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _info = "Informe seus Dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

/*
MENOR QUE 18,5	MAGREZA	0
ENTRE 18,5 E 24,9	NORMAL	0
ENTRE 25,0 E 29,9	SOBREPESO	I
ENTRE 30,0 E 39,9	OBESIDADE	II
MAIOR QUE 40,0	OBESIDADE GRAVE	III
 */
  void _calcularImc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);
      double resut = peso / (altura * altura);
      if (resut < 18.5) {
        _info = "Abaixo do Peso (${resut.toStringAsPrecision(3)})";
      } else if (resut >= 18.5 && resut <= 24.9) {
        _info = "Peso Normal (${resut.toStringAsPrecision(3)})";
      } else if (resut >= 25.0 && resut <= 29.9) {
        _info = "Obesidade Grau I (${resut.toStringAsPrecision(3)})";
      } else if (resut >= 30.0 && resut <= 39.9) {
        _info = "Obesidade Grau II  (${resut.toStringAsPrecision(3)})";
      } else if (resut >= 40.0) {
        _info = "Obesidade Grau III  (${resut.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 30.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  }),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 30.0),
                controller: alturaController,
                validator: (Value) {
                  if (Value.isEmpty) {
                    return "insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcularImc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(_info,
                  style: TextStyle(color: Colors.green, fontSize: 30.0),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
