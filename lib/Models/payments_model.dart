/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Payments {
  String? id;
  String? selectedCustomerName;
  String? date;
  String? invoice;
  double? totalprice;
  bool? ispaid;

  Payments(
      {this.id,
      this.selectedCustomerName,
      this.date,
      this.invoice,
      this.totalprice,
      this.ispaid});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selectedCustomerName = json['selectedCustomerName'];
    date = json['date'];
    invoice = json['invoice'];
    totalprice = json['totalprice'];
    ispaid = json['ispaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['selectedCustomerName'] = selectedCustomerName;
    data['date'] = date;
    data['invoice'] = invoice;
    data['totalprice'] = totalprice;
    data['ispaid'] = ispaid;
    return data;
  }
}
