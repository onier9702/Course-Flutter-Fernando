import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {

  // Here we init the state with the constructor
  CounterBloc() : super(const CounterState()) {

    // Here we have the events or handlers
    // on<CounterIncreased>((event, emit) {

    //   // Update the state 
    //   emit(state.copyWith(
    //     counter: state.counter + event.value,
    //     transactionCount: state.transactionCount + 1,
    //   ));

    // });

    // The same way but simplified
    // on<CounterIncreased>( (event, emit) => _onCounterIncreased(event, emit));
    on<CounterIncreasedEvent>(_onCounterIncreased);
    on<CounterResetEvent>(_onCounterReset);
    // You can add more events as you need
  }

    // Create a private method to call 
    void _onCounterIncreased( CounterIncreasedEvent event, Emitter<CounterState> emit) {

      emit(state.copyWith(
        counter: state.counter + event.value,
        transactionCount: state.transactionCount + 1,
      ));

    }

    // Create a private method to call 
    void _onCounterReset( CounterResetEvent event, Emitter<CounterState> emit) {

      emit(state.copyWith(
        counter: 0,
      ));

    }
}
