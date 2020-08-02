import 'package:flutter/material.dart';

class SalvarDados extends StatefulWidget {
  @override
  _SalvarDadosState createState() => _SalvarDadosState();
}

class _SalvarDadosState extends State<SalvarDados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Salvar todos os dados do App", style: TextStyle(fontSize: 20.0),),),
    );
  }
}
