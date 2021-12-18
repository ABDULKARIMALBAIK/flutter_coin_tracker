class Status {
  String timestamp;
  int errorCode;
  Null errorMessage;
  int elapsed;
  int creditCount;
  Null notice;

  Status(
      this.timestamp,
      this.errorCode,
      this.errorMessage,
      this.elapsed,
      this.creditCount,
      this.notice);

  factory Status.fromJson(Map<String, dynamic> json) {

    String timestamp = json['timestamp'];
    int errorCode = json['error_code'];
    Null errorMessage = json['error_message'];
    int elapsed = json['elapsed'];
    int creditCount = json['credit_count'];
    Null notice = json['notice'];

    return Status(
        timestamp,
        errorCode,
        errorMessage,
        elapsed,
        creditCount,
        notice
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['error_code'] = this.errorCode;
    data['error_message'] = this.errorMessage;
    data['elapsed'] = this.elapsed;
    data['credit_count'] = this.creditCount;
    data['notice'] = this.notice;
    return data;
  }
}