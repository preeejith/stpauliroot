import 'dart:convert';
//issue facing page
StudentDetails studentDetailsFromJson(String str) =>
    StudentDetails.fromJson(json.decode(str));

class StudentDetails {
  List<Student?> data;
  String? msg;
  String? responseCode;
  String? additionalData;

  StudentDetails({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        // data: List<StudentDetailsData>.from(
        //     json["data"].map((x) => StudentDetailsData.fromJson(x))),

        data: json["data"] == null
            ? []
            : List<Student>.from(json["data"]!.map((x) => Student.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class StudentDetailsData {
  Student student;

  StudentDetailsData({
    required this.student,
  });

  factory StudentDetailsData.fromJson(Map<String, dynamic> json) =>
      StudentDetailsData(
        student: Student.fromJson(json["student"]),
      );
}

class Student {
  int? studentId;
  String? applicationNumber;
  String? className;
  String? uin;
  String? date;
  String? name;
  String? studentClass;
  String? section;
  String? gender;
  int? ageInWords;
  String? dob;
  String? pob;
  String? nationality;
  String? religion;
  String? motherTongue;
  String? category;
  String? bloodGroup;
  String? medicalHistory;
  String? hobbies;
  String? sports;
  String? otherDetails;
  String? profileAvatar;
  DateTime addedDate;
  DateTime modifiedDate;
  String? ip;
  String? userId;
  bool isDeleted;
  int? createBy;
  int? currentYear;
  String? insertBy;
  String? markForIdentity;
  String? otherLanguages;
  String? medium;
  String? caste;
  String? rte;
  String? adharNo;
  String? adharFile;
  String? batchName;
  bool isApplyforTc;
  bool isApplyforAdmission;
  int? isApprove;
  bool isActive;
  String? isInsertFromAd;
  String? isAdmissionPaid;
  String? regNumber;
  int? classId;
  int? categoryId;
  int? batchId;
  String? parentEmail;
  String? admissionFeePaid;
  String? lastName;
  String? transport;
  String? transportOptions;
  String? mobile;
  String? city;
  String? state;
  String? pincode;
  int? bloodGroupId;
  bool isPromoted;
  int? sectionId;
  String? rollNo;
  int? scholarNo;
  List<dynamic> additionalInformations;
  List<dynamic> guardianDetails;
  List<dynamic> pastSchoolingReports;
  List<dynamic> studentRemoteAccesses;
  List<dynamic> studentTcDetails;
  List<dynamic> tcFeeDetails;

  Student({
    required this.studentId,
    required this.applicationNumber,
    required this.className,
    required this.uin,
    required this.date,
    required this.name,
    required this.studentClass,
    required this.section,
    required this.gender,
    required this.ageInWords,
    required this.dob,
    required this.pob,
    required this.nationality,
    required this.religion,
    required this.motherTongue,
    required this.category,
    required this.bloodGroup,
    required this.medicalHistory,
    required this.hobbies,
    required this.sports,
    required this.otherDetails,
    required this.profileAvatar,
    required this.addedDate,
    required this.modifiedDate,
    required this.ip,
    required this.userId,
    required this.isDeleted,
    required this.createBy,
    required this.currentYear,
    required this.insertBy,
    required this.markForIdentity,
    required this.otherLanguages,
    required this.medium,
    required this.caste,
    required this.rte,
    required this.adharNo,
    required this.adharFile,
    required this.batchName,
    required this.isApplyforTc,
    required this.isApplyforAdmission,
    required this.isApprove,
    required this.isActive,
    required this.isInsertFromAd,
    required this.isAdmissionPaid,
    required this.regNumber,
    required this.classId,
    required this.categoryId,
    required this.batchId,
    required this.parentEmail,
    required this.admissionFeePaid,
    required this.lastName,
    required this.transport,
    required this.transportOptions,
    required this.mobile,
    required this.city,
    required this.state,
    required this.pincode,
    required this.bloodGroupId,
    required this.isPromoted,
    required this.sectionId,
    required this.rollNo,
    required this.scholarNo,
    required this.additionalInformations,
    required this.guardianDetails,
    required this.pastSchoolingReports,
    required this.studentRemoteAccesses,
    required this.studentTcDetails,
    required this.tcFeeDetails,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json["studentId"],
        applicationNumber: json["applicationNumber"],
        className: json["class"],
        uin: json["uin"],
        date: json["date"],
        name: json["name"],
        studentClass: json["class"],
        section: json["section"],
        gender: json["gender"],
        ageInWords: json["ageInWords"],
        dob: json["dob"],
        pob: json["pob"],
        nationality: json["nationality"],
        religion: json["religion"],
        motherTongue: json["motherTongue"],
        category: json["category"],
        bloodGroup: json["bloodGroup"],
        medicalHistory: json["medicalHistory"],
        hobbies: json["hobbies"],
        sports: json["sports"],
        otherDetails: json["otherDetails"],
        profileAvatar: json["profileAvatar"],
        addedDate: DateTime.parse(json["addedDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        ip: json["ip"],
        userId: json["userId"],
        isDeleted: json["isDeleted"],
        createBy: json["createBy"],
        currentYear: json["currentYear"],
        insertBy: json["insertBy"],
        markForIdentity: json["markForIdentity"],
        otherLanguages: json["otherLanguages"],
        medium: json["medium"],
        caste: json["caste"],
        rte: json["rte"],
        adharNo: json["adharNo"],
        adharFile: json["adharFile"],
        batchName: json["batchName"],
        isApplyforTc: json["isApplyforTc"],
        isApplyforAdmission: json["isApplyforAdmission"],
        isApprove: json["isApprove"],
        isActive: json["isActive"],
        isInsertFromAd: json["isInsertFromAd"],
        isAdmissionPaid: json["isAdmissionPaid"],
        regNumber: json["regNumber"],
        classId: json["classId"],
        categoryId: json["categoryId"],
        batchId: json["batchId"],
        parentEmail: json["parentEmail"],
        admissionFeePaid: json["admissionFeePaid"],
        lastName: json["lastName"],
        transport: json["transport"],
        transportOptions: json["transportOptions"],
        mobile: json["mobile"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        bloodGroupId: json["bloodGroupId"],
        isPromoted: json["isPromoted"],
        sectionId: json["sectionId"],
        rollNo: json["rollNo"],
        scholarNo: json["scholarNo"],
        additionalInformations:
            List<dynamic>.from(json["additionalInformations"].map((x) => x)),
        guardianDetails:
            List<dynamic>.from(json["guardianDetails"].map((x) => x)),
        pastSchoolingReports:
            List<dynamic>.from(json["pastSchoolingReports"].map((x) => x)),
        studentRemoteAccesses:
            List<dynamic>.from(json["studentRemoteAccesses"].map((x) => x)),
        studentTcDetails:
            List<dynamic>.from(json["studentTcDetails"].map((x) => x)),
        tcFeeDetails: List<dynamic>.from(json["tcFeeDetails"].map((x) => x)),
      );
}
