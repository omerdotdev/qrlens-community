part of 'qrbloc_bloc.dart';

@immutable
abstract class QRState extends Equatable {}

class QRInitial extends QRState {
  @override
  List<Object> get props => [];
}

class QRInstanceState extends QRState {
  final QRCode code;
  QRInstanceState(this.code);
  @override
  List<Object> get props => [code];
}
