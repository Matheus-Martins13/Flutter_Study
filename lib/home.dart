import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _textoSalvo = "Nada salvo";
  final TextEditingController _controllerCampo = TextEditingController();

  void _salvar() async {
    String valorDigitado = _controllerCampo.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', valorDigitado);

    debugPrint(valorDigitado);
  }

  void _recuperar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString('nome') ?? "Nada salvo";
    });
  }

  void _remover() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manipulação de Dados"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              _textoSalvo,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Digite algo",
              ),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: _salvar,
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: _recuperar,
                  child: const Text(
                    "Recuperar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: _remover,
                  child: const Text(
                    "Remover",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
