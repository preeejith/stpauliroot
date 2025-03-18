class StudentFeeListModel {
  List<FeeDetails>? feeDetails;
  int? totalAmount;

  StudentFeeListModel({this.feeDetails, this.totalAmount});

  StudentFeeListModel.fromJson(Map<String, dynamic> json) {
    if (json['feeDetails'] != null) {
      feeDetails = <FeeDetails>[];
      json['feeDetails'].forEach((v) {
        feeDetails!.add(FeeDetails.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feeDetails != null) {
      data['feeDetails'] = feeDetails!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class FeeDetails {
  int? feeId;
  String? feeName;
  bool? checkboxvalue = true;
  int? feeValue;
  int? paidAmount;
  int? balance;

  FeeDetails(
      {this.feeId, this.feeName, this.feeValue, this.paidAmount, this.balance,this.checkboxvalue});

  FeeDetails.fromJson(Map<String, dynamic> json) {
    feeId = json['feeId'];
    feeName = json['feeName'];
    feeValue = json['feeValue'];
    paidAmount = json['paidAmount'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeId'] = feeId;
    data['feeName'] = feeName;
    data['feeValue'] = feeValue;
    data['paidAmount'] = paidAmount;
    data['balance'] = balance;
    return data;
  }
}
