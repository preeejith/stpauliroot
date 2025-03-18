import 'dart:convert';

ShowStudentAttendanceModalClass showStudentAttendanceModalClassFromJson(
        String str) =>
    ShowStudentAttendanceModalClass.fromJson(json.decode(str));

String showStudentAttendanceModalClassToJson(
        ShowStudentAttendanceModalClass data) =>
    json.encode(data.toJson());

class ShowStudentAttendanceModalClass {
  List<ShowStudentAttendanceDatum>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  ShowStudentAttendanceModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory ShowStudentAttendanceModalClass.fromJson(Map<String, dynamic> json) =>
      ShowStudentAttendanceModalClass(
        // data: json["data"] == null
        //     ? []
        //     : List<ShowStudentAttendanceDatum>.from(json["data"][0]!
        //         .map((x) => ShowStudentAttendanceDatum.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<ShowStudentAttendanceDatum>.from(json["data"]!
                .map((x) => ShowStudentAttendanceDatum.fromJson(x))),
//  if (json['data'] != null) {
// 			data = <Data>[];
// 			json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
// 		}

        msg: json["msg"],
        responseCode: json["responseCode"],
        // additionalData: json["additionalData"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "responseCode": responseCode,
        "additionalData": additionalData,
      };
}

class ShowStudentAttendanceDatum {
  int? studentId;
  String? applicationNumber;
  String? uin;
  dynamic date;
  String? name;
  String? datumClass;
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
  dynamic medicalHistory;
  dynamic hobbies;
  dynamic sports;
  dynamic otherDetails;
  dynamic profileAvatar;
  DateTime? addedDate;
  DateTime? modifiedDate;
  String? ip;
  dynamic userId;
  bool? isDeleted;
  int? createBy;
  int? currentYear;
  dynamic insertBy;
  dynamic markForIdentity;
  dynamic otherLanguages;
  String? medium;
  String? caste;
  dynamic rte;
  String? adharNo;
  dynamic adharFile;
  String? batchName;
  bool? isApplyforTc;
  bool? isApplyforAdmission;
  int? isApprove;

  bool? isActive;
  dynamic isInsertFromAd;
  dynamic isAdmissionPaid;
  dynamic regNumber;
  int? classId;
  int? categoryId;
  int? batchId;
  String? parentEmail;
  dynamic admissionFeePaid;
  String? lastName;
  dynamic transport;
  dynamic transportOptions;
  dynamic mobile;
  dynamic city;
  dynamic state;
  dynamic pincode;
  int? bloodGroupId;
  bool? isPromoted;
  int? sectionId;
  dynamic rollNo;
  int? scholarNo;
  List<dynamic>? additionalInformations;
  List<dynamic>? guardianDetails;
  List<dynamic>? pastSchoolingReports;
  List<dynamic>? studentRemoteAccesses;
  List<dynamic>? studentTcDetails;
  List<dynamic>? tcFeeDetails;

  ShowStudentAttendanceDatum({
    this.studentId,
    this.applicationNumber,
    this.uin,
    this.date,
    this.name,
    this.datumClass,
    this.section,
    this.gender,
    this.ageInWords,
    this.dob,
    this.pob,
    this.nationality,
    this.religion,
    this.motherTongue,
    this.category,
    this.bloodGroup,
    this.medicalHistory,
    this.hobbies,
    this.sports,
    this.otherDetails,
    this.profileAvatar,
    this.addedDate,
    this.modifiedDate,
    this.ip,
    this.userId,
    this.isDeleted,
    this.createBy,
    this.currentYear,
    this.insertBy,
    this.markForIdentity,
    this.otherLanguages,
    this.medium,
    this.caste,
    this.rte,
    this.adharNo,
    this.adharFile,
    this.batchName,
    this.isApplyforTc,
    this.isApplyforAdmission,
    this.isApprove,
    this.isActive,
    this.isInsertFromAd,
    this.isAdmissionPaid,
    this.regNumber,
    this.classId,
    this.categoryId,
    this.batchId,
    this.parentEmail,
    this.admissionFeePaid,
    this.lastName,
    this.transport,
    this.transportOptions,
    this.mobile,
    this.city,
    this.state,
    this.pincode,
    this.bloodGroupId,
    this.isPromoted,
    this.sectionId,
    this.rollNo,
    this.scholarNo,
    this.additionalInformations,
    this.guardianDetails,
    this.pastSchoolingReports,
    this.studentRemoteAccesses,
    this.studentTcDetails,
    this.tcFeeDetails,
  });

  factory ShowStudentAttendanceDatum.fromJson(Map<String, dynamic> json) =>
      ShowStudentAttendanceDatum(
        studentId: json["studentId"],
        applicationNumber: json["applicationNumber"],
        uin: json["uin"],
        date: json["date"],
        name: json["name"],
        datumClass: json["class"],
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
        addedDate: json["addedDate"] == null
            ? null
            : DateTime.parse(json["addedDate"]),
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.parse(json["modifiedDate"]),
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
        additionalInformations: json["additionalInformations"] == null
            ? []
            : List<dynamic>.from(json["additionalInformations"]!.map((x) => x)),
        guardianDetails: json["guardianDetails"] == null
            ? []
            : List<dynamic>.from(json["guardianDetails"]!.map((x) => x)),
        pastSchoolingReports: json["pastSchoolingReports"] == null
            ? []
            : List<dynamic>.from(json["pastSchoolingReports"]!.map((x) => x)),
        studentRemoteAccesses: json["studentRemoteAccesses"] == null
            ? []
            : List<dynamic>.from(json["studentRemoteAccesses"]!.map((x) => x)),
        studentTcDetails: json["studentTcDetails"] == null
            ? []
            : List<dynamic>.from(json["studentTcDetails"]!.map((x) => x)),
        tcFeeDetails: json["tcFeeDetails"] == null
            ? []
            : List<dynamic>.from(json["tcFeeDetails"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "applicationNumber": applicationNumber,
        "uin": uin,
        "date": date,
        "name": name,
        "class": datumClass,
        "section": section,
        "gender": gender,
        "ageInWords": ageInWords,
        "dob": dob,
        "pob": pob,
        "nationality": nationality,
        "religion": religion,
        "motherTongue": motherTongue,
        "category": category,
        "bloodGroup": bloodGroup,
        "medicalHistory": medicalHistory,
        "hobbies": hobbies,
        "sports": sports,
        "otherDetails": otherDetails,
        "profileAvatar": profileAvatar,
        "addedDate": addedDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "ip": ip,
        "userId": userId,
        "isDeleted": isDeleted,
        "createBy": createBy,
        "currentYear": currentYear,
        "insertBy": insertBy,
        "markForIdentity": markForIdentity,
        "otherLanguages": otherLanguages,
        "medium": medium,
        "caste": caste,
        "rte": rte,
        "adharNo": adharNo,
        "adharFile": adharFile,
        "batchName": batchName,
        "isApplyforTc": isApplyforTc,
        "isApplyforAdmission": isApplyforAdmission,
        "isApprove": isApprove,
        "isActive": isActive,
        "isInsertFromAd": isInsertFromAd,
        "isAdmissionPaid": isAdmissionPaid,
        "regNumber": regNumber,
        "classId": classId,
        "categoryId": categoryId,
        "batchId": batchId,
        "parentEmail": parentEmail,
        "admissionFeePaid": admissionFeePaid,
        "lastName": lastName,
        "transport": transport,
        "transportOptions": transportOptions,
        "mobile": mobile,
        "city": city,
        "state": state,
        "pincode": pincode,
        "bloodGroupId": bloodGroupId,
        "isPromoted": isPromoted,
        "sectionId": sectionId,
        "rollNo": rollNo,
        "scholarNo": scholarNo,
        "additionalInformations": additionalInformations == null
            ? []
            : List<dynamic>.from(additionalInformations!.map((x) => x)),
        "guardianDetails": guardianDetails == null
            ? []
            : List<dynamic>.from(guardianDetails!.map((x) => x)),
        "pastSchoolingReports": pastSchoolingReports == null
            ? []
            : List<dynamic>.from(pastSchoolingReports!.map((x) => x)),
        "studentRemoteAccesses": studentRemoteAccesses == null
            ? []
            : List<dynamic>.from(studentRemoteAccesses!.map((x) => x)),
        "studentTcDetails": studentTcDetails == null
            ? []
            : List<dynamic>.from(studentTcDetails!.map((x) => x)),
        "tcFeeDetails": tcFeeDetails == null
            ? []
            : List<dynamic>.from(tcFeeDetails!.map((x) => x)),
      };
}





// class ShowStudentAttendanceDatum2 {
//   List<Data>? data;
//   String? msg;
//   String? responseCode;
//   String? additionalData;

//   ShowStudentAttendanceDatum2(
//       {this.data, this.msg, this.responseCode, this.additionalData});

//   ShowStudentAttendanceDatum2.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     msg = json['msg'];
//     responseCode = json['responseCode'];
//     additionalData = json['additionalData'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['msg'] = msg;
//     data['responseCode'] = responseCode;
//     data['additionalData'] = additionalData;
//     return data;
//   }
// }

// class Data {
//   ShowStudentAttendanceDatum? student;

//   Data({this.student});

//   Data.fromJson(Map<String, dynamic> json) {
//     student = json['student'] != null
//         ? ShowStudentAttendanceDatum.fromJson(json['student'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (student != null) {
//       // data['student'] = this.student.toJson();
//     }
//     return data;
//   }
// }

// class ShowStudentAttendanceDatum {
//   int? studentId;
//   String? applicationNumber;
//   String? uin;
//   Null date;
//   String? name;
//   String? classstdy;
//   Null section;
//   String? gender;
//   int? ageInWords;
//   String? dob;
//   Null pob;
//   String? nationality;
//   String? religion;
//   Null motherTongue;
//   String? category;
//   Null bloodGroup;
//   Null medicalHistory;
//   Null hobbies;
//   Null sports;
//   Null otherDetails;
//   Null profileAvatar;
//   String? addedDate;
//   String? modifiedDate;
//   Null ip;
//   Null userId;
//   bool? isDeleted;
//   int? createBy;
//   int? currentYear;
//   Null insertBy;
//   Null markForIdentity;
//   Null otherLanguages;
//   String? medium;
//   String? caste;
//   Null rte;
//   Null adharNo;
//   Null adharFile;
//   Null batchName;
//   bool? isApplyforTc;
//   bool? isApplyforAdmission;
//   int? isApprove;
//   bool? isActive;
//   Null isInsertFromAd;
//   Null isAdmissionPaid;
//   Null regNumber;
//   int? classId;
//   int? categoryId;
//   int? batchId;
//   String? parentEmail;
//   Null admissionFeePaid;
//   String? lastName;
//   Null transport;
//   Null transportOptions;
//   Null mobile;
//   Null city;
//   Null state;
//   Null pincode;
//   int? bloodGroupId;
//   bool? isPromoted;
//   int? sectionId;
//   Null rollNo;
//   Null scholarNo;
//   List<Null>? additionalInformations;
//   List<Null>? guardianDetails;
//   List<Null>? pastSchoolingReports;
//   List<Null>? studentRemoteAccesses;
//   List<Null>? studentTcDetails;
//   List<Null>? tcFeeDetails;

//   ShowStudentAttendanceDatum(
//       {this.studentId,
//       this.applicationNumber,
//       this.uin,
//       this.date,
//       this.name,
//       this.classstdy,
//       this.section,
//       this.gender,
//       this.ageInWords,
//       this.dob,
//       this.pob,
//       this.nationality,
//       this.religion,
//       this.motherTongue,
//       this.category,
//       this.bloodGroup,
//       this.medicalHistory,
//       this.hobbies,
//       this.sports,
//       this.otherDetails,
//       this.profileAvatar,
//       this.addedDate,
//       this.modifiedDate,
//       this.ip,
//       this.userId,
//       this.isDeleted,
//       this.createBy,
//       this.currentYear,
//       this.insertBy,
//       this.markForIdentity,
//       this.otherLanguages,
//       this.medium,
//       this.caste,
//       this.rte,
//       this.adharNo,
//       this.adharFile,
//       this.batchName,
//       this.isApplyforTc,
//       this.isApplyforAdmission,
//       this.isApprove,
//       this.isActive,
//       this.isInsertFromAd,
//       this.isAdmissionPaid,
//       this.regNumber,
//       this.classId,
//       this.categoryId,
//       this.batchId,
//       this.parentEmail,
//       this.admissionFeePaid,
//       this.lastName,
//       this.transport,
//       this.transportOptions,
//       this.mobile,
//       this.city,
//       this.state,
//       this.pincode,
//       this.bloodGroupId,
//       this.isPromoted,
//       this.sectionId,
//       this.rollNo,
//       this.scholarNo,
//       this.additionalInformations,
//       this.guardianDetails,
//       this.pastSchoolingReports,
//       this.studentRemoteAccesses,
//       this.studentTcDetails,
//       this.tcFeeDetails});

//   ShowStudentAttendanceDatum.fromJson(Map<String, dynamic> json) {
//     studentId = json['studentId'];
//     applicationNumber = json['applicationNumber'];
//     uin = json['uin'];
//     date = json['date'];
//     name = json['name'];
//     classstdy = json['class'];
//     section = json['section'];
//     gender = json['gender'];
//     ageInWords = json['ageInWords'];
//     dob = json['dob'];
//     pob = json['pob'];
//     nationality = json['nationality'];
//     religion = json['religion'];
//     motherTongue = json['motherTongue'];
//     category = json['category'];
//     bloodGroup = json['bloodGroup'];
//     medicalHistory = json['medicalHistory'];
//     hobbies = json['hobbies'];
//     sports = json['sports'];
//     otherDetails = json['otherDetails'];
//     profileAvatar = json['profileAvatar'];
//     addedDate = json['addedDate'];
//     modifiedDate = json['modifiedDate'];
//     ip = json['ip'];
//     userId = json['userId'];
//     isDeleted = json['isDeleted'];
//     createBy = json['createBy'];
//     currentYear = json['currentYear'];
//     insertBy = json['insertBy'];
//     markForIdentity = json['markForIdentity'];
//     otherLanguages = json['otherLanguages'];
//     medium = json['medium'];
//     caste = json['caste'];
//     rte = json['rte'];
//     adharNo = json['adharNo'];
//     adharFile = json['adharFile'];
//     batchName = json['batchName'];
//     isApplyforTc = json['isApplyforTc'];
//     isApplyforAdmission = json['isApplyforAdmission'];
//     isApprove = json['isApprove'];
//     isActive = json['isActive'];
//     isInsertFromAd = json['isInsertFromAd'];
//     isAdmissionPaid = json['isAdmissionPaid'];
//     regNumber = json['regNumber'];
//     classId = json['classId'];
//     categoryId = json['categoryId'];
//     batchId = json['batchId'];
//     parentEmail = json['parentEmail'];
//     admissionFeePaid = json['admissionFeePaid'];
//     lastName = json['lastName'];
//     transport = json['transport'];
//     transportOptions = json['transportOptions'];
//     mobile = json['mobile'];
//     city = json['city'];
//     state = json['state'];
//     pincode = json['pincode'];
//     bloodGroupId = json['bloodGroupId'];
//     isPromoted = json['isPromoted'];
//     sectionId = json['sectionId'];
//     rollNo = json['rollNo'];
//     scholarNo = json['scholarNo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['studentId'] = studentId;
//     data['applicationNumber'] = applicationNumber;
//     data['uin'] = uin;
//     data['date'] = date;
//     data['name'] = name;
//     data['class'] = classstdy;
//     data['section'] = section;
//     data['gender'] = gender;
//     data['ageInWords'] = ageInWords;
//     data['dob'] = dob;
//     data['pob'] = pob;
//     data['nationality'] = nationality;
//     data['religion'] = religion;
//     data['motherTongue'] = motherTongue;
//     data['category'] = category;
//     data['bloodGroup'] = bloodGroup;
//     data['medicalHistory'] = medicalHistory;
//     data['hobbies'] = hobbies;
//     data['sports'] = sports;
//     data['otherDetails'] = otherDetails;
//     data['profileAvatar'] = profileAvatar;
//     data['addedDate'] = addedDate;
//     data['modifiedDate'] = modifiedDate;
//     data['ip'] = ip;
//     data['userId'] = userId;
//     data['isDeleted'] = isDeleted;
//     data['createBy'] = createBy;
//     data['currentYear'] = currentYear;
//     data['insertBy'] = insertBy;
//     data['markForIdentity'] = markForIdentity;
//     data['otherLanguages'] = otherLanguages;
//     data['medium'] = medium;
//     data['caste'] = caste;
//     data['rte'] = rte;
//     data['adharNo'] = adharNo;
//     data['adharFile'] = adharFile;
//     data['batchName'] = batchName;
//     data['isApplyforTc'] = isApplyforTc;
//     data['isApplyforAdmission'] = isApplyforAdmission;
//     data['isApprove'] = isApprove;
//     data['isActive'] = isActive;
//     data['isInsertFromAd'] = isInsertFromAd;
//     data['isAdmissionPaid'] = isAdmissionPaid;
//     data['regNumber'] = regNumber;
//     data['classId'] = classId;
//     data['categoryId'] = categoryId;
//     data['batchId'] = batchId;
//     data['parentEmail'] = parentEmail;
//     data['admissionFeePaid'] = admissionFeePaid;
//     data['lastName'] = lastName;
//     data['transport'] = transport;
//     data['transportOptions'] = transportOptions;
//     data['mobile'] = mobile;
//     data['city'] = city;
//     data['state'] = state;
//     data['pincode'] = pincode;
//     data['bloodGroupId'] = bloodGroupId;
//     data['isPromoted'] = isPromoted;
//     data['sectionId'] = sectionId;
//     data['rollNo'] = rollNo;
//     data['scholarNo'] = scholarNo;
//     // if (this.additionalInformations != null) {
//     //   data['additionalInformations'] = this.additionalInformations!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.guardianDetails != null) {
//     //   data['guardianDetails'] = this.guardianDetails!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.pastSchoolingReports != null) {
//     //   data['pastSchoolingReports'] = this.pastSchoolingReports!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.studentRemoteAccesses != null) {
//     //   data['studentRemoteAccesses'] = this.studentRemoteAccesses!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.studentTcDetails != null) {
//     //   data['studentTcDetails'] = this.studentTcDetails!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.tcFeeDetails != null) {
//     //   data['tcFeeDetails'] = this.tcFeeDetails!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }



//new model

// class ShowStudentAttendanceModalClass {
//   List<Data>? data;
//   String? msg;
//   String? responseCode;
//   String? additionalData;

//   ShowStudentAttendanceModalClass({
//     this.data,
//     this.msg,
//     this.responseCode,
//     this.additionalData,
//   });

//   ShowStudentAttendanceModalClass.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     msg = json['msg'];
//     responseCode = json['responseCode'];
//     additionalData = json['additionalData'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> jsonData = {};
//     if (data != null) {
//       jsonData['data'] = data!.map((v) => v.toJson()).toList();
//     }
//     jsonData['msg'] = msg;
//     jsonData['responseCode'] = responseCode;
//     jsonData['additionalData'] = additionalData;
//     return jsonData;
//   }
// }

// class Data {
//   Student? student;

//   Data({this.student});

//   Data.fromJson(Map<String, dynamic> json) {
//     student = json['student'] != null ? Student.fromJson(json['student']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> jsonData = {};
//     if (student != null) {
//       jsonData['student'] = student!.toJson();
//     }
//     return jsonData;
//   }
// }

// class Student {
//   int? studentId;
//   String? applicationNumber;
//   String? uin;
//   String? date;
//   String? name;
//   String? classstdy;
//   String? section;
//   String? gender;
//   int? ageInWords;
//   String? dob;
//   String? pob;
//   String? nationality;
//   String? religion;
//   String? motherTongue;
//   String? category;
//   String? bloodGroup;
//   String? medicalHistory;
//   String? hobbies;
//   String? sports;
//   String? otherDetails;
//   String? profileAvatar;
//   String? addedDate;
//   String? modifiedDate;
//   String? ip;
//   String? userId;
//   bool? isDeleted;
//   int? createBy;
//   int? currentYear;
//   String? insertBy;
//   String? markForIdentity;
//   String? otherLanguages;
//   String? medium;
//   String? caste;
//   String? rte;
//   String? adharNo;
//   String? adharFile;
//   String? batchName;
//   bool? isApplyforTc;
//   bool? isApplyforAdmission;
//   int? isApprove;
//   bool? isActive;
//   String? isInsertFromAd;
//   String? isAdmissionPaid;
//   String? regNumber;
//   int? classId;
//   int? categoryId;
//   int? batchId;
//   String? parentEmail;
//   String? admissionFeePaid;
//   String? lastName;
//   String? transport;
//   String? transportOptions;
//   String? mobile;
//   String? city;
//   String? state;
//   String? pincode;
//   int? bloodGroupId;
//   bool? isPromoted;
//   int? sectionId;
//   String? rollNo;
//   String? scholarNo;

//   Student({
//     this.studentId,
//     this.applicationNumber,
//     this.uin,
//     this.date,
//     this.name,
//     this.classstdy,
//     this.section,
//     this.gender,
//     this.ageInWords,
//     this.dob,
//     this.pob,
//     this.nationality,
//     this.religion,
//     this.motherTongue,
//     this.category,
//     this.bloodGroup,
//     this.medicalHistory,
//     this.hobbies,
//     this.sports,
//     this.otherDetails,
//     this.profileAvatar,
//     this.addedDate,
//     this.modifiedDate,
//     this.ip,
//     this.userId,
//     this.isDeleted,
//     this.createBy,
//     this.currentYear,
//     this.insertBy,
//     this.markForIdentity,
//     this.otherLanguages,
//     this.medium,
//     this.caste,
//     this.rte,
//     this.adharNo,
//     this.adharFile,
//     this.batchName,
//     this.isApplyforTc,
//     this.isApplyforAdmission,
//     this.isApprove,
//     this.isActive,
//     this.isInsertFromAd,
//     this.isAdmissionPaid,
//     this.regNumber,
//     this.classId,
//     this.categoryId,
//     this.batchId,
//     this.parentEmail,
//     this.admissionFeePaid,
//     this.lastName,
//     this.transport,
//     this.transportOptions,
//     this.mobile,
//     this.city,
//     this.state,
//     this.pincode,
//     this.bloodGroupId,
//     this.isPromoted,
//     this.sectionId,
//     this.rollNo,
//     this.scholarNo,
//   });

//   Student.fromJson(Map<String, dynamic> json) {
//     studentId = json['studentId'];
//     applicationNumber = json['applicationNumber'];
//     uin = json['uin'];
//     date = json['date'];
//     name = json['name'];
//     classstdy = json['class'];
//     section = json['section'];
//     gender = json['gender'];
//     ageInWords = json['ageInWords'];
//     dob = json['dob'];
//     pob = json['pob'];
//     nationality = json['nationality'];
//     religion = json['religion'];
//     motherTongue = json['motherTongue'];
//     category = json['category'];
//     bloodGroup = json['bloodGroup'];
//     medicalHistory = json['medicalHistory'];
//     hobbies = json['hobbies'];
//     sports = json['sports'];
//     otherDetails = json['otherDetails'];
//     profileAvatar = json['profileAvatar'];
//     addedDate = json['addedDate'];
//     modifiedDate = json['modifiedDate'];
//     ip = json['ip'];
//     userId = json['userId'];
//     isDeleted = json['isDeleted'];
//     createBy = json['createBy'];
//     currentYear = json['currentYear'];
//     insertBy = json['insertBy'];
//     markForIdentity = json['markForIdentity'];
//     otherLanguages = json['otherLanguages'];
//     medium = json['medium'];
//     caste = json['caste'];
//     rte = json['rte'];
//     adharNo = json['adharNo'];
//     adharFile = json['adharFile'];
//     batchName = json['batchName'];
//     isApplyforTc = json['isApplyforTc'];
//     isApplyforAdmission = json['isApplyforAdmission'];
//     isApprove = json['isApprove'];
//     isActive = json['isActive'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> jsonData = {};
//     jsonData['studentId'] = studentId;
//     jsonData['applicationNumber'] = applicationNumber;
//     jsonData['uin'] = uin;
//     jsonData['name'] = name;
//     jsonData['class'] = classstdy;
//     jsonData['gender'] = gender;
//     return jsonData;
//   }
// }
