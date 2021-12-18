import 'Data.dart';
import 'Status.dart';

class Coin {
  Status status;
  List<Data> data;

  Coin(this.status, this.data);

  factory Coin.fromJson(Map<String, dynamic> json) {

    var data = new List<Data>();
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }

    return Coin(
        json['status'] != null ? new Status.fromJson(json['status']) : null,
        data
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
