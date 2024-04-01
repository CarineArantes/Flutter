import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _y = 0;
  int _x = 0;
  int _random = 0;
  final resp = TextEditingController();
  Icon certo = const Icon(Icons.check);
  Icon errado = const Icon(Icons.close);
  Icon saida = const Icon(Icons.question_mark);
  Map<int, dynamic> _map_resp = {};

  @override
  void initState() {
    super.initState();
    _x = Random().nextInt(10);
  }

  void resultado() {
    setState(() {
      if ((_x + _y) == int.tryParse(resp.text)) {
        _map_resp[_y] = _x + _y;
        if (_map_resp.length == 10) {
          _x = Random().nextInt(10);
          _map_resp.clear();
        } else {
          int novoNumero;
          do {
            novoNumero = Random().nextInt(10) + _x;
          } while (_map_resp.containsValue(novoNumero));
          _y = novoNumero - _x;
        }
      }
      resp.clear();
    });
  }

  void novo() {
    setState(() {
      _x = Random().nextInt(10);
      _y = Random().nextInt(10);
      _map_resp.clear();
      resp.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Center(
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
                  ),
                ),
                FloatingActionButton(
                  onPressed: () => resultado(),
                  tooltip: 'Soma',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          DataTable(
            columns: List.generate(
              10,
              (index) => DataColumn(label: Text('$_x + $index')),
            ),
            rows: List.generate(
              1,
              (index) => DataRow(
                cells: List.generate(
                  10,
                  (index) => DataCell(
                    // Alimentar a célula correta com base no mapa de resposta
                    Text('${_map_resp[index] ?? 'x'}'),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
                  onPressed: () => novo(),
                  tooltip: 'Novo',
                  child: const Icon(Icons.refresh),
                ),
        ],
      ),
    );
  }
}
