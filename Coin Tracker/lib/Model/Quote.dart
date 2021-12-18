
import 'USD.dart';

class Quote {
  USD uSD;

  Quote(this.uSD);

  factory Quote.fromJson(Map<String, dynamic> json) {

    return Quote(
        json['USD'] != null ? new USD.fromJson(json['USD']) : null
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD.toJson();
    }
    return data;
  }
}