import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/bloc/timer_event.dart';
import 'package:timer_bloc/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitState());
  int value = 0;

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is IncrementEvent) {
      value = event.currValue;
      yield IncrementedState(value: value);
    } else if (event is DescEvent) {
      value = event.currValue;
      yield DescedState(value: value);
    } else if (event is ResetEvent) {
      value = 0;
      yield ResetedState(value: value);
    } else if (event is ErrorEvent) {
      yield ErroredState();
    }
  }
}
