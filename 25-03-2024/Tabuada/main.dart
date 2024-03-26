import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soma :',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 230, 7, 155)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Soma:'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _y = 0;
  int _x = 0;
  final resp = TextEditingController();
  Icon certo = const Icon(Icons.check);
  Icon errado = const Icon(Icons.close);
  Icon saida = const Icon(Icons.question_mark);
  int cont = 0;
  Map _map_resp = {};

  void initState() {
    super.initState();
    _y = Random().nextInt(10);
    _x = Random().nextInt(10);
  }

  void resultado() {
    setState(() {
      if ((_x + _y) == int.tryParse(resp.text)) {
        _map_resp.addAll({cont: certo});
      } else {
        _map_resp.addAll({cont: errado});
      }
      _y = Random().nextInt(10);
      _x = Random().nextInt(10);
      cont++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(15),
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: '$_x + $_y = ',
                  ),
                  onChanged: (value) {
                    resp.text = value;
                  },
                  controller: resp,
                )),

            // ========> atualizar dinamicamente <===========
            // Table(
            //   border: TableBorder.all(),
            //   children: [
            //     _map_resp.forEach((key, value) {
            //       // const TableRow(children: [Text("Oii")]);
            //     })
            //   ],
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => resultado(),
        tooltip: 'Soma',
        child: const Icon(Icons.add),
      ),
    );
  }
}
