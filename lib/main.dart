import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // Espaço removido aqui

//void main() {
//  runApp(const MeuAppCafe());
//}

void main() =>
    runApp(DevicePreview(enabled: true, builder: (context) => const MeuAppCafe()));

class MeuAppCafe extends StatelessWidget {
  const MeuAppCafe({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), 
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const PaginaHome(),
    ); 
  }
}

//class MeuAppCafe extends StatelessWidget {
//  const MeuAppCafe({super.key});

//  @override
//  Widget build(BuildContext context) {
//   return MaterialApp(
//    debugShowCheckedModeBanner: false,
//    title: 'Meu App Café',
//   theme: ThemeData(primarySwatch: Colors.brown),
//home: const PaginaHome(),
//);
// }
//}

class PaginaHome extends StatefulWidget {
  const PaginaHome({super.key});

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  int _contadorCafes = 0;
  final TextEditingController _controladorTexto = TextEditingController();
  final List<String> _diarioNotas = [];

  void _incrementarCafe() {
    setState(() {
      _contadorCafes++;
    });
  }

  void _adicionarNota() {
    if (_controladorTexto.text.isNotEmpty) {
      setState(() {
        _diarioNotas.add(
          'Café #${_contadorCafes + 1}: ${_controladorTexto.text}',
        );
        _controladorTexto.clear(); // Corrigido: fora da string e com ponto e vírgula
        _incrementarCafe();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text("Contador de Café + "),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'images/logo_cafe.png',
              height: 120,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.coffee, size: 100, color: Colors.brown),
            ),
            const SizedBox(height: 20),
            Text(
              "Cafés de Hoje: $_contadorCafes",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 40),
            TextField(
              controller: _controladorTexto,
              decoration: const InputDecoration(
                labelText: 'Como estava o Café',
                border: OutlineInputBorder(),
                hintText: 'Ex: Café Arábico',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _adicionarNota,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
              ), // Corrigido: estilo no lugar certo
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Registrar Anotação",
                style: TextStyle(color: Colors.white),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _diarioNotas.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.history_edu, color: Colors.brown),
                    title: Text(_diarioNotas[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
