import 'Platform.dart';
import 'Quote.dart';

class Data {
  int id;
  String name;
  String symbol;
  String slug;
  int numMarketPairs;
  String dateAdded;
  List<String> tags;
  var maxSupply;
  var circulatingSupply;
  var totalSupply;
  Platform platform;
  int cmcRank;
  String lastUpdated;
  Quote quote;

  Data(
      this.id,
      this.name,
      this.symbol,
      this.slug,
      this.numMarketPairs,
      this.dateAdded,
      this.tags,
      this.maxSupply,
      this.circulatingSupply,
      this.totalSupply,
      this.platform,
      this.cmcRank,
      this.lastUpdated,
      this.quote);

  factory Data.fromJson(Map<String, dynamic> json) {

    int id = json['id'];
    String name = json['name'];
    String symbol = json['symbol'];
    String slug = json['slug'];
    int numMarketPairs = json['num_market_pairs'];
    String dateAdded = json['date_added'];
    List<String> tags = json['tags'].cast<String>();
    var maxSupply = json['max_supply'];
    var circulatingSupply = json['circulating_supply'];
    var totalSupply = json['total_supply'];
    Platform platform = json['platform'] != null
        ? new Platform.fromJson(json['platform'])
        : null;
    int cmcRank = json['cmc_rank'];
    String lastUpdated = json['last_updated'];
    Quote quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;

//    return Data(
//        json['id'],
//        json['name'].toString(),
//        json['symbol'].toString(),
//        json['slug'].toString(),
//        json['num_market_pairs'],
//        json['date_added'].toString(),
//        json['tags'].cast<String>(),
//        json['max_supply'],
//        json['circulating_supply'],
//        json['total_supply'],
//        json['platform'] != null ? new Platform.fromJson(json['platform']) : null,
//        json['cmc_rank'],
//        json['last_updated'].toString(),
//        json['quote'] != null ? new Quote.fromJson(json['quote']) : null
//    );

  return Data(
    id,
    name,
    symbol,
    slug,
    numMarketPairs,
    dateAdded,
    tags,
    maxSupply,
    circulatingSupply,
    totalSupply,
    platform,
    cmcRank,
    lastUpdated,
    quote
  );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['num_market_pairs'] = this.numMarketPairs;
    data['date_added'] = this.dateAdded;
    data['tags'] = this.tags;
    data['max_supply'] = this.maxSupply;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    if (this.platform != null) {
      data['platform'] = this.platform.toJson();
    }
    data['cmc_rank'] = this.cmcRank;
    data['last_updated'] = this.lastUpdated;
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    return data;
  }
}