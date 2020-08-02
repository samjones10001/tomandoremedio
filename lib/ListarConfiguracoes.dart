import 'package:flutter/material.dart';
import 'package:tomandoremedio/EditarConfigs.dart';
import 'dart:async';

import 'package:tomandoremedio/models/Database.dart';

class ListarConfiguracoes extends StatefulWidget {
  @override
  _ListarConfiguracoesState createState() => _ListarConfiguracoesState();
}

class _ListarConfiguracoesState extends State<ListarConfiguracoes> {
  List<Configuracoes> listaConfig = new List<Configuracoes>();
  int conta = 0;

  void carregaValores() async {
    await funCurso().procConfig().then(_atualizar);
    print(await funCurso().procConfig());

  }

  @override
  void initState() {
    print("Entrou na tela!");
    carregaValores();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listar Configurações",
        style: TextStyle(fontSize: 20.0, color: Colors.white),),),
        backgroundColor: Colors.grey[800],
        body: Column(children: <Widget>[
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: listaConfig.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Configuracoes med = listaConfig[index];
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return EditarConfigs(Config: med,); //return MostraVideoEsp(valorRecebido: listaArq[index].identificador.toString(),);
                          }));
                    },
                    child: ListTile(
                      title: Text('${listaConfig[index].nomeConfig}',
                          style:
                          TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],),
    );
  }
  FutureOr _atualizar(List<Configuracoes> value) {
    setState(() {
      listaConfig = value;
      conta = value.length;
    });
  }
}
