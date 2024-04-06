import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Status {
  Status({
    this.id,
    this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: asT<String?>(json['id']),
    status: asT<String?>(json['status']),
  );

  String? id;
  String? status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'status': status,
  };
}
