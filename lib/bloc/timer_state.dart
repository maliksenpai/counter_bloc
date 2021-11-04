class TimerState{}

class TimerInitState extends TimerState{}

class IncrementedState extends TimerState{

  int value;

  IncrementedState({required this.value});

}

class DescedState extends TimerState{

  int value;

  DescedState({required this.value});
}

class ResetedState extends TimerState{

  int value;

  ResetedState({required this.value});

}