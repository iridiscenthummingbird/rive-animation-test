import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  late SMITrigger _check;
  late SMITrigger _error;
  //late SMITrigger _reset;

  StateMachineController? _getController(Artboard artboard) {
    return StateMachineController.fromArtboard(artboard, 'State Machine 1');
  }

  int _random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void onInitAnimation(Artboard artboard) {
    final controller = _getController(artboard);
    if (controller != null) {
      artboard.addController(controller);

      _check = controller.findSMI('Check');
      _error = controller.findSMI('Error');
      //_reset = controller.findSMI('Reset');
    }
  }

  Future<void> _load(Function changeState) async {
    emit(MainLoading());
    await Future.delayed(Duration(milliseconds: _random(1500, 3000)));
    changeState();

    await Future.delayed(const Duration(seconds: 2));
    emit(MainInitial());
  }

  Future<void> getSuccess() async {
    await _load(() {
      _check.fire();
      emit(MainSuccess());
    });
  }

  Future<void> getError() async {
    await _load(() {
      _error.fire();
      emit(MainError());
    });
  }
}
