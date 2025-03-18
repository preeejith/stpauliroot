import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iroots/bloc/bloclocalstorage/prefmanager.dart';
import 'package:iroots/bloc/blocmodels/adminexmpublishmodel.dart';
import 'package:iroots/bloc/blocmodels/paymentinputresponsemodel.dart';
import 'package:iroots/bloc/blocmodels/shopdetailsmodel.dart';
import 'package:iroots/bloc/blocmodels/studentfeelistmodel.dart';
import 'package:iroots/bloc/blocmodels/studentreportcardmodel.dart';
import 'package:iroots/bloc/blocserver/serverhelper.dart';
import 'package:iroots/newscreens/studentattendancemodel.dart';

class MainBloc extends Bloc<MainEvents, MainState> {
  ShopDetailedModel shopDetailedModel = ShopDetailedModel();
  StudentFeeListModel studentFeeListModel = StudentFeeListModel();
  StudentAttendanceModel studentAttendanceModel = StudentAttendanceModel();
  PreparePaymentRepsonseModel preparePaymentRepsonseModel =
      PreparePaymentRepsonseModel();

  AdminExmPublishDetailsModel adminExmPublishDetailsModel =
      AdminExmPublishDetailsModel();
  StudReportCardModel studReportCardModel = StudReportCardModel();
  StudReportCardModel studReportCardModelunit2 = StudReportCardModel();
  bool? term1exmhpn = false;
  bool? term2exmhpn = false;
  bool? term3exmhpn = false;
  StudReportCardModel studReportCardModelunit3 = StudReportCardModel();

  double totalfeeamount = 0;
  String? nameStudent;
  String feeHeading = "";
  String? classId = "";
  String? currentDropDate = "2025";
  String? currenStarttDropDate = "2024";
  MainBloc() : super(LoginInitial()) {
    on<GetStudentFeeList>(getStudentfeelist);
    on<GetStudentGradeCard>(getStudentGradeCard);
    on<GetStudentTotalamount>(getStudentTotalamount);
    on<GetStudentAttendance>(getStudentAttendance);
    on<GetPreparePayment>(getPreparePayment);
    on<GetAdminExmPublishDetails>(getAdminExmPublishDetails);
  }

  Future<FutureOr<void>> getStudentTotalamount(
      GetStudentTotalamount event, Emitter<MainState> emit) async {
    try {
      feeHeading = "";
      totalfeeamount = 0; // Initialize the totalfeeamount
      // Initialize an empty string for the fee headings

      for (int i = 0; i < studentFeeListModel.feeDetails!.length; i++) {
        if (studentFeeListModel.feeDetails![i].checkboxvalue == true) {
          // Add the fee value to the total
          totalfeeamount += double.parse(
              studentFeeListModel.feeDetails![i].feeValue.toString());

          // Concatenate the fee heading to the string (with a comma separator)
          if (feeHeading.isNotEmpty) {
            feeHeading += ","; // Add a comma between items
          }
          feeHeading += studentFeeListModel.feeDetails![i].feeName.toString();
        }
      }

      // You can now use feeHeading, which will have the comma-separated fee headings
      print("Total Fee Amount: $totalfeeamount");
      print("Fee Headings: $feeHeading");

      // Emit the state (can include both totalfeeamount and feeHeading if needed)
      emit(Gettingstudentamount());
    } catch (e) {
      emit(StudentFeeAmountError(error: "Invalid credentials"));
    }
  }

  Future<FutureOr<void>> getStudentAttendance(
      GetStudentAttendance event, Emitter<MainState> emit) async {
    try {
      var token = await PrefManager.getToken();
      String? sstudntId = "";
      String? classsId = "";
      String? sessionId = "";
      emit(GettingStudentAttendance());

      String jsonString1 = await PrefManager.getAdditionalInfo();

      String jsonstring2 = jsonString1;

      List<dynamic> studentList = jsonDecode(jsonstring2);

      sstudntId = studentList[0]["StudentRegisterId"].toString();
      classId = studentList[0]["ClassId"].toString();
      sessionId = studentList[0]["SectionId"].toString();
      print(sstudntId);
      print(classId);
      print(sessionId);
      Map data = {
        // "id": event.shopId,
      };
      studentAttendanceModel =
          StudentAttendanceModel.fromJson(await ServerHelper.ohYespost(
              'Dashboard/StudentsDashBoardAttendanceDetails?startDate=2025-01-01&endDate=2025-12-01&classId=$classId&sectionId=$sessionId&fromYear=$currenStarttDropDate&toYear=$currentDropDate&studentId=$sstudntId',
              // 'Dashboard/StudentsDashBoardAttendanceDetails?startDate=2023-01-01&endDate=2024-01-01&classId=205&sectionId=24&fromYear=2023&toYear=2023&studentId=1215',
              data,
              token));
      if (studentAttendanceModel.responseCode == "200") {
        emit(StudentAttendanceSuccess());
      } else if (studentAttendanceModel.responseCode != "200") {
        // Helper.showToast(msg: myqpadshoplistModel.message);
        emit(StudentAttendanceFailed(error: "Invalid credentials"));
      }
    } catch (e) {
      emit(StudentAttendanceError(error: "Invalid credentials"));
    }
  }

  Future<FutureOr<void>> getPreparePayment(
      GetPreparePayment event, Emitter<MainState> emit) async {
    try {
      emit(GettingReadyPaymentLoading());

      String jsonString1 = await PrefManager.getAdditionalInfo();

      String jsonstring2 = jsonString1;

      // "[{\"StudentRegisterId\":5826,\"ApplicationNumber\":\"2143\",\"Uin\":\"e9640888-c4e4-4599-a578-7719b0df8941\",\"Date\":null,\"Name\":\"STUTI \",\"Class\":null,\"Section\":null,\"Gender\":\"Female\",\"Rte\":null,\"Medium\":\"ENGLISH\",\"Caste\":null,\"AgeInWords\":0,\"Dob\":\"04-Jun-2010\",\"Pob\":\"UJJAIN\",\"Nationality\":\"INDIAN\",\"Religion\":null,\"MotherTongue\":\"HINDI\",\"Category\":\"General\",\"BloodGroup\":null,\"MedicalHistory\":null,\"Hobbies\":null,\"Sports\":null,\"OtherDetails\":null,\"ProfileAvatar\":null,\"MarkForIdentity\":null,\"AdharNo\":\"385208903564\",\"AdharFile\":null,\"OtherLanguages\":null,\"IsApplyforTc\":false,\"IsApplyforAdmission\":false,\"IsApprove\":191,\"IsActive\":false,\"IsInsertFromAd\":null,\"IsAdmissionPaid\":null,\"AddedDate\":\"2024-07-06T00:00:00\",\"ModifiedDate\":\"2024-07-06T00:00:00\",\"Ip\":\"198.12.225.42\",\"UserId\":\"2575\",\"IsDeleted\":false,\"CreateBy\":0,\"CurrentYear\":2024,\"InsertBy\":null,\"BatchName\":null,\"Email\":null,\"LastStudiedSchoolName\":null,\"ParentsEmail\":\"suvidhaelectronic.ujjain@gmail.com\",\"ClassId\":205,\"SectionId\":24,\"LastName\":\" PATHAK\",\"BatchId\":21,\"BatchName1\":null,\"BloodGroupId\":0,\"ReligionId\":176,\"CastId\":252,\"CategoryId\":27,\"ClassName\":null,\"SectionName\":null,\"Transport\":null,\"TransportOptions\":null,\"Mobile\":null,\"AdmissionFeePaid\":null,\"City\":null,\"State\":null,\"Pincode\":null,\"AddedYear\":\"2024\",\"RegistrationDate\":\"16/06/2016\",\"IsEmailsent\":false,\"PromotionDate\":\"06/07/2024\",\"PromotionYear\":\"2024\",\"EmailSendDate\":null,\"EmailSend\":0,\"GradeDivision\":\"7th - GREEN\",\"House\":\"\",\"Hostel\":\"\",\"Status\":\"Active\",\"SssmidNumber\":\"176772821\",\"Role\":\"Parent\",\"Designation\":\"\",\"IsRtestudent\":\"\",\"IsInDayCare\":\"No\",\"FamilySssmid\":\"39326060\",\"BankAccount\":null,\"BankName\":null,\"BankAcholder\":null,\"BankIfsc\":null,\"Subjects\":\"English Lit., Hindi, Mathematics, Computer, G.K., Moral Science, Sanskrit, Drawing, SUPW, English Lang., History & Civics, Geography, Physics, Chemistry, Biology\",\"OptionalSubjects\":\"\",\"School\":\"Nirmala Convent School\",\"IsUserLoggedIn\":\"User Logged-In\",\"LastLoginDate\":\"04-Dec-2020\",\"RollNo\":null,\"ScholarNo\":null}]";

      // Decode the JSON string into a List
      List<dynamic> studentList = jsonDecode(jsonstring2);
      var token = await PrefManager.getToken();
      // Extract the ApplicationNumber from the first element (assuming the structure remains consistent)
      String applicationNumber = studentList[0]["ApplicationNumber"];
      num studentId = studentList[0]["StudentRegisterId"];
      num classId = studentList[0]["ClassId"];
      String parentsEmail = studentList[0]["ParentsEmail"];
      nameStudent = studentList[0]["Name"];
      classId = studentList[0]["ClassId"];

      print("Application Number: $applicationNumber");

      Map data = {
        "studentId": studentId.toString(),
        "class": classId.toString(),
        "category": "",
        "tcBal": "0",
        "feeHeadings": feeHeading.toString(),
        "feeheadingamt": totalfeeamount.toString(),
        "concessionAmt": 0,
        "concession": 0,
        "dueFee": "0",
        "email": parentsEmail.toString(),
        "paymentGatewayName": "atom"
      };
      preparePaymentRepsonseModel = PreparePaymentRepsonseModel.fromJson(
          await ServerHelper.ohYespost('Paymet/PreapareInput', data, token));
      if (preparePaymentRepsonseModel.data != null) {
        emit(PaymentInputResSuccess());
      } else if (preparePaymentRepsonseModel.responseCode != "200") {
        // Helper.showToast(msg: myqpadshoplistModel.message);
        emit(PaymentResponFailed(error: "Invalid credentials"));
      }
    } catch (e) {
      emit(PaymentResponError(error: "Invalid credentials"));
    }
  }

  Future<FutureOr<void>> getAdminExmPublishDetails(
      GetAdminExmPublishDetails event, Emitter<MainState> emit) async {
    try {
      emit(GettingAdminExmPublishDetails());

      String jsonString1 = await PrefManager.getAdditionalInfo();

      String jsonstring2 = jsonString1;
      List<dynamic> studentList = jsonDecode(jsonstring2);
      var token = await PrefManager.getToken();

      String applicationNumber = studentList[0]["ApplicationNumber"];
      num studentId = studentList[0]["StudentRegisterId"];
      // num classId = studentList[0]["ClassId"];
      // String parentsEmail = studentList[0]["ParentsEmail"];
      num? batchId = studentList[0]["BatchId"];
      // num classId2 = studentList[0]["ClassId"];

      print("Application Number: $applicationNumber");

      adminExmPublishDetailsModel =
          AdminExmPublishDetailsModel.fromJson(await ServerHelper.getohYes(
        'Student/GetStudentCurrentYearResult?StudentId=${studentId.toString()}&BatchId=${batchId.toString()}',
      ));
      if (adminExmPublishDetailsModel.data != null) {
        emit(AdminExmDetailsSuccess());
      } else if (adminExmPublishDetailsModel.responseCode != "200") {
        // Helper.showToast(msg: myqpadshoplistModel.message);
        emit(AdminExmDetailsFailed(error: "Invalid credentials"));
      }
    } catch (e) {
      emit(AdminExmDetailsError(error: "Invalid credentials"));
    }
  }

  Future<FutureOr<void>> getStudentfeelist(
      GetStudentFeeList event, Emitter<MainState> emit) async {
    try {
      emit(GettingShopDetails());
      String jsonString1 = await PrefManager.getAdditionalInfo();

      String jsonstring2 = jsonString1;
      List<dynamic> studentList = jsonDecode(jsonstring2);
      var token = await PrefManager.getToken();

      String applicationNumber = studentList[0]["ApplicationNumber"];
      studentFeeListModel = StudentFeeListModel.fromJson(await ServerHelper.get(
        'Paymet/get-student-fees?applicationNumber=$applicationNumber',
      ));
      if (studentFeeListModel.feeDetails!.isNotEmpty) {
        // servicebookId = shopDetailedModel.services![0].sId.toString();
        totalfeeamount =
            double.parse(studentFeeListModel.totalAmount.toString());

        emit(StudentFeeListSuccess());
      } else if (studentFeeListModel.feeDetails!.isEmpty) {
        // Helper.showToast(msg: myqpadshoplistModel.message);
        emit(StudentFeeListFailed(error: "Invalid credentials"));
      }
    } catch (e) {
      emit(StudentFeeListError(error: "Invalid credentials"));
    }
  }

  Future<FutureOr<void>> getStudentGradeCard(
      GetStudentGradeCard event, Emitter<MainState> emit) async {
    try {
      emit(GettingProgressCard());

      String jsonString1 = await PrefManager.getAdditionalInfo();

      String jsonstring2 = jsonString1;
      List<dynamic> studentList = jsonDecode(jsonstring2);

      String applicationNumber = studentList[0]["ApplicationNumber"];
      // num studentId = studentList[0]["StudentRegisterId"];
      num classId2 = studentList[0]["ClassId"];
      // String parentsEmail = studentList[0]["ParentsEmail"];
      nameStudent = studentList[0]["Name"];
      num? classId22 = studentList[0]["ClassId"];
      num? batchId = studentList[0]["BatchId"];
      num? sessionId22 = studentList[0]["SectionId"];
      try {
        term1exmhpn = true;
        studReportCardModel =
            StudReportCardModel.fromJson(await ServerHelper.get(
          'Exam/PrintReportCardData?termId=1&batchId=$batchId&ClassId=${classId22.toString()}&SectionId=${sessionId22.toString()}&ApplicationNo=${applicationNumber.toString()}',
        ));
      } catch (e) {
        term1exmhpn = false;
        print("issue found");
      }
      try {
        term2exmhpn = true;
        studReportCardModelunit2 =
            StudReportCardModel.fromJson(await ServerHelper.get(
          'Exam/PrintReportCardData?termId=2&batchId=$batchId&ClassId=$classId22&SectionId=$sessionId22&ApplicationNo=$applicationNumber',
        ));
      } catch (e) {
        term2exmhpn = false;
      }
      try {
        term3exmhpn = true;
        studReportCardModelunit3 =
            StudReportCardModel.fromJson(await ServerHelper.get(
          'Exam/PrintReportCardData?termId=3&batchId=$batchId&ClassId=$classId22&SectionId=$sessionId22&ApplicationNo=$applicationNumber',
        ));
      } catch (w) {
        term3exmhpn = false;
      }
      //
      //    'Exam/PrintReportCardData?termId=2&batchId=21&ClassId=205&SectionId=24&ApplicationNo=2143',

      print(
          "Exam/PrintReportCardData?termId=3&batchId=$batchId&ClassId=$classId22&SectionId=$sessionId22&ApplicationNo=$applicationNumber");
      if (studReportCardModel.studentData != null) {
        emit(ProgressCardSuccess());
      } else if (studReportCardModel.studentData != null) {
        // Helper.showToast(msg: myqpadshoplistModel.message);
        emit(ProgressCardFailed(error: "Invalid credentials"));
      }
    } catch (e) {
      emit(StudentProgreessCardError(error: "Invalid credentials"));
    }
  }
}

class MainEvents {}

class VerifyPassword extends MainEvents {
  final String? name, password;

  VerifyPassword({this.name, this.password});
}

class GetStudentFeeList extends MainEvents {
  final String? shopId, lon, userphone, username, searchkeyword;

  GetStudentFeeList(
      {this.shopId,
      this.lon,
      this.userphone,
      this.username,
      this.searchkeyword});
}

class GetStudentGradeCard extends MainEvents {
  final String? shopId, lon, userphone, username, searchkeyword;

  GetStudentGradeCard(
      {this.shopId,
      this.lon,
      this.userphone,
      this.username,
      this.searchkeyword});
}

class GetStudentTotalamount extends MainEvents {
  final String? shopId, lon, userphone, username, searchkeyword;

  GetStudentTotalamount(
      {this.shopId,
      this.lon,
      this.userphone,
      this.username,
      this.searchkeyword});
}

class GetStudentAttendance extends MainEvents {
  final String? shopId, lon, userphone, username, searchkeyword;

  GetStudentAttendance(
      {this.shopId,
      this.lon,
      this.userphone,
      this.username,
      this.searchkeyword});
}

class GetPreparePayment extends MainEvents {
  final String? shopId, lon, userphone, username, searchkeyword;

  GetPreparePayment(
      {this.shopId,
      this.lon,
      this.userphone,
      this.username,
      this.searchkeyword});
}

class GetAdminExmPublishDetails extends MainEvents {
  final String? shopId, lon, userphone, username, searchkeyword;

  GetAdminExmPublishDetails(
      {this.shopId,
      this.lon,
      this.userphone,
      this.username,
      this.searchkeyword});
}

class MainState {}

class LoginInitial extends MainState {}

class Loading extends MainState {}

class Fething extends MainState {}

class LoginSuccess extends MainState {}

class GettingSlotList extends MainState {}

class StudentFeeListSuccess extends MainState {}

class ProgressCardSuccess extends MainState {}

class StudentAttendanceSuccess extends MainState {}

class PaymentInputResSuccess extends MainState {}

class AdminExmDetailsSuccess extends MainState {}

class StudentFeeListError extends MainState {
  final String? error;

  StudentFeeListError({this.error});
}

class StudentProgreessCardError extends MainState {
  final String? error;

  StudentProgreessCardError({this.error});
}

class StudentAttendanceError extends MainState {
  final String? error;

  StudentAttendanceError({this.error});
}

class PaymentResponError extends MainState {
  final String? error;

  PaymentResponError({this.error});
}

class AdminExmDetailsError extends MainState {
  final String? error;

  AdminExmDetailsError({this.error});
}

class StudentFeeAmountError extends MainState {
  final String? error;

  StudentFeeAmountError({this.error});
}

class GettingShopDetails extends MainState {}

class GettingProgressCard extends MainState {}

class GettingStudentAttendance extends MainState {}

class GettingReadyPaymentLoading extends MainState {}

class GettingAdminExmPublishDetails extends MainState {}

class GettingStudentAtte extends MainState {}

class Gettingstudentamount extends MainState {}

class StudentFeeListFailed extends MainState {
  final String? error;

  StudentFeeListFailed({this.error});
}

class ProgressCardFailed extends MainState {
  final String? error;

  ProgressCardFailed({this.error});
}

class StudentAttendanceFailed extends MainState {
  final String? error;

  StudentAttendanceFailed({this.error});
}

class PaymentResponFailed extends MainState {
  final String? error;

  PaymentResponFailed({this.error});
}

class AdminExmDetailsFailed extends MainState {
  final String? error;

  AdminExmDetailsFailed({this.error});
}

class GettingCatList extends MainState {}

class LoginError extends MainState {
  final String? error;

  LoginError({this.error});
}
