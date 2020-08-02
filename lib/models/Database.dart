import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {

  void _onCreate(Database db, int version) async {
    db.execute("CREATE TABLE Medicamentos(id INTEGER PRIMARY KEY autoincrement, nome TEXT, observacao TEXT, data TEXT, tempoEntreMed TEXT",);
    db.execute("CREATE TABLE Configuracoes(id INTEGER PRIMARY KEY autoincrement, nomeConfig TEXT, nomeUsuario TEXT, senha, TEXT, observacao TEXT",);
    print("Tabelas Criadas");
  }

  final database = openDatabase(

    join(await getDatabasesPath(), 'Database.db'),
    onCreate: _onCreate,
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  final database2 = openDatabase(

    join(await getDatabasesPath(), 'Database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE Configuracoes(id INTEGER PRIMARY KEY, nomeConfig TEXT, enderecoInt TEXT, diretorio TEXT, winSO INTEGER, LinuxSO INTEGER, observacao TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertConfig(Configuracoes con) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'Configuracoes',
      con.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTomado(Tomado con) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'Tomado',
      con.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Tomado>> mostrarTomado() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Tomado');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Tomado(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        observacao: maps[i]['observacao'],
        data: maps[i]['data'],
      );
    });
  }


  Future<List<Configuracoes>> configuracoes() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('configuracoes');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Configuracoes(
        id: maps[i]['id'],
        nomeConfig: maps[i]['nomeConfig'],
        senha: maps[i]['senha'],
        observacao: maps[i]['observacao'],
      );
    });
  }

  Future<void> updateConfig(Configuracoes con) async {
    // Get a reference to the database.
    final db = await database;

    await db.update(
      'Configuracoes',
      con.toMap(),
      where: "id = ?",
      whereArgs: [con.id],
    );
  }

  Future<void> deleteConfig(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'Configuracoes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // var configB = Configuracoes(
  //   id: 0,
  //   nomeConfig: 'Config Basica',
  //   enderecoInt: 'http://192.168.0.101',
  //   diretorio: 'v:\\download',
  //   LinuxSO: 0,
  //   winSO: 1,
  //   observacao: 'Configuracao Teste',
  // );

  // // Insert a dog into the database.
  // await insertConfig(configB);

  // print(await configuracoes());
  // print("dddddddddddddddddddddddddddddd");


  // await funCurso().insertArquivo(novoArq);
  // print("Testando tabela arquivo");
  // print("======================");
  // print(await funCurso().procArquivoEsp("Teste 1"));
  // print("======================");

  // print(await funCurso().procArquivos());
  // await funCurso().deletarArquivo(1);
  // print("Arquivos Encontrados !");
  // print("======================");
  // print(await funCurso().procArquivos());
  // List<Arquivos> listaArq = await funCurso().procArquivos();

  // print("============================");
  // print("============================");
  // print("Valor encontrado de id => "+listaArq.first.id.toString());
  // print("Valor encontrado de nome arquivo => "+listaArq.first.nomeArquivo.toString());

  // print("======================");
  // print(await funCurso().procArquivoEsp("Teste 1"));
  // print("======================");

  // print("Sobre Cursos encotrados---------------------------------------------");
  // print(await mostrarCursos());

}


class funCurso {

  void _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute(
        "CREATE TABLE Medicamentos(id INTEGER PRIMARY KEY autoincrement, nome TEXT, observacao TEXT, data TEXT, tempoEntreMed TEXT)",
    );
    batch.execute(
      "CREATE TABLE Configuracoes(id INTEGER PRIMARY KEY autoincrement, nomeConfig TEXT, nomeUsuario TEXT, senha TEXT, observacao TEXT)",
    );
    batch.execute(
      "CREATE TABLE Tomado(id INTEGER PRIMARY KEY autoincrement, nome TEXT, observacao TEXT, data TEXT)",
    );
    List<dynamic> res = await batch.commit();
    print("Tabelas Criadas");
  }

  Future<Database> retornaDatabase() async {
    final databaseCurso = openDatabase(

      join(await getDatabasesPath(), 'Database.db'),
      onCreate: _onCreate,
// Set the version. This executes the onCreate function and provides a
// path to perform database upgrades and downgrades.
      version: 1,
    );
    return databaseCurso;
  }


  Future<void> updateTomado(Tomado con) async {
    // Get a reference to the database.
    final db = await retornaDatabase();

    var retorno = await db.update(
      'Tomado',
      con.toMap(),
      where: "id = ?",
      whereArgs: [con.id],
    );
    print("Valor retornado depois de tentar atualizar");
    print(retorno);
  }

  Future<void> insertMedicamento(Medicamentos con) async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    await db.insert(
      'Medicamentos',
      con.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTomado(Tomado con) async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    await db.insert(
      'Tomado',
      con.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertConfiguracoes(Configuracoes con) async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    await db.insert(
      'Configuracoes',
      con.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateMedicamentos(Medicamentos con) async {
    // Get a reference to the database.
    final db = await retornaDatabase();

    var retorno = await db.update(
      'Medicamentos',
      con.toMap(),
      where: "id = ?",
      whereArgs: [con.id],
    );
  }

  Future<void> updateConfig(Configuracoes con) async {
    // Get a reference to the database.
    final db = await retornaDatabase();

    // Update the given Dog.
    await db.update(
      'Configuracoes',
      con.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [con.id],
    );
  }

  Future<void> deletarMedicamentos(int id) async {
    // Get a reference to the database.
    final db = await retornaDatabase();


    await db.delete(
      'Medicamentos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deletarTomados(int id) async {
    // Get a reference to the database.
    final db = await retornaDatabase();


    await db.delete(
      'Tomado',
      where: "id = ?",
      whereArgs: [id],
    );
  }


  Future<void> deletarConfiguracoes(int idConfig) async {
    // Get a reference to the database.
    final db = await retornaDatabase();


    await db.delete(
      'Configuracoes',
      where: "id = ?",
      whereArgs: [idConfig],
    );
  }


  Future<List<Medicamentos>> procMedicamentos() async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Medicamentos');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Medicamentos(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        data: maps[i]['data'],
        tempoEntreMed: maps[i]['tempoEntreMed'],
        observacao: maps[i]['observacao'],
      );
    });
  }

  Future<List<Tomado>> procTomados() async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Tomado');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Tomado(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        data: maps[i]['data'],
        observacao: maps[i]['observacao'],
      );
    });
  }


  Future<List<Configuracoes>> procConfig() async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Configuracoes');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Configuracoes(
        id: maps[i]['id'],
        nomeConfig: maps[i]['nomeConfig'],
        senha: maps[i]['senha'],
        observacao: maps[i]['observacao'],
      );
    });
  }

  //Future<List<Configuracoes>> procConfigEsp(String proc) async {


  Future<List<Medicamentos>> procMedicamentoEsp(String proc) async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    // Query the table for all The Dogs.
    String baixo = proc.toLowerCase();
    final List<Map<String, dynamic>> maps = await db.query(
        'Medicamentos', where: "instr(LOWER(nome), ? ) > 0",
        whereArgs: [baixo]);

    return List.generate(maps.length, (i) {
      return Medicamentos(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        data: maps[i]['data'],
        tempoEntreMed: maps[i]['tempoEntreMed'],
        observacao: maps[i]['observacao'],
      );
    });
  }

  Future<List<Configuracoes>> procConfigEsp(String uProc, String sProc) async {
    // Get a reference to the database.
    final Database db = await retornaDatabase();

    // Query the table for all The Dogs.
    String usuarioProc = uProc.toLowerCase();
    String senhaProc = sProc.toLowerCase();
    final List<Map<String, dynamic>> maps = await db.query(
        'Configuracoes', where: "instr(LOWER(nomeUsuario), ? ) > 0 and instr(LOWER(senha), ? ) > 0",
        whereArgs: [usuarioProc,senhaProc]);

    return List.generate(maps.length, (i) {
      return Configuracoes(
        id: maps[i]['id'],
        nomeConfig: maps[i]['nomeConfig'],
        nomeUsuario: maps[i]['nomeUsuario'],
        senha: maps[i]['senha'],
        observacao: maps[i]['observacao'],
      );
    });
  }

}


class Medicamentos {
  final int id;
  final String nome;
  final String data;
  final String observacao;
  final String tempoEntreMed;

  Medicamentos({this.id, this.nome, this.data,  this.observacao, this. tempoEntreMed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data': data,
      'observacao': observacao,
      'tempoEntreMed': tempoEntreMed,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Medicamentos{id: $id, nome: $nome, data: $data, observacao: $observacao, tempoEntreMed: $tempoEntreMed,}';
  }
}


class Configuracoes { //(id INTEGER PRIMARY KEY autoincrement, nomeConfig TEXT, observacao TEXT",);
  final int id;
  final String nomeConfig;
  final String nomeUsuario;
  final String senha;
  final String observacao;

  Configuracoes({this.id, this.nomeConfig, this.nomeUsuario, this.senha, this.observacao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeConfig': nomeConfig,
      'nomeUsuario': nomeUsuario,
      'senha': senha,
      'observacao': observacao,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Configuracoes{id: $id, nomeConfig: $nomeConfig, nomeUsuario: $nomeUsuario, senha: $senha, observacao: $observacao,}';
  }
}

class Tomado {
  final int id;
  final String nome;
  final String observacao;
  final String data;

  Tomado({this.id, this.nome, this.observacao, this.data, });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'observacao': observacao,
      'data': data,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Tomado{id: $id, nome: $nome, observacao: $observacao, data: $data,}';
  }
}