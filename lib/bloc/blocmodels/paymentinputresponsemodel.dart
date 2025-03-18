class PreparePaymentRepsonseModel {
  Data? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  PreparePaymentRepsonseModel(
      {this.data, this.msg, this.responseCode, this.additionalData});

  PreparePaymentRepsonseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    responseCode = json['responseCode'];
    additionalData = json['additionalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['responseCode'] = responseCode;
    data['additionalData'] = additionalData;
    return data;
  }
}

class Data {
  String? studentName;
  String? fatherName;
  String? contact;
  String? classstyu;
  String? section;
  String? category;
  String? roleNumber;
  String? tcBal;
  String? studentid;
  String? feeHeadings;
  String? feeheadingamt;
  String? applicationNumber;
  int? concession;
  int? concessionAmt;
  String? key;
  String? amount;
  String? currency;
  String? ordedrId;
  String? email;
  String? paymentid;
  int? classdetails;
  String? accountType;
  String? mobileNO;
  String? atomTokenId;
  Null trackID;
  String? custEmail;
  String? custMobile;
  String? merchId;
  String? returnurl;

  Data(
      {this.studentName,
      this.fatherName,
      this.contact,
      this.classstyu,
      this.section,
      this.category,
      this.roleNumber,
      this.tcBal,
      this.studentid,
      this.feeHeadings,
      this.feeheadingamt,
      this.applicationNumber,
      this.concession,
      this.concessionAmt,
      this.key,
      this.amount,
      this.currency,
      this.ordedrId,
      this.email,
      this.paymentid,
      this.classdetails,
      this.accountType,
      this.mobileNO,
      this.atomTokenId,
      this.trackID,
      this.custEmail,
      this.custMobile,
      this.merchId,
      this.returnurl});

  Data.fromJson(Map<String, dynamic> json) {
    studentName = json['studentName'];
    fatherName = json['fatherName'];
    contact = json['contact'];
    classstyu = json['class'];
    section = json['section'];
    category = json['category'];
    roleNumber = json['roleNumber'];
    tcBal = json['tcBal'];
    studentid = json['studentid'];
    feeHeadings = json['feeHeadings'];
    feeheadingamt = json['feeheadingamt'];
    applicationNumber = json['applicationNumber'];
    concession = json['concession'];
    concessionAmt = json['concessionAmt'];
    key = json['key'];
    amount = json['amount'];
    currency = json['currency'];
    ordedrId = json['ordedrId'];
    email = json['email'];
    paymentid = json['paymentid'];
    classdetails = json['classdetails'];
    accountType = json['accountType'];
    mobileNO = json['mobileNO'];
    atomTokenId = json['atomTokenId'];
    trackID = json['trackID'];
    custEmail = json['custEmail'];
    custMobile = json['custMobile'];
    merchId = json['merchId'];
    returnurl = json['returnurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentName'] = studentName;
    data['fatherName'] = fatherName;
    data['contact'] = contact;
    data['class'] = classstyu;
    data['section'] = section;
    data['category'] = category;
    data['roleNumber'] = roleNumber;
    data['tcBal'] = tcBal;
    data['studentid'] = studentid;
    data['feeHeadings'] = feeHeadings;
    data['feeheadingamt'] = feeheadingamt;
    data['applicationNumber'] = applicationNumber;
    data['concession'] = concession;
    data['concessionAmt'] = concessionAmt;
    data['key'] = key;
    data['amount'] = amount;
    data['currency'] = currency;
    data['ordedrId'] = ordedrId;
    data['email'] = email;
    data['paymentid'] = paymentid;
    data['classdetails'] = classdetails;
    data['accountType'] = accountType;
    data['mobileNO'] = mobileNO;
    data['atomTokenId'] = atomTokenId;
    data['trackID'] = trackID;
    data['custEmail'] = custEmail;
    data['custMobile'] = custMobile;
    data['merchId'] = merchId;
    data['returnurl'] = returnurl;
    return data;
  }
}
