class Platform {
  int id;
  String name;
  String symbol;
  String slug;
  String tokenAddress;

  Platform(this.id, this.name, this.symbol, this.slug, this.tokenAddress);

  factory Platform.fromJson(Map<String, dynamic> json) {

    int id = json['id'];
    String name = json['name'];
    String symbol = json['symbol'];
    String slug = json['slug'];
    String tokenAddress = json['token_address'];

    return Platform(
      id,
      name,
      symbol,
      slug,
      tokenAddress
    );


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['token_address'] = this.tokenAddress;
    return data;
  }
}