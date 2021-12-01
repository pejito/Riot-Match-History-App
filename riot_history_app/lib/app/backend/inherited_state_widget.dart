import 'package:flutter/material.dart';

class StateWidget extends StatefulWidget {
  final Widget child;

  const StateWidget({
    Key? key,
    required this.child,
  }) : super(key:key);
  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  String summonerName = 'TESTING';
  void updateSummonerName(String summonerN){
    setState(() => summonerName = summonerN);
  }

  @override
  Widget build(BuildContext context) => StateInheritedWidget(child: widget.child,
    summonerName: summonerName,
  stateWidget: this);
}


class StateInheritedWidget extends InheritedWidget{
  final String summonerName;
  final _StateWidgetState stateWidget;

  const StateInheritedWidget({
    Key? key,
    required Widget child,
    required this.summonerName,
    required this.stateWidget,
}) : super(key:key, child:child);

  static _StateWidgetState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<StateInheritedWidget>()!.stateWidget;

  @override
  bool updateShouldNotify(StateInheritedWidget oldWidget) => oldWidget.summonerName != summonerName;

}
