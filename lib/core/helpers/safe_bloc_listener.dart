import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SafeBlocListener<B extends BlocBase<S>, S> extends StatelessWidget {
  final BlocWidgetListener<S> listener;
  final Widget child;
  final B? bloc;
  final BlocListenerCondition<S>? condition;

  const SafeBlocListener({
    Key? key,
    required this.listener,
    required this.child,
    this.bloc,
    this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      bloc: bloc,
      // condition: condition,
      listener: _safeListener,
      child: child,
    );
  }

  void _safeListener(BuildContext context, S state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        listener(context, state);
      }
    });
  }
}