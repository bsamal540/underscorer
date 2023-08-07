import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UnderScorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Convert To UpperCase with UnderScore"),
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
  String? textToConvert;
  String? result = "";
  TextEditingController txtCtrl = TextEditingController();
  String textToCopy = "";

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied to clipboard: $textToCopy'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.2, right: width * 0.2, top: height * 0.1),
              child: TextField(
                controller: txtCtrl,
                decoration: const InputDecoration(
                  labelText: 'Enter your text',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // const Text(
            //   'Result',style: TextStyle(fontSize: 30),
            // ),
            SizedBox(height: height * 0.1),
            SizedBox(
              width: width * 0.6,
              child: ElevatedButton(
                  onPressed: () {
                    textToConvert = txtCtrl.text;
                    setState(() {});
                    result = '';
                    for (int i = 0; i < textToConvert!.length; i++) {
                      if (textToConvert?[i].toUpperCase() ==
                          textToConvert?[i]) {
                        result = ('${result!}_${textToConvert![i]}');
                      } else {
                        result = (result! + textToConvert![i].toUpperCase());
                      }
                    }
                  },
                  child: const Text("Submit")),
            ),

            SizedBox(height: height * 0.2),

            InkWell(
              onTap: () {
                textToCopy = result ?? "";
                _copyToClipboard();
              },
              child: Text(
                result ?? "Static",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
