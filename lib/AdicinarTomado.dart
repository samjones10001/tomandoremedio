import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'main.dart';
import 'models/Database.dart';
import 'package:intl/intl.dart';

class AdicionarTomado extends StatefulWidget {
  @override
  _AdicionarTomadoState createState() => _AdicionarTomadoState();

}

class _AdicionarTomadoState extends State<AdicionarTomado> {
  int conta = 0;
  List<Medicamentos> listaMed = new List<Medicamentos>();
  List<String> itemsComboMed = new List<String>();
  var meuItemSelecionado = "";
  final dataController = TextEditingController();
  final obsController = TextEditingController();
  final senhaController = TextEditingController();

  void carregaValores() async {
    print(await funCurso().procMedicamentos());
    await funCurso().procMedicamentos().then(_atualizar);
    String primeiro = listaMed.first.nome.toString();
    meuItemSelecionado = primeiro;//"Teste 5";
    listaMed.forEach((element) {
      itemsComboMed.add(element.nome);
    });
  }

  void _chamaAutenticar() async {
    List<Configuracoes> configList = await funCurso().procConfig();
    if(configList.first.senha.contains(senhaController.text)) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text('Informa', style: TextStyle(
                color: Colors.white,
                fontSize: 20.0),),
            content: Text("Registro Adicionado!",
              style: TextStyle(fontSize: 20.0, color: Colors.white),),
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
    } else       await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text('Erro', style: TextStyle(
              color: Colors.white,
              fontSize: 20.0),),
          content: Text("Senha Inválida!",
            style: TextStyle(fontSize: 20.0, color: Colors.white),),
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
    );  }

  @override
  void initState() {
    carregaValores();
    var now = new DateTime.now();
    var formato = new DateFormat('dd/MM/yyyy HH:mm:ss');
    String formatado = formato.format(now);
    dataController.text = formatado;
    super.initState();
  }

  void adicionarTomado() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text('Informa', style: TextStyle(
              color: Colors.white,
              fontSize: 20.0),),
          content:TextFormField(
            obscureText: true,
            validator: (String value) {
              String respo = "";
              if (value.trim().isEmpty) {
                respo = "Senha Requirida!";
              }
              return respo;
            },
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
              fillColor: Colors.grey[700],
            ),
            controller: senhaController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Autenticar', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0),),
              onPressed: _chamaAutenticar,
            ),
            FlatButton(
              child: Text('Cancelar', style: TextStyle(
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
    var configB = Tomado(
      nome: meuItemSelecionado.toString(),
      data: dataController.text,
      observacao: obsController.text,
    );
    print(configB);
    await funCurso().insertTomado(configB);//insertConfig(configB);
    print(await funCurso().procTomados());
    print("Medicamento adicionado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tomando Medicamento", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    'Adicionar',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  onPressed: adicionarTomado,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
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
