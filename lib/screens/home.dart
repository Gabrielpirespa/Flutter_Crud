import 'package:flutter/material.dart';
import 'package:flutter_crud/components/test_list_item.dart';
import 'package:flutter_crud/provider/task_provider.dart';
import 'package:flutter_crud/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/loading.dart';
import '../db/task_dao.dart';
import '../provider/task_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 38.0,),
        child: FutureBuilder<dynamic>(
          future: Provider.of<TaskProvider>(context).readFromDatabase(),
          builder: (context, snapshot) {
            List<TaskModel>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                {
                  return const Loading();
                }
              case ConnectionState.waiting:
                {
                  return const Loading();
                }
              case ConnectionState.active:
                {
                  return const Loading();
                }
              case ConnectionState.done:
                {
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return CustomScrollView(
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Text(
                              "Lista de Atividades",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.caveat(textStyle: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.only(bottom: 64, top: 16),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                      return TestListItem(task: items[index], index: index,);
                                  },
                                childCount: items.length,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                          color: Colors.white,
                        ),
                        Text(
                          "Não há nenhuma tarefa.",
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        )
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "form").then((value) => setState((){}) );
        },
        label: const Text(
          "Nova Tarefa",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: fabColor,
      ),
    );
  }
}
