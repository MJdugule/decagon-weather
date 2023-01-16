import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<dynamic> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  final String lat;
  final String lon;

  const Params({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}
