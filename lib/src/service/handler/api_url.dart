import 'package:iroots/common/app_data.dart';

class ApiUrls {
  // static String baseUrl = "https://devmomo.rtn.org.np/api/v1/";

  // static String baseUrl = "http://198.12.225.42/LumenAPI/api/";
  static String baseUrl = baseUrlName;
  static String getStaffList = "Exam/GetStaffList";
  static String getStaffDetails = "UserCredentials/GetStaffDetails";
  static String getClass = "Exam/GetClassList";
  static String getSection = "Exam/GetSectionList";
  static String getTerm = "Exam/GetTermDropList";
  static String getBatch = "Exam/GetBatchDropList";
  static String frillMark = "Exam/FillMarksreport";
  static String reportCard = "Exam/ReportCard";
  static String saveFillMark = "Exam/SaveFillmarkReport";
  static String saveCoScholastic = "Exam/SaveFillCoScholasticMarks";
  static String coScholasticArea = "Exam/FillCoScholasticAreasRepor";
}
