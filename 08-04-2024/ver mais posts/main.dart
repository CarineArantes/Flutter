import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POSTs',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 123, 255, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'POSTs'),
    );
  }
}

class Poste {
  final int idUsuario;
  final int id;
  final String titulo;

  const Poste({
    required this.idUsuario,
    required this.id,
    required this.titulo,
  });

  factory Poste.fromJson(Map<String, dynamic> json) {
    return Poste(
      idUsuario: json['userId'],
      id: json['id'],
      titulo: json['title'],
    );
  }
}

Future<Poste> buscaPOSTE(int id) async {
  final resposta = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
  if (resposta.statusCode == 200) {
    final dynamic data = jsonDecode(resposta.body);
    return Poste.fromJson(data);
  } else {
    throw Exception('Falha ao carregar posts.');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  late Future<Poste> futuroPoste;
  List<Poste> _listaPostes = [];

  @override
  void initState() {
    super.initState();
    futuroPoste = buscaPOSTE(_counter);
  }

  void verMais() {
    setState(() {
      _counter++;
      futuroPoste = buscaPOSTE(_counter);
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
        child: FutureBuilder<Poste>(
          future: futuroPoste,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              _listaPostes.add(snapshot.data!);
              return ListView.builder(
                itemCount: _listaPostes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_listaPostes[index].titulo),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => verMais(),
        tooltip: 'Ver Mais +',
        child: const Icon(Icons.more_horiz_outlined),
      ),
    );
  }
}