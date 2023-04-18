import 'package:flutter_crud/components/test_list_item.dart';
import 'package:flutter_crud/db/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  // Criar primeiro para depois criar o database.
  static const String _tablename = "taskTable";
  static const String _taskid = "taskID";
  static const String _task = "task";
  static const String _date = "date";

  static const String tableSql = "CREATE TABLE $_tablename("
      "$_taskid INTEGER PRIMARY KEY, "
      "$_task TEXT, "
      "$_date TEXT)";

  //Primeiro passo é criar as função toMap e toList para facilitar a implementação do CRUD.

  Map <String, dynamic> toMap(TestListItem testListItem) {
    final Map<String,
        dynamic> taskMap = Map(); // Cria um mapa vazio para inserir os dados a serem passados ao banco.
    taskMap[_task] = testListItem.task;
    taskMap[_date] = testListItem.date;
    return taskMap;
  }

  List<TestListItem> toList(List<Map<String, dynamic>> taskMap) {
    //Deve criar uma função que recebe o mapa e transforma em lista vazia.
    final List <TestListItem> taskList = [ ]; // Cria uma lista vazia para receber os valores transformados do mapa.
    for (Map<String, dynamic> line in taskMap) { //Itera para cada linha do mapa criar um novo TestListItem.
      final TestListItem task = TestListItem(
        taskId: line[_taskid],
        task: line[_task],
        date: line[_date],
      );
      taskList.add(
          task); //Depois de criado o TestListItem adiciona-o na lista vazia.
    }
    return taskList; //Depois de toda iteração retorna a lista completa.
  }

  //Agora deve-se criar as funções do CRUD.

  //Create e Update

  save (TestListItem task) async{
    final Database database = await getDataBase(); //Instância do database.
    final itemExists = await find(task.taskId); //Procura se o item já existe no banco de dados.
    Map<String,dynamic> taskMap = toMap(task); //Transforma os items recebidos no TextForm para mapa.
    if(itemExists.isEmpty) { //Se não existir o insere no database.
      return await database.insert(_tablename, taskMap); //Salva o mapa recebido no database.
    } else { //Se existir ele o altera.
      return await database.update(_tablename, taskMap, where: "$_taskid = ?", whereArgs: [task.taskId]);
    }
  }

  //Read

  //Método findAll realiza a listagem de todas as atividades do banco de dados.

  Future<List<TestListItem>> findAll() async{
    final Database database = await getDataBase(); //Instância do banco de dados.
    final List<Map<String,dynamic>> result = await database.query(_tablename); //Cria uma lista de mapas de todos os dados do database.
    return toList(result); // Transforma tudo em lista de tasks para exibir na tela.
  }

  //Método find realiza a listagem de uma única atividade do banco de dados, que é encontrada pelo seu id (Primary key).

  Future<List<TestListItem>> find(int? taskId) async{
    final Database database = await getDataBase();
    final List<Map<String, dynamic>> result = await database
        .query(_tablename, where: "$_taskid = ?", whereArgs: [taskId]); //Query para encontrar uma entrada específica no banco de dados.
    return toList(result);
  }

  //Update

  // update (TestListItem task) async{
  //   final Database database = await getDataBase(); //Instância do database.
  //   final itemExists = await find(task.taskId); //Procura se o item já existe no banco de dados.
  //   Map<String,dynamic> taskMap = toMap(task); //Transforma os items recebidos no TextForm para mapa.
  //   if(itemExists.isNotEmpty) { //Se existir ele o altera.
  //     database.update(_tablename, taskMap, where: "$_taskid = ?", whereArgs: [task.taskId]);
  //   }
  // }

  //Delete

  delete(int taskId) async{
    final Database database = await getDataBase();
    return database.delete(_tablename, where: "$_taskid = ?", whereArgs: [taskId]);
  }

}