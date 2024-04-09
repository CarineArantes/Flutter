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
      title: 'Image',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 123, 255, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class ImageGET {
  final String url;
  final String thumbnailUrl;
  final String title;

  const ImageGET({
    required this.url,
    required this.thumbnailUrl,
    required this.title,
  });

  factory ImageGET.fromJson(Map<String, dynamic> json) {
    return ImageGET(
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      title: json['title'],
    );
  }
}

Future<ImageGET> buscaIMAGE(int id) async {
  final resposta = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos/$id'));
  if (resposta.statusCode == 200) {
    final dynamic data = jsonDecode(resposta.body);
    return ImageGET.fromJson(data);
  } else {
    throw Exception('Falha ao carregar imagem.');
  }
}

class _MyHomePageState extends State<MyHomePage> {

  int idImage = 1;
  late Future<ImageGET> futuraImagem;

  @override
  void initState() {
    super.initState();
    futuraImagem = buscaIMAGE(idImage);
  }

  void verProxima() {
    setState(() {
      idImage++;
      futuraImagem = buscaIMAGE(idImage);
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
        child: FutureBuilder<ImageGET>(
          future: futuraImagem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final String url = snapshot.data!.url;
              return Image.network(url);
            }
          },
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => verProxima(),
        tooltip: 'Ver Prxima ',
        child: const Icon(Icons.skip_next_outlined),
      ),
    );
  }
}
