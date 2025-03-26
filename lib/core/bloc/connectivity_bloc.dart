// // ignore_for_file: invalid_use_of_visible_for_testing_member

// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:codebase_project_assignment/core/platform/network_info.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:equatable/equatable.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// part 'connectivity_event.dart';
// part 'connectivity_state.dart';

// class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
//   final NetworkInfo networkInfo;
//   StreamSubscription<List<ConnectivityResult>>? _subscription;
//   ConnectivityBloc({required this.networkInfo}) : super(ConnectivityInitial()) {
//     on<ConnectivityEvent>((event, emit) {});

//     //
//     _subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((result) => _handleConnectivityChange(result));

//     //
//     on<CheckConnectivity>(_onCheckConnectivity);

//     // Start listening to connectivity changes
//     // ✅ Continuously listen to internet changes
//     // _subscription = Connectivity().onConnectivityChanged.listen((_) async {
//     //   bool hasInternet = await networkInfo.isConnected;
//     //   if (hasInternet) {
//     //     emit(ConnectivityOnline(
//     //         time: DateTime.now()
//     //             .millisecondsSinceEpoch)); // ✅ Emits online state when internet is available
//     //   } else {
//     //     emit(ConnectivityOffline(
//     //         time: DateTime.now()
//     //             .millisecondsSinceEpoch)); // ✅ Emits offline state when internet is lost
//     //   }
//     // });
//   }
//   void _handleConnectivityChange(List<ConnectivityResult> result) async {
//     print("📡 Connectivity Changed: $result");
//     try {
//       emit(CheckConnectionLoadingState(
//           time: DateTime.now().millisecondsSinceEpoch));
//       bool isOnline =
//           await InternetConnectionChecker.createInstance().hasConnection;

//       if (result.contains(ConnectivityResult.wifi) ||
//           result.contains(ConnectivityResult.mobile)) {
//         if (isOnline) {
//           emit(ConnectivityOnline(time: DateTime.now().millisecondsSinceEpoch));
//         } else {
//           emit(
//               ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
//         }
//       } else {
//         emit(ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
//       }
//     } catch (error) {
//       emit(ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
//     }
//   }

//   Future<void> _onCheckConnectivity(
//       CheckConnectivity event, Emitter<ConnectivityState> emit) async {
//     if (await networkInfo.isConnected) {
//       emit(ConnectivityOnline(time: DateTime.now().millisecondsSinceEpoch));
//     } else {
//       emit(ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
//     }
//   }

//   @override
//   Future<void> close() {
//     _subscription?.cancel(); // ✅ Stop listening when Bloc is closed
//     return super.close();
//   }
// }

// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:codebase_project_assignment/core/platform/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo networkInfo;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityBloc({required this.networkInfo}) : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((result) => _handleConnectivityChange(result));
  }

  void _handleConnectivityChange(List<ConnectivityResult> result) async {
    try {
      emit(CheckConnectionLoadingState(
          time: DateTime.now().millisecondsSinceEpoch));

      bool isOnline = await InternetConnectionChecker.createInstance()
          .hasConnection; // ✅ Check real internet

      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        if (isOnline) {
          emit(ConnectivityOnline(time: DateTime.now().millisecondsSinceEpoch));
        } else {
          emit(
              ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
        }
      } else {
        emit(ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
      }
    } catch (error) {
      emit(ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
    }
  }

  Future<void> _onCheckConnectivity(
      CheckConnectivity event, Emitter<ConnectivityState> emit) async {
    if (await networkInfo.isConnected) {
      emit(ConnectivityOnline(time: DateTime.now().millisecondsSinceEpoch));
    } else {
      emit(ConnectivityOffline(time: DateTime.now().millisecondsSinceEpoch));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel(); // ✅ Stop listening when Bloc is closed
    return super.close();
  }
}
