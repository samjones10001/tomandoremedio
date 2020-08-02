import 'package:flutter/material.dart';

import 'models/Database.dart';

class EditarMedicamento extends StatefulWidget {

  EditarMedicamento({this.medicamento});

  final medicamento;

  @override
  _EditarMedicamentoState createState() => _EditarMedicamentoState();
}

class _EditarMedicamentoState extends State<EditarMedicamento> {
  final dataController = TextEditingController();
  final obsController = TextEditingController();
  final nomeController = TextEditingController();

  void _deletarMedicamento() async {
    Medicamentos med = widget.medicamento;
    await funCurso().deletarMedicamentos(med.id);
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


  void _editarMedicamento() async {
    Medicamentos med = widget.medicamento;
    var novoArquivo = Medicamentos(
      id: med.id,
      nome: nomeController.text,
      data: dataController.text,
      observacao: obsController.text,
    );
    print("O valor novo");
    print(novoArquivo);
    await funCurso().updateMedicamentos(novoArquivo);
    print("Valore Novos");
    print(await funCurso().procMedicamentoEsp(nomeController.text));
    print("------------------");
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text('Informa', style: TextStyle(
              color: Colors.white,
              fontSize: 20.0),),
          content:Text("Registro Atualizado!",
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

  @override
  void initState() {
    Medicamentos med = widget.medicamento;
    obsController.text = med.observacao.toString();
    nomeController.text = med.nome.toString();
    dataController.text = med.data.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Medicamento",
          style: TextStyle(fontSize: 20.0,
              color: Colors.white),),
      ),
      backgroundColor: Colors.grey[800],
      body: Center(
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
                  labelText: "Nome do Medicamento",
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      )),
                  filled: true,
                  fillColor: Colors.blueGrey[400],
                ),
                controller: nomeController,
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
                onPressed: _editarMedicamento,
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
                onPressed: _deletarMedicamento,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
