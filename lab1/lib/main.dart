import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Conversie Temperatură",
      home: const TempConverterPage(),
    );
  }
}

enum Unit { celsius, fahrenheit, kelvin }

class TempConverterPage extends StatefulWidget {
  const TempConverterPage({super.key});

  @override
  State<TempConverterPage> createState() => _TempConverterPageState();
}

class _TempConverterPageState extends State<TempConverterPage> {
  final TextEditingController controller = TextEditingController();
  Unit from = Unit.celsius;
  Unit to = Unit.fahrenheit;
  String result = "";

  void convert() {
    double? value = double.tryParse(controller.text);
    if (value == null) {
      setState(() => result = "Introduceți un număr valid!");
      return;
    }

    double celsius;
    switch (from) {
      case Unit.celsius:
        celsius = value;
        break;
      case Unit.fahrenheit:
        celsius = (value - 32) * 5 / 9;
        break;
      case Unit.kelvin:
        celsius = value - 273.15;
        break;
    }

    double output;
    switch (to) {
      case Unit.celsius:
        output = celsius;
        break;
      case Unit.fahrenheit:
        output = celsius * 9 / 5 + 32;
        break;
      case Unit.kelvin:
        output = celsius + 273.15;
        break;
    }

    setState(() {
      result = "Rezultat: ${output.toStringAsFixed(2)} ${unitName(to)}";
    });
  }

  String unitName(Unit u) {
    switch (u) {
      case Unit.celsius:
        return "°C";
      case Unit.fahrenheit:
        return "°F";
      case Unit.kelvin:
        return "K";
    }
  }

  Widget unitSelector(String label, Unit current, void Function(Unit?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<Unit>(value: Unit.celsius, groupValue: current, onChanged: onChanged),
            const Text("Celsius"),
            Radio<Unit>(value: Unit.fahrenheit, groupValue: current, onChanged: onChanged),
            const Text("Fahrenheit"),
            Radio<Unit>(value: Unit.kelvin, groupValue: current, onChanged: onChanged),
            const Text("Kelvin"),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conversie Temperatură")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Introduceți temperatura",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            unitSelector("Unitate sursă:", from, (val) => setState(() => from = val!)),
            unitSelector("Unitate destinație:", to, (val) => setState(() => to = val!)),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: convert,
                child: const Text("Convertește"),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Text(result, style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
