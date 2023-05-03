import 'package:flutter/material.dart';
import 'package:flutter_crud/db/task_dao.dart';
import 'package:flutter_crud/themes/colors.dart';

class TestListItem extends StatefulWidget {
  final String task;
  final String date;
  final String taskId;

  const TestListItem({
    Key? key,
    required this.task,
    required this.date,
    required this.taskId,
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
                    IconButton(
                      onPressed: () {
                        String id = widget.taskId;
                        updatedTaskController.text = widget.task;
                        updatedDateController.text = widget.date;
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext alertContext) => AlertDialog(
                              title: const Text(
                                "Alterando tarefa",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: SizedBox(
                                height: mediaQuery.size.height * 0.18,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: updatedTaskController,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.datetime,
                                      controller: updatedDateController,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    TaskDao().update(TestListItem(
                                        task: updatedTaskController.text,
                                        date: updatedDateController.text,
                                        taskId: id));
                                    Navigator.pop(alertContext, "Alterar");
                                  },
                                  child: const Text(
                                    "Alterar",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ),
                              ]),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext alertContext) => AlertDialog(
                                title: const Text("Removendo tarefa"),
                                content: const Text(
                                    "Tem certeza que deseja remover essa tarefa?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      TaskDao().delete(widget.taskId);
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
                                        Navigator.pop(alertContext, "Não"),
                                    child: const Text(
                                      "Não",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ]),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.redAccent),
                  ],
                ),
              ),
              title: Text(
                widget.task,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.date,
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
