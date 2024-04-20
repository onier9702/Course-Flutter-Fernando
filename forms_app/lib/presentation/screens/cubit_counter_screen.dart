import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterCubit(), // instance of the provider
        child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  void increaseBy(BuildContext context, [int value = 1]) {
    context.read<CounterCubit>().increasedBy(value);
  }

  @override
  Widget build(BuildContext context) {

    // solution 1-) is to watch the counetr cubit provider
    // final counterState = context.watch<CounterCubit>().state;

    // solution 2-) is only use the provider in an especific place

    return Scaffold(
      appBar: AppBar(
        // This is other way, only use it here
        title: context.select((CounterCubit value) {
          // solution 2-)
          return Text('Cubit counter: ${value.state.transactionCount}');
        },),
          // solution 1-)
          // Text('Cubit counter: ${counterState.transactionCount}'),
        actions: [
          IconButton(
            onPressed: () {
              // Reset the counter
              context.read<CounterCubit>().reset();
            }, 
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          // Exists another way to achieve the same using equatable, we use it later
          // buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text('Counter value: ${state.counter}', style: const TextStyle(fontSize: 25),);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1, 
            child: 
              const Text('+3'),
              onPressed: () => increaseBy(context, 3),
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
            heroTag: 2,
            child: 
              const Text('+2'), 
              onPressed: () => increaseBy(context, 2),
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
            heroTag: 3,
            child: 
              const Text('+1'),
              onPressed: () => increaseBy(context),
          ),
        ],
      ),
    );
  }
}
