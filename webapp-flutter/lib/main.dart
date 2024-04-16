import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI文字语气转换',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AI文字语气转换'),
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
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  void _changeStyle() async {
    const apiKey = 'APIKEY';

    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [
      Content.text('用记者发稿的口气重写一遍下面的文字： \n${inputController.text}')
      // Content.text('Write a story about a magic backpack.')
    ];
    debugPrint('***');
    debugPrint('用记者发稿的口气重写一遍下面的文字： \n${inputController.text}');
    debugPrint('***');
    final response = await model.generateContent(content);
    outputController.text = response.text ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
          // padding: const EdgeInsets.all(16),
          children: <Widget>[
            const Text('原文：', style: TextStyle(fontSize: 20)),
            TextField(
              controller: inputController,
              maxLines: null,
            ),
            const Padding(
              padding: EdgeInsets.all(16),
            ),
            const Text('记者稿子：', style: TextStyle(fontSize: 20)),
            TextField(
              controller: outputController,
              maxLines: null,
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeStyle,
        tooltip: 'Change style',
        child: const Icon(Icons.text_fields),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
