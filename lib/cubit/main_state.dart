part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainError extends MainLoading {}

class MainSuccess extends MainLoading {}
