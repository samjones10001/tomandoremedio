import 'package:flutter/material.dart';
import 'package:tomandoremedio/models/Database.dart';

import 'main.dart';

class AdicionarConfig extends StatefulWidget {
  @override
  _AdicionarConfigState createState() => _AdicionarConfigState();
}
final nomeConfigController = TextEditingController();
final nomeUsuarioController = TextEditingController();
final senhaController = TextEditingController();
final confirmaSenhaController = TextEditingController();
final observacaoController = TextEditingController();
int encontrou = 0;

void _adicionarConfig() async {
  List<Configuracoes> configs = await funCurso().procConfig();
  int conta = configs.length;
  if(conta<1) {
    var confsalva = Configuracoes(
      nomeConfig: nomeConfigController.text,
      nomeUsuario: nomeUsuarioController.text,
      senha: senhaController.text,
      observacao: observacaoController.text,
    );
    await funCurso().insertConfiguracoes(confsalva);
  } else {
    encontrou = 1;
  }
}

class _AdicionarConfigState extends State<AdicionarConfig> {
  void _adicionarNovaConfig() async{
    _adicionarConfig();
    if(encontrou == 1){
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text('Informa', style: TextStyle(
                color: Colors.white,
                fontSize: 20.0),),
            content:Text("O Registro já existe!",
              style: TextStyle(fontSize: 20.0,color: Colors.white),),
            actions: <Widget>[
              FlatButton(
                child: Text('OK', style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }else {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text('Informa', style: TextStyle(
                color: Colors.white,
                fontSize: 20.0),),
            content:Text("Registro Adicionado!",
              style: TextStyle(fontSize: 20.0,color: Colors.white),),
            actions: <Widget>[
              FlatButton(
                child: Text('OK', style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0),),
                onPressed: () async {
                  await Navigator.of(context).pop();
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return MyApp(); //return MostraVideoEsp(valorRecebido: listaArq[index].identificador.toString(),);
                      }));
                },
              ),
            ],
          );
        },
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Config"),
      ),
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0),
                    labelText: "Nome da Configuração",
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                  ),
                  controller: nomeConfigController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0),
                    labelText: "Nome do Usuário",
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                  ),
                  controller: nomeUsuarioController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0),
                    labelText: "Senha",
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                  ),
                  controller: senhaController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0),
                    labelText: "Confirmação da Senha",
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                  ),
                  controller: confirmaSenhaController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0),
                    labelText: "Observação",
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                  ),
                  controller: observacaoController
                  ,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: 85.0,
                    top: 10.0,
                    right: 85.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  onPressed: _adicionarNovaConfig,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
