class USD {
  var price;
  var volume24h;
  var percentChange1h;
  var percentChange24h;
  var percentChange7d;
  var marketCap;
  String lastUpdated;

  USD(
      this.price,
      this.volume24h,
      this.percentChange1h,
      this.percentChange24h,
      this.percentChange7d,
      this.marketCap,
      this.lastUpdated);

  factory USD.fromJson(Map<String, dynamic> json) {

    var price = json['price'];
    var volume_24h = json['volume_24h'];
    var percent_change_1h = json['percent_change_1h'];
    var percent_change_24h = json['percent_change_24h'];
    var percent_change_7d = json['percent_change_7d'];
    var market_cap = json['market_cap'];
    String last_updated = json['last_updated'].toString();

    return USD(
        price,
        volume_24h,
        percent_change_1h,
        percent_change_24h,
        percent_change_7d,
        market_cap,
        last_updated
    );

//    return USD(
//        json['price'] is double ? double.parse(json['price']) : double.parse(json['price']),
//        json['volume_24h'] is double ? double.parse(json['volume_24h']) : double.parse(json['volume_24h']),
//        json['percent_change_1h'] is double ? double.parse(json['percent_change_1h']) : double.parse(json['percent_change_1h']),
//        json['percent_change_24h'] is double ? double.parse(json['percent_change_24h']) : double.parse(json['percent_change_24h']),
//        json['percent_change_7d'] is double ? double.parse(json['percent_change_7d']) : double.parse(json['percent_change_7d']),
//        json['market_cap'] is double ? double.parse(json['market_cap']) : double.parse(json['market_cap']),
//        json['last_updated'].toString()
//    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['volume_24h'] = this.volume24h;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['market_cap'] = this.marketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}