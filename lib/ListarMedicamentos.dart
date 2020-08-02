import 'package:flutter/material.dart';

import 'EditarMedicamento.dart';
import 'models/Database.dart';
import 'dart:async';

class ListarMedicamentos extends StatefulWidget {
  @override
  _ListarMedicamentosState createState() => _ListarMedicamentosState();
}

class _ListarMedicamentosState extends State<ListarMedicamentos> {
  List<Medicamentos> listaMed = new List<Medicamentos>();
  int conta = 0;

  void carregaValores() async {
    await funCurso().procMedicamentos().then(_atualizar);
    int t=0;
  }

  @override
  void initState() {
    carregaValores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista Medicamentos",
        style: TextStyle(fontSize: 20.0, color: Colors.white),),
      ),
      backgroundColor: Colors.grey[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: listaMed.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Medicamentos med = listaMed[index];
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return EditarMedicamento(
                              medicamento: med,); //return MostraVideoEsp(valorRecebido: listaArq[index].identificador.toString(),);
                          }));
                    },
                    child: ListTile(
                      title: Text('${listaMed[index].nome}',
                          style:
                          TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  FutureOr _atualizar(List<Medicamentos> value) {
    setState(() {
      listaMed = value;
      conta = value.length;
    });
  }
}
