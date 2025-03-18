class StaffSectionModel {
  List<Data>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  StaffSectionModel(
      {this.data, this.msg, this.responseCode, this.additionalData});

  StaffSectionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
    responseCode = json['responseCode'];
    additionalData = json['additionalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['responseCode'] = this.responseCode;
    data['additionalData'] = this.additionalData;
    return data;
  }
}

class Data {
  int? dataListItemId;
  String? dataListItemName;
  String? dataListId;
  String? dataListName;
  String? status;

  Data(
      {this.dataListItemId,
      this.dataListItemName,
      this.dataListId,
      this.dataListName,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    dataListItemId = json['dataListItemId'];
    dataListItemName = json['dataListItemName'];
    dataListId = json['dataListId'];
    dataListName = json['dataListName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataListItemId'] = this.dataListItemId;
    data['dataListItemName'] = this.dataListItemName;
    data['dataListId'] = this.dataListId;
    data['dataListName'] = this.dataListName;
    data['status'] = this.status;
    return data;
  }
}
