import 'package:flutter/material.dart';
import 'package:tomandoremedio/AdicionarMedicamento.dart';
import 'dart:async';
import 'models/Database.dart';

class EditarTomado extends StatefulWidget {
  EditarTomado({this.valorRecebido});

  final valorRecebido;

  @override
  _EditarTomadoState createState() => _EditarTomadoState();
}

class _EditarTomadoState extends State<EditarTomado> {
  int conta = 0;
  List<Medicamentos> listaMed = new List<Medicamentos>();
  List<Tomado> listaToma = new List<Tomado>();
  List<String> itemsComboMed = new List<String>();
  var meuItemSelecionado = "";
  final dataController = TextEditingController();
  final obsController = TextEditingController();
  final senhaController = TextEditingController();

  void carregaValores() async {
    Tomado registro = widget.valorRecebido as Tomado;
    await funCurso().procMedicamentos().then(_atualizar);
    meuItemSelecionado = registro.nome.toString();
    dataController.text = registro.data.toString();
    obsController.text = registro.observacao.toString();
    listaMed.forEach((element) {
      itemsComboMed.add(element.nome);
    });
  }
  @override
  void initState() {
    carregaValores();
    super.initState();
  }
  void editarTomado() async {
    String valorFinal;
    Tomado passado = widget.valorRecebido as Tomado;
    if(meuItemSelecionado.contains(passado.nome)){
      valorFinal = passado.nome;
    } else {
      valorFinal = meuItemSelecionado;
    }
    var registro = Tomado(
        id: passado.id,
        nome: valorFinal,
        observacao: obsController.text,
        data: dataController.text
    );
    funCurso().updateTomado(registro);
  }
  void deletarTomado() async {
    Tomado registro = widget.valorRecebido as Tomado;
    await funCurso().deletarTomados(registro.id);
    print(await funCurso().procTomados());
  }

  @override
  Widget build(BuildContext context) {
    void _editarTomado() async {
      editarTomado();
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

    void _deletaTomado() async {
      deletarTomado();
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

    return Scaffold(
      appBar: AppBar(title: Text("Editar Tomado", style: TextStyle(color: Colors.white),),),
      backgroundColor: Colors.grey[800],
      body: Container(
        child: Column(
          children: <Widget>[
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Lista de Medicamentos", style: TextStyle(fontSize: 20.0, color: Colors.white),),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                dropdownColor: Colors.grey[700],
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                items: itemsComboMed.map((String dropDownConfItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownConfItem,
                    child: Text(
                      dropDownConfItem,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String novoValor) {
                  setState(() {
                    this.meuItemSelecionado = novoValor;
                  });
                },
                value: meuItemSelecionado,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                //onTap: _showDateTimePicker,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0),
                  labelText: "Data",
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      )),
                  filled: true,
                  fillColor: Colors.blueGrey[400],
                ),
                controller: dataController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                onTap: (){},
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
                controller: obsController,
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
                onPressed: editarTomado,
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
                onPressed: _deletaTomado,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
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
