import 'package:flutter/material.dart';
import 'package:tomandoremedio/AdicinarTomado.dart';
import 'package:tomandoremedio/AdicionarMedicamento.dart';
import 'package:tomandoremedio/EditarTomado.dart';
import 'package:tomandoremedio/ListarConfiguracoes.dart';
import 'package:tomandoremedio/ListarMedicamentos.dart';
import 'package:tomandoremedio/SalvarDados.dart';
import 'dart:async';
import 'AdicionarConfig.dart';
import 'models/Database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomando Remédio',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Tomando Remédio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int conta = 0;
  List<Tomado> listaTomados = new List<Tomado>();

  void _incrementCounter() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return AdicionarTomado();
        }));
  }

  void carregaValores() async {
    funCurso().procTomados().then(_atualizar);
    print(listaTomados);
  }

  @override
  void initState() {
    carregaValores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      drawer: new Drawer(
        child: Container(
          color: Colors.grey[700],
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Luis Felipe"),
                  accountEmail: new Text("luisfelipebenites@gmail.com")),
              Card(
                color: Colors.grey[700],
                child: Column(
                  children: <Widget>[
                    new Text(
                      "Configurações",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              new ListTile(
                title: new Text(
                  "Adicinar Configuração",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                       new MaterialPageRoute(
                           builder: (BuildContext context) => AdicionarConfig()));
                },
              ),
              new ListTile(
                title: new Text(
                  "Listar Configuração",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                       new MaterialPageRoute(
                           builder: (BuildContext context) => ListarConfiguracoes()));
                },
              ),
              Column(
                children: <Widget>[
                  Divider(),
                  new Text(
                    "Medicamentos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
              new ListTile(
                title: new Text(
                  "Adicionar Medicamento",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => AdicionarMedicamento()));
                },
              ),
              new ListTile(
                title: new Text(
                  "Listar Medicamentos",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                   Navigator.push(
                       context,
                       new MaterialPageRoute(
                           builder: (BuildContext context) => ListarMedicamentos()));
                },
              ),
              new ListTile(
                title: new Text(
                  "Salvar Backup",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => SalvarDados()));
                },
              ),
              new ListTile(
                title: new Text(
                  "Adicinar Playlist",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  //Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => AdicionarPlaylist()));
                },
              ),
              new ListTile(
                title: new Text(
                  "Ler Backup",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  //Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => LerBackup()));
                },
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
       onRefresh: () async {
         listaTomados.clear();
         await funCurso().procTomados().then(_atualizar);
         print(listaTomados);
       },
        child: Container(
          color: Colors.grey[800],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: listaTomados.length, //ListNomes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 12.0),
                          child: new Container(
                            padding: EdgeInsets.all(5.0),
                            color: Colors.grey[700],
                            child: InkWell(
                              onTap: () async {
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context) {
                                       return EditarTomado(valorRecebido: listaTomados[index]
                                       );
                                     }));
                              },
                              child: ListTile(
                                title: Text(
                                  listaTomados[index].nome,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                subtitle: Text(
                                  listaTomados[index].data,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  FutureOr _atualizar(List<Tomado> value) {
    setState(() {
      listaTomados = value;
      conta = value.length;
    });
  }
}
