import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Here we need to set access to the BlocCounter so this widget can use it
    // It is like create the instance of the CounterBloc IMPORTANT
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const BlocCounterView()
    );
  }
}

class BlocCounterView extends StatelessWidget {

  // Constructor
  const BlocCounterView({
    super.key,
  });

  // method to call handler or event
  void increaseCounterBy(BuildContext context, [int value = 1]) {

    // Here we need to read, not select OJOOO
    // context.select((CounterBloc counterBloc) => ); WRONG NOOOO

    context.read<CounterBloc>()
      .add( CounterIncreasedEvent(value) );

  }

  // method to call handler or event
  void resetCounter(BuildContext context) {

    context.read<CounterBloc>()
      .add(const CounterResetEvent());

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we need to select the transaction count value
        title: context.select((CounterBloc counterBloc) => 
          Text('Bloc transactions: ${counterBloc.state.transactionCount}'),
        ),
        actions: [
          IconButton(
            onPressed: () => resetCounter(context),
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: Center(
        // Here we use select because we need to get the value
        child: context.select(
          (CounterBloc counterBloc) => Text(
            'Counter value: ${counterBloc.state.counter}',
            style: const TextStyle(fontSize: 25)
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            child: const Text('+3'),
            onPressed: () => increaseCounterBy(context, 3),
          ),
    
          const SizedBox(height: 15),
    
          FloatingActionButton(
            heroTag: 2,
            child: const Text('+2'),
            onPressed: () => increaseCounterBy(context, 2),
          ),
    
          const SizedBox(height: 15),
    
          FloatingActionButton(
            heroTag: 3,
            child: const Text('+1'),
            onPressed: () => increaseCounterBy(context),
          ),
        ],
      ),
    );
  }
}
