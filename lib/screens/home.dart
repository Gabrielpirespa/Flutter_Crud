import 'package:flutter/material.dart';
import 'package:flutter_crud/components/test_list_item.dart';
import 'package:flutter_crud/models/task_dao.dart';
import 'package:flutter_crud/themes/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: FutureBuilder<List<TestListItem>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<TestListItem>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  {
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Carregando"),
                        ],
                      ),
                    );
                  }
                case ConnectionState.waiting:
                  {
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Carregando"),
                        ],
                      ),
                    );
                  }
                case ConnectionState.active:
                  {
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Carregando"),
                        ],
                      ),
                    );
                  }
                case ConnectionState.done:
                  {
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Lista de Atividades",
                                  style: TextStyle(
                                      fontSize: 42,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                <Widget>[
                                  ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final TestListItem task = items[index];
                                        return task;
                                      }),
                                ],
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
            Navigator.pushNamed(context, "form");
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
