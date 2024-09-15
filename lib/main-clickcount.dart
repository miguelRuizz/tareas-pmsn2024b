import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 134, 201, 255),
          title: Text(
            'Mi primer App',
            style: TextStyle(color: Colors.green),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Center(
            child: Text(
              'Contador de Clicks: $contador',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ads_click_sharp),
          onPressed: (){
            contador++;
            setState(() {});
            print(contador);
          }
        ),
      ),
    );
  }
}
