import 'package:flutter/material.dart';
import 'package:flutter_crud/components/test_list_item.dart';
import 'package:flutter_crud/db/task_dao.dart';
import 'package:flutter_crud/themes/colors.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: FormBody(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              TaskDao().save(TestListItem(
                  task: FormBody().taskController.text,
                  date: FormBody().dateController.text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Criando nova Tarefa"),
                ),
              );

              Navigator.pop(context);
            }
          },
          label: Text(
            "Nova Tarefa",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: fabColor,
        ),
      ),
    );
  }
}

class FormBody extends StatelessWidget {
  FormBody({Key? key}) : super(key: key);
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  bool validation(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: mediaQuery.orientation == Orientation.portrait
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.only(bottom: 16.0, right: 16, left: 16),
        child: SizedBox(
          height: mediaQuery.orientation == Orientation.portrait
              ? mediaQuery.size.height * 0.8
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: mediaQuery.orientation == Orientation.portrait
                    ? const EdgeInsets.only(bottom: 58)
                    : EdgeInsets.only(bottom: 32),
                child: Text(
                  "Nova Atividade",
                  style: TextStyle(color: Colors.white, fontSize: 41),
                ),
              ),
              Padding(
                padding: mediaQuery.orientation == Orientation.portrait
                    ? const EdgeInsets.only(bottom: 64.0)
                    : EdgeInsets.only(bottom: 32.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (validation(value)) {
                      return "Favor inserir uma atividade.";
                    }
                  },
                  controller: taskController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Insira uma atividade",
                      hintStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: mediaQuery.orientation == Orientation.portrait
                    ? const EdgeInsets.only(bottom: 64.0)
                    : EdgeInsets.only(bottom: 32.0),
                child: TextFormField(
                  controller: dateController,
                  validator: (String? value) {
                    if (validation(value)) {
                      return "Favor inserir uma data de realização.";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      hintText: "Data de realização",
                      hintStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
