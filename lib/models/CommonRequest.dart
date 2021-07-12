class CommonRequest{
  String limit = "10";
  String page_no = "1";
  String search = "";
  String userRole = "3"; //send 2 for reseller, 3 for normal user

  CommonRequest({this.limit, this.page_no, this.search, this.userRole});

  CommonRequest.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page_no = json['page_no'];
    search = json['search'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page_no'] = this.page_no;
    data['search'] = this.search;
    data['userRole'] = this.userRole;
    return data;
  }
}

class CartRequest{
  String productId = "";
  String quantity = "1";

  CartRequest(this.productId, this.quantity);
}

class AddressRequest{
  String customer_name = "";
  String mobile = "";
  String street_address = "";
  String landmark = "";
  String city = "";
  String state = "";
  String country = "";
  String zip = "";

  AddressRequest(this.customer_name, this.mobile, this.street_address,
      this.landmark, this.city, this.state, this.country, this.zip);

  AddressRequest.fromJson(Map<String, dynamic> json) {
    customer_name = json['customer_name'];
    mobile = json['mobile'];
    street_address = json['street_address'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customer_name;
    data['mobile'] = this.mobile;
    data['street_address'] = this.street_address;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    return data;
  }
}

class PromoRequest{
  String code = "";
  String noOfUse = "";
  String discount = "";
  String expireDate = "";

  PromoRequest(this.code, this.noOfUse, this.discount, this.expireDate);

  PromoRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    noOfUse = json['noOfUse'];
    discount = json['discount'];
    expireDate = json['expireDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['noOfUse'] = this.noOfUse;
    data['discount'] = this.discount;
    data['expireDate'] = this.expireDate;
    return data;
  }
}
