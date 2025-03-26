part of 'connectivity_bloc.dart';

sealed class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class CheckConnectionLoadingState extends ConnectivityState {
  final int time;

  const CheckConnectionLoadingState({required this.time});
  @override
  List<Object> get props => [time];
}

class ConnectivityOnline extends ConnectivityState {
  final int time;

  const ConnectivityOnline({required this.time});
  @override
  List<Object> get props => [time];
}

class ConnectivityOffline extends ConnectivityState {
  final int time;

  const ConnectivityOffline({required this.time});
  @override
  List<Object> get props => [time];
}
