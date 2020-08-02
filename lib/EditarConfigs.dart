import 'package:flutter/material.dart';
import 'package:tomandoremedio/models/Database.dart';

class EditarConfigs extends StatefulWidget {

  EditarConfigs({this.Config});

  final Config;


  @override
  _EditarConfigsState createState() => _EditarConfigsState();
}
final nomeConfigController = TextEditingController();
final nomeUsuarioController = TextEditingController();
final senhaController = TextEditingController();
final confirmaSenhaController = TextEditingController();
final observacaoController = TextEditingController();
int encontrou = 0;

class _EditarConfigsState extends State<EditarConfigs> {
  void _editarConfig() async {
    var passado = widget.Config as Configuracoes;
    var registro = Configuracoes(
        id: passado.id,
        nomeUsuario: passado.nomeUsuario,
        nomeConfig: passado.nomeConfig,
        observacao: passado.observacao,
        senha: senhaController.text,
    );
    funCurso().updateConfig(registro);
  }
  void _deletarConfig() async {
    Configuracoes registro = widget.Config as Configuracoes;
    await funCurso().deletarConfiguracoes(registro.id);
    print(await funCurso().procConfig()); // ajuda a editar o programa. Retirar no final.
  }

  void carregaValores() async {
    Configuracoes config = widget.Config as Configuracoes;
    nomeConfigController.text = config.nomeConfig;
    nomeUsuarioController.text = config.nomeUsuario;
    observacaoController.text = config.observacao;
  }

  @override
  void initState() {
    carregaValores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _deletarRegistro() async {
      _deletarConfig();
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text('Informa', style: TextStyle(
                color: Colors.white,
                fontSize: 20.0),),
            content:Text("Registro Deletado!",
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
    }
    void editarRegistro() async {
      _editarConfig();
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text('Informa', style: TextStyle(
                color: Colors.white,
                fontSize: 20.0),),
            content:Text("Registro Editado!",
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
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Configuração",
            style: TextStyle(fontSize: 20.0,
                color: Colors.white),),
        ),
        backgroundColor: Colors.grey[800],
        body:Column(
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
                  'Editar',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                onPressed: editarRegistro,
                color: Colors.grey[700],
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
                  'Deletar',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                onPressed: _deletarRegistro,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
    );
  }
}
