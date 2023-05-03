import 'package:flutter/material.dart';
import 'package:flutter_crud/themes/colors.dart';
import 'package:provider/provider.dart';

import '../provider/task_model.dart';
import '../provider/task_provider.dart';

class TestListItem extends StatefulWidget {
  final TaskModel task;
  final int index;


  const TestListItem({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  @override
  State<TestListItem> createState() => _TestListItemState();
}

class _TestListItemState extends State<TestListItem> {
  bool _checkbox = false;
  final TextEditingController updatedTaskController = TextEditingController();
  final TextEditingController updatedDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Container(
        constraints: BoxConstraints(
          minHeight: mediaQuery.size.height * 0.12,
          maxWidth: mediaQuery.size.width,
        ),
        decoration: BoxDecoration(
            boxShadow: kElevationToShadow[3],
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              secondary: IntrinsicWidth(
                child: Row(
                  children: [
                    Consumer<TaskProvider>(
                      builder: (BuildContext context, TaskProvider provider, Widget? child)
                      {return IconButton(
                        onPressed: () {
                          String id = widget.task.taskId;
                          updatedTaskController.text = widget.task.activity;
                          updatedDateController.text = widget.task.date;
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext alertContext) =>
                                AlertDialog(
                                    title: const Text(
                                      "Alterando tarefa",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: myColor
                                      ),
                                    ),
                                    content: SizedBox(
                                      height: mediaQuery.size.height * 0.158,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                            child: SizedBox(
                                              height: 53,
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                controller: updatedTaskController,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 53,
                                            child: TextField(
                                              keyboardType: TextInputType
                                                  .datetime,
                                              controller: updatedDateController,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          provider.updateFromDatabase(
                                              id,
                                              updatedTaskController.text,
                                              updatedDateController.text);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              behavior: SnackBarBehavior.floating,
                                              width: 240,
                                              content: Text(
                                                "Tarefa alterada com sucesso", textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                          Navigator.pop(
                                              alertContext, "Alterar");
                                        },
                                        child: const Text(
                                          "Alterar",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,),
                                        ),
                                      ),
                                    ]),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      );}
                    ),
                    Consumer<TaskProvider>(
                      builder: (BuildContext context, TaskProvider provider, Widget? child)
                      { return IconButton(
                          onPressed: () {
                            String id = widget.task.taskId;
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext alertContext) =>
                                  AlertDialog(
                                      title: const Text("Removendo tarefa", style: TextStyle(color: myColor, fontWeight: FontWeight.bold),),
                                      content: const Text(
                                          "Tem certeza que deseja remover essa tarefa?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            provider.deleteFromDatabase(id);
                                            provider.tasks.removeAt(widget.index);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                behavior: SnackBarBehavior.floating,
                                                width: 240,
                                                content: Text(
                                                  "Tarefa removida com sucesso", textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                            Navigator.pop(alertContext, "Sim");
                                          },
                                          child: const Text(
                                            "Sim",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(
                                                  alertContext, "Não"),
                                          child: const Text(
                                            "Não",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent
                                            ),
                                          ),
                                        )
                                      ]),
                            );
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.redAccent);}
                    ),
                  ],
                ),
              ),
              title: Text(
                widget.task.activity,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.task.date,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: fabColor,
              value: _checkbox,
              onChanged: (bool? value) {
                setState(() {
                  _checkbox = !_checkbox;
                });
              }),
        ),
      ),
    );
  }
}
