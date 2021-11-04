class TimerEvent{}

class IncrementEvent extends TimerEvent{

  int currValue;

  IncrementEvent({required this.currValue});

}

class DescEvent extends TimerEvent{

  int currValue;

  DescEvent({required this.currValue});
}

class ResetEvent extends TimerEvent{

}

