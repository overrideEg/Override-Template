class User {
  String? token;
  UserInfo? user;

  User({this.token, this.user});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserInfo.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserInfo {
  bool? enableNotification;
  bool? isActive;
  String? userType;
  String? image;
  // List<Null> orders;
  // List<Null> addresses;
  String? name;
  String? sId;
  String? mobile;
  String? email;
  String? fcmToken;

  UserInfo(
      {this.enableNotification,
      this.isActive,
      this.userType,
      // this.orders,
      // this.addresses,
      this.name,
      this.sId,
      this.mobile,
      this.email,
      this.fcmToken});

  UserInfo.fromJson(Map<String, dynamic> json) {
    enableNotification = json['enableNotification'];
    isActive = json['isActive'];
    userType = json['userType'];
    image = json['image'];
    // if (json['orders'] != null) {
    //   orders = new List<Null>();
    //   json['orders'].forEach((v) {
    //     orders.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['addresses'] != null) {
    //   addresses = new List<Null>();
    //   json['addresses'].forEach((v) {
    //     addresses.add(new Null.fromJson(v));
    //   });
    // }
    name = json['name'];
    sId = json['_id'];
    mobile = json['mobile'];
    email = json['email'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enableNotification'] = this.enableNotification;
    data['isActive'] = this.isActive;
    data['userType'] = this.userType;
    data['image'] = this.image;
    // if (this.orders != null) {
    //   data['orders'] = this.orders.map((v) => v.toJson()).toList();
    // }
    // if (this.addresses != null) {
    //   data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    // }
    data['name'] = this.name;
    data['uid'] = this.sId;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}
