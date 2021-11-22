part of 'qrbloc_bloc.dart';

@immutable
abstract class QREvent extends Equatable {}

class QRInit extends QREvent {
  @override
  List<Object> get props => [];
}

class QRLoad extends QREvent {
  final QRCode code;
  QRLoad(this.code);
  @override
  List<Object> get props => [code];
}

class QRSave extends QREvent {
  final QRCode code;
  QRSave(this.code);
  @override
  List<Object> get props => [code];
}
