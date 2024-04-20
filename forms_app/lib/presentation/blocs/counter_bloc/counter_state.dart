part of 'counter_bloc.dart';

class CounterState extends Equatable {

  final int counter;
  final int transactionCount;

  const CounterState({
    this.counter = 10,
    this.transactionCount = 0
  });

  // The COPYWITH
  CounterState copyWith({
    int? counter,
    int? transactionCount,
  }) => CounterState(
    counter: counter ?? this.counter,
    transactionCount: transactionCount ?? this.transactionCount
  );
  
  @override
  List<Object> get props => [counter, transactionCount]; // properties you want to compare to know if redrew the state
}

// final class CounterInitial extends CounterState {}
