import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
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
  // late AnimationController _controller;
  final myControllerName = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  String _resp = "";
  String _media = "";

  final List<String> histrico = [];

  void _verification() {
    var n1 = double.tryParse(myController1.text.replaceAll(',', "."));
    var n2 = double.tryParse(myController2.text.replaceAll(',', "."));
    var n3 = double.tryParse(myController3.text.replaceAll(',', "."));
    var n4 = double.tryParse(myController4.text.replaceAll(',', "."));
    try {
      var calc = (n1! + n2! + n3! + n4!) / 4;
      setState(() {
        _media = "${myControllerName.text} obteve a media: $calc";
        _resp = (calc >= 6.0) ? "Aprovado !!" : "Reprovado !!";
      });
      final snackBar = SnackBar(
        content: const Text('Voce quer limpar ?'),
        action: SnackBarAction(
          label: 'Limpar',
          onPressed: () {
            setState(() {
              _resp = " ";
              myController1.text = "";
              myController2.text = "";
              myController3.text = "";
              myController4.text = "";
            });
          },
        ),
      );
      histrico
          .add("${myControllerName.text} obteve a media: $calc e foi $_resp");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (ex) {
      setState(() {
        _resp = "Informe um valor valido !!!";
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado final:'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome :',
                      ),
                      onChanged: (value) {
                        myControllerName.text = value;
                      },
                      controller: myControllerName,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nota 1',
                      ),
                      onChanged: (value) {
                        myController1.text = value;
                      },
                      controller: myController1,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nota 2',
                      ),
                      onChanged: (value) {
                        myController2.text = value;
                      },
                      controller: myController2,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nota 3',
                      ),
                      onChanged: (value) {
                        myController3.text = value;
                      },
                      controller: myController3,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nota 4',
                      ),
                      onChanged: (value) {
                        myController4.text = value;
                      },
                      controller: myController4,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: Text(_media)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    width: 500,
                    child: Text(_resp)),
              ],
            ),
            SizedBox(
              width: 700,
              height: 100,
              child: ListView.builder(
                itemCount: histrico.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(histrico[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: _verification, child: const Text('Resultado')),
          ],
        ),
      ),
    );
  }
}
