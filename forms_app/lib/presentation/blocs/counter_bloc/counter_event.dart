part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncreasedEvent extends CounterEvent {

  final int value;

  const CounterIncreasedEvent(this.value);
}

class CounterResetEvent extends CounterEvent {

  const CounterResetEvent();
}
