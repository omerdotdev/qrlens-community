class QRCode {
  final int id;
  final String qrString;
  final String type;

  QRCode(this.id, this.qrString, this.type);

  QRCode.fromJson(Map json)
      : id = json['id'],
        qrString = json['qrString'],
        type = json['type'];

  QRCode copyWith({int? id, String? qrstring, String? type}) {
    return QRCode(id ?? this.id, qrstring ?? qrString, type ?? this.type);
  }
}
