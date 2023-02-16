class homestay {
  String? hsId;
  String? userId;
  String? prname;
  String? hsDesc;
  String? prprice;
  String? hsAddress;
  String? hsState;
  String? hsLocal;
  String? hsLat;
  String? hsLng;
  String? hsDate;

  homestay(
      {this.hsId,
      this.userId,
      this.prname,
      this.hsDesc,
      this.prprice,
      this.hsAddress,
      this.hsState,
      this.hsLocal,
      this.hsLat,
      this.hsLng,
      this.hsDate});

  homestay.fromJson(Map<String, dynamic> json) {
    hsId = json['hs_id'];
    userId = json['user_id'];
    prname = json['hs_name'];
    hsDesc = json['hs_desc'];
    prprice = json['hs_price'];
    hsAddress = json['hs_address'];
    hsState = json['hs_state'];
    hsLocal = json['hs_local'];
    hsLat = json['hs_lat'];
    hsLng = json['hs_lng'];
    hsDate = json['hs_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hs_id'] = hsId;
    data['user_id'] = userId;
    data['hs_name'] = prname;
    data['hs_desc'] = hsDesc;
    data['hs_price'] = prprice;
    data['hs_address'] = hsAddress;
    data['hs_state'] = hsState;
    data['hs_local'] = hsLocal;
    data['hs_lat'] = hsLat;
    data['hs_lng'] = hsLng;
    data['hs_date'] = hsDate;
    return data;
  }
}
