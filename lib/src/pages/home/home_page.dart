import 'package:flutter/material.dart';
import 'package:stepper_bloc_example/src/pages/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _steps = <Step>[
      Step(
        title: const Text(
          "Step 1",
        ),
        isActive: true,
        state: StepState.complete,
        content: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Input 1'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Input 2'),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text(
          "Step 2",
        ),
        isActive: true,
        state: StepState.editing,
        content: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Input 1'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Input 2'),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text(
          "Step 3",
        ),
        isActive: true,
        state: StepState.error,
        content: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Input 1'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Input 2'),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: StreamBuilder<bool>(
          stream: _homeBloc.getStatus,
          initialData: false,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                !snapshot.data
                    ? Expanded(
                        child: StreamBuilder<int>(
                            stream: _homeBloc.getStep,
                            initialData: 0,
                            builder: (context, snapshot) {
                              return Stepper(
                                steps: _steps,
                                currentStep: snapshot.data,
                                onStepContinue: () => _homeBloc.next(_steps.length),
                                onStepTapped: (step) => _homeBloc.goTo(step),
                                onStepCancel: _homeBloc.cancel,
                              );
                            }),
                      )
                    : Expanded(
                        child: Center(
                          child: AlertDialog(
                            title: new Text("Form Completed"),
                            content: new Text(
                              "Complete.",
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {
                                  _homeBloc.setStatus.add(false);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            );
          }),
    );
  }
}
