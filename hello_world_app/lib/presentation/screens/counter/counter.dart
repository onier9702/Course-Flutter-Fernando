import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {

  // Constructor of class
  const CounterScreen({super.key});

  @override // state of the class CounterScreen
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(clickCounter.toString(), style: const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),),
              Text('Click${clickCounter > 1 ? 's' : ''}', style: const TextStyle(fontSize: 25),)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            clickCounter++;
            setState(() {});
          },
          child: const Icon(Icons.plus_one),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     clickCounter++;
        //     if (clickCounter > 1) {
        //       textClick = 'Clicks';
        //     }
        //     setState(() {});
        //   },
        //   child: const Icon(Icons.rest),
        // ),
      );
  }
}