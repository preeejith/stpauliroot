import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));


class Welcome {
  List<AdminStaffData> data;
  String msg;
  String responseCode;
  String additionalData;

  Welcome({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    data: List<AdminStaffData>.from(json["data"].map((x) => AdminStaffData.fromJson(x))),
    msg: json["msg"],
    responseCode: json["responseCode"],
    additionalData: json["additionalData"],
  );

}

class AdminStaffData {
  int stafId;
  dynamic uin;
  dynamic date;
  String name;
  Gender gender;
  int ageInWords;
  String? dob;
  dynamic pob;
  dynamic nationality;
  String? religion;
  String? qualification;
  String? workExperience;
  dynamic motherTongue;
  String? category;
  dynamic bloodGroup;
  dynamic medicalHistory;
  String? address;
  String? contact;
  String? email;
  dynamic besicSallery;
  dynamic perksSallery;
  dynamic grossSallery;
  dynamic lastOrganizationofEmployment;
  dynamic noofYearsattheLastAssignment;
  dynamic relievingLetter;
  dynamic performanceLetter;
  dynamic file;
  dynamic otherDetails;
  String empId;
  dynamic otherLanguages;
  String? empDate;
  FormalitiesCheck formalitiesCheck;
  DateTime addedDate;
  DateTime modifiedDate;
  int currentYear;
  Ip ip;
  String? userId;
  bool isDeleted;
  int createBy;
  dynamic insertBy;
  dynamic designation;
  String? fatherOrHusbandName;
  dynamic mothersName;
  MariedStatus mariedStatus;
  String? children;
  dynamic besicSallery1;
  dynamic perksSallery1;
  dynamic grossSallery1;
  dynamic caste;
  dynamic dateofReliving;
  String? adharNo;
  dynamic adharFile;
  String? panNo;
  dynamic panFile;
  dynamic staffSignatureFile;
  dynamic bankAcno;
  dynamic batchName;
  String? employeeCode;
  dynamic bankName;
  dynamic accountNo;
  dynamic ifscCode;
  String? employeeDesignation;
  int employeeAccountId;
  dynamic employeeAccountName;
  int categoryId;
  dynamic staffCategoryName;
  dynamic uan;

  AdminStaffData({
    required this.stafId,
    required this.uin,
    required this.date,
    required this.name,
    required this.gender,
    required this.ageInWords,
    required this.dob,
    required this.pob,
    required this.nationality,
    required this.religion,
    required this.qualification,
    required this.workExperience,
    required this.motherTongue,
    required this.category,
    required this.bloodGroup,
    required this.medicalHistory,
    required this.address,
    required this.contact,
    required this.email,
    required this.besicSallery,
    required this.perksSallery,
    required this.grossSallery,
    required this.lastOrganizationofEmployment,
    required this.noofYearsattheLastAssignment,
    required this.relievingLetter,
    required this.performanceLetter,
    required this.file,
    required this.otherDetails,
    required this.empId,
    required this.otherLanguages,
    required this.empDate,
    required this.formalitiesCheck,
    required this.addedDate,
    required this.modifiedDate,
    required this.currentYear,
    required this.ip,
    required this.userId,
    required this.isDeleted,
    required this.createBy,
    required this.insertBy,
    required this.designation,
    required this.fatherOrHusbandName,
    required this.mothersName,
    required this.mariedStatus,
    required this.children,
    required this.besicSallery1,
    required this.perksSallery1,
    required this.grossSallery1,
    required this.caste,
    required this.dateofReliving,
    required this.adharNo,
    required this.adharFile,
    required this.panNo,
    required this.panFile,
    required this.staffSignatureFile,
    required this.bankAcno,
    required this.batchName,
    required this.employeeCode,
    required this.bankName,
    required this.accountNo,
    required this.ifscCode,
    required this.employeeDesignation,
    required this.employeeAccountId,
    required this.employeeAccountName,
    required this.categoryId,
    required this.staffCategoryName,
    required this.uan,
  });

  factory AdminStaffData.fromJson(Map<String, dynamic> json) => AdminStaffData(
    stafId: json["stafId"],
    uin: json["uin"],
    date: json["date"],
    name: json["name"],
    gender: genderValues.map[json["gender"]]!,
    ageInWords: json["ageInWords"],
    dob: json["dob"],
    pob: json["pob"],
    nationality: json["nationality"],
    religion: json["religion"],
    qualification: json["qualification"],
    workExperience: json["workExperience"],
    motherTongue: json["motherTongue"],
    category: json["category"],
    bloodGroup: json["bloodGroup"],
    medicalHistory: json["medicalHistory"],
    address: json["address"],
    contact: json["contact"],
    email: json["email"],
    besicSallery: json["besicSallery"],
    perksSallery: json["perksSallery"],
    grossSallery: json["grossSallery"],
    lastOrganizationofEmployment: json["lastOrganizationofEmployment"],
    noofYearsattheLastAssignment: json["noofYearsattheLastAssignment"],
    relievingLetter: json["relievingLetter"],
    performanceLetter: json["performanceLetter"],
    file: json["file"],
    otherDetails: json["otherDetails"],
    empId: json["empId"],
    otherLanguages: json["otherLanguages"],
    empDate: json["empDate"],
    formalitiesCheck: formalitiesCheckValues.map[json["formalitiesCheck"]]!,
    addedDate: DateTime.parse(json["addedDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
    currentYear: json["currentYear"],
    ip: ipValues.map[json["ip"]]!,
    userId: json["userId"],
    isDeleted: json["isDeleted"],
    createBy: json["createBy"],
    insertBy: json["insertBy"],
    designation: json["designation"],
    fatherOrHusbandName: json["fatherOrHusbandName"],
    mothersName: json["mothersName"],
    mariedStatus: mariedStatusValues.map[json["mariedStatus"]]!,
    children: json["children"],
    besicSallery1: json["besicSallery1"],
    perksSallery1: json["perksSallery1"],
    grossSallery1: json["grossSallery1"],
    caste: json["caste"],
    dateofReliving: json["dateofReliving"],
    adharNo: json["adharNo"],
    adharFile: json["adharFile"],
    panNo: json["panNo"],
    panFile: json["panFile"],
    staffSignatureFile: json["staffSignatureFile"],
    bankAcno: json["bankAcno"],
    batchName: json["batchName"],
    employeeCode: json["employeeCode"],
    bankName: json["bankName"],
    accountNo: json["accountNo"],
    ifscCode: json["ifscCode"],
    employeeDesignation: json["employeeDesignation"],
    employeeAccountId: json["employeeAccountId"],
    employeeAccountName: json["employeeAccountName"],
    categoryId: json["categoryId"],
    staffCategoryName: json["staffCategoryName"],
    uan: json["uan"],
  );

}

enum FormalitiesCheck {
  YES
}

final formalitiesCheckValues = EnumValues({
  "Yes": FormalitiesCheck.YES
});

enum Gender {
  FEMALE,
  MALE
}

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE
});

enum Ip {
  THE_1981222542
}

final ipValues = EnumValues({
  "198.12.225.42": Ip.THE_1981222542
});

enum MariedStatus {
  MARRIED,
  UNMARRIED
}

final mariedStatusValues = EnumValues({
  "Married": MariedStatus.MARRIED,
  "Unmarried": MariedStatus.UNMARRIED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
