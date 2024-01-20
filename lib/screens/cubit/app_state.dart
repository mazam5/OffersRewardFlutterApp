part of 'app_cubit.dart';

class AppState extends Equatable {
  final List<Model1> data1;
  final List<Model2> data2;

  const AppState({
    required this.data1,
    required this.data2,
  });

  AppState copyWith({
    List<Model1>? data1,
    List<Model2>? data2,
  }) {
    return AppState(
      data1: data1 ?? this.data1,
      data2: data2 ?? this.data2,
    );
  }

  @override
  List<Object> get props => [
        data1,
        data2,
      ];
}
