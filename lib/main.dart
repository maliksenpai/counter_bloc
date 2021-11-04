import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/bloc/timer_bloc.dart';
import 'package:timer_bloc/bloc/timer_event.dart';
import 'package:timer_bloc/bloc/timer_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TimerBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late TimerBloc timerBloc;
  int value = 0;

  @override
  void initState() {
    timerBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: BlocListener(
          cubit: timerBloc,
          listener: (context, state) {
            if (state is IncrementedState) {
              setState(() {
                value = state.value;
              });
            } else if (state is DescedState) {
              setState(() {
                value = state.value;
              });
            } else if (state is ResetedState) {
              setState(() {
                value = state.value;
              });
            } else if (state is ErroredState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("0'dan daha küçük değer girilemez"),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              ));

              timerBloc.add(ResetEvent());
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 58.0),
            child: Column(
              children: [
                Text(value.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        value++;
                        timerBloc.add(IncrementEvent(currValue: value));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        value--;
                        if (value < 0) {
                          timerBloc.add(ErrorEvent());
                        } else {
                          timerBloc.add(DescEvent(currValue: value));
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        timerBloc.add(ResetEvent());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
