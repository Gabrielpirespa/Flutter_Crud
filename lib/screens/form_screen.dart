import 'package:flutter/material.dart';
import 'package:flutter_crud/db/task_dao.dart';
import 'package:flutter_crud/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/task_model.dart';
import '../provider/task_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
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
                        : const EdgeInsets.only(bottom: 32),
                    child: Text(
                      "Nova Atividade",
                      style: GoogleFonts.caveat(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 54),
                      ),
                    ),
                  ),
                  Padding(
                    padding: mediaQuery.orientation == Orientation.portrait
                        ? const EdgeInsets.only(bottom: 64.0)
                        : const EdgeInsets.only(bottom: 32.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (validation(value)) {
                          return "Favor inserir uma atividade.";
                        }
                        return null;
                      },
                      controller: taskController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: "Insira uma atividade",
                          hintStyle: TextStyle(color: Colors.blueGrey)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: mediaQuery.orientation == Orientation.portrait
                        ? const EdgeInsets.only(bottom: 64.0)
                        : const EdgeInsets.only(bottom: 32.0),
                    child: TextFormField(
                      controller: dateController,
                      validator: (String? value) {
                        if (validation(value)) {
                          return "Favor inserir uma data de realização.";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                          hintText: "Data de realização",
                          hintStyle: TextStyle(color: Colors.blueGrey)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Provider.of<TaskProvider>(context).insertInDatabase(
                taskController.text,
                dateController.text,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(8),
                  content: Text(
                    "Tarefa inserida com sucesso",
                  ),
                ),
              );

              Navigator.pop(context);
            }
          },
          label: const Text(
            "Nova Tarefa",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: fabColor,
        ),
      ),
    );
  }
}
