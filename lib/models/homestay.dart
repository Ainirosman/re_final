
// ignore_for_file: non_constant_identifier_names, camel_case_types

class homestay {
  String? prid;
  String? user_id;
  String? prname;
  String? prdesc;
  String? prprice;
  String? praddress;
  String? prstate;
  String? prloc;
  String? prlat;
  String? prlong;
  String? prdate;

  homestay(
      {this.prid,
      this.user_id,
      this.prname,
      this.prdesc,
      this.prprice,
      this.praddress,
      this.prstate,
      this.prloc,
      this.prlat,
      this.prlong,
      this.prdate});

  homestay.fromJson(Map<String, dynamic> json) {
    prid = json['prid'];
    user_id = json['user_id'];
    prname = json['prname'];
    prdesc = json['prdesc'];
    prprice = json['prprice'];
    praddress = json['praddress'];
    prstate = json['prstate'];
    prloc = json['prloc'];
    prlat = json['prlat'];
    prlong = json['prlong'];
    prdate = json['prdate'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prid'] = prid;
    data['user_id'] = user_id;
    data['prname'] = prname;
    data['prdesc'] = prdesc;
    data['prprice'] = prprice;
    data['praddress'] = praddress;
    data['prstate'] = prstate;
    data['prloc'] = prloc;
    data['prlat'] = prlat;
    data['prlong'] = prlong;
    data['prdate'] = prdate;
    return data;
  }
}
