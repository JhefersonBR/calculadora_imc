import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infor = "Informe seus dados!";

  void _resetFields() {
    peso.text = '';
    altura.text = '';
    setState(() {
      _infor = "Informe seus dados!";
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    });
  }

  void _calcula() {
    setState(() {
      double dPeso = double.parse(peso.text);
      double dAltura = double.parse(altura.text) / 100;
      double imc = dPeso / (dAltura * 2);

      if (imc < 18.6) {
        _infor = "Abaixo do Peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infor = "Peso ideal";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infor = "Levemente acima  do peso";
      } else if (imc >= 24.9 && imc < 34.9) {
        _infor = "Obesidade Gra I";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infor = "Obesidade Gra II";
      } else if (imc >= 40) {
        _infor = "Obesidade Gra III";
      }

      _infor = _infor + " Imc:(${imc.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                color: Colors.green,
                size: 120,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Insira seu peso';
                    }
                  }
                },
                controller: peso,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 30),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    }
                  }
                },
                controller: altura,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 30),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  child: TextButton(
                    child: Text('Calcular'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcula();
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                ),
              ),
              Text(
                '$_infor',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
