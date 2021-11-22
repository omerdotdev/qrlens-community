import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class QRCode extends HiveType {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String qrString;
  @HiveField(2)
  final String type;
  @HiveField(3)
  bool pinned;

  QRCode(this.id, this.qrString, this.type, this.pinned);

  QRCode.fromJson(Map json)
      : id = json['id'],
        qrString = json['qrString'],
        type = json['type'],
        pinned = json['pinned'];

  QRCode copyWith({String id, String qrstring, String type, bool pinned}) {
    return QRCode(id ?? this.id, qrstring ?? this.qrString, type ?? this.type,
        pinned ?? this.pinned);
  }
}
