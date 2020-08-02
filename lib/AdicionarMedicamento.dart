import 'package:flutter/material.dart';

import 'main.dart';
import 'models/Database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AdicionarMedicamento extends StatefulWidget {
  @override
  _AdicionarMedicamentoState createState() => _AdicionarMedicamentoState();
}
final dataController = TextEditingController();
final obsController = TextEditingController();
final nomeController = TextEditingController();
final tempoVController = TextEditingController();


class _AdicionarMedicamentoState extends State<AdicionarMedicamento> {
  @override
  void initState() {
    DateTime data = new DateTime.now();
    dataController.text = data.toString();
    super.initState();
  }
  void _adicionarMed() async {
    //setState(() async {
    var configB = Medicamentos(
      nome: nomeController.text,
      data: dataController.text,
      tempoEntreMed:  tempoVController.text,
      observacao: obsController.text,
    );
    print(configB);
    await funCurso().insertMedicamento(configB);//insertConfig(configB);
    print(await funCurso().procConfig());
    print("Medicamento adicionado");
    //});
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



  @override
  Widget build(BuildContext context) {
    DateTime selected;

    _showDateTimePicker() async {
      selected = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1960),
        lastDate: new DateTime(2050),
      );
      setState(() {
        dataController.text = selected.toString();
      });
    }
    _showDateTimePicker2() async {
      DatePicker.showDateTimePicker(context,
          showTitleActions: true,
          minTime: DateTime(2020, 5, 5, 20, 50),
          maxTime: DateTime(2200, 6, 7, 05, 09), onChanged: (date) {
            print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            var newFormat = new DateFormat("HH:mm:ss"); //dd/MM/yyyy 
            String updatedDt = newFormat.format(date);
            print('confirm $updatedDt');
            tempoVController.text = updatedDt.toString();
          }, locale: LocaleType.pt);

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Medicamento", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[800],
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  onTap: _showDateTimePicker,
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
                  onTap: _showDateTimePicker2,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0),
                    labelText: "Tempo de vida do medicamento",
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                  ),
                  controller: tempoVController,
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
                  onPressed: _adicionarMed,
                  color: Colors.grey[700],
                ),
              ),
          ],),
        ),
      ),
    );
  }
}
