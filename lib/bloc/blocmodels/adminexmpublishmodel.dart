class AdminExmPublishDetailsModel {
  List<Data>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  AdminExmPublishDetailsModel(
      {this.data, this.msg, this.responseCode, this.additionalData});

  AdminExmPublishDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    responseCode = json['responseCode'];
    additionalData = json['additionalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['responseCode'] = responseCode;
    data['additionalData'] = additionalData;
    return data;
  }
}

class Data {
  int? recordId;
  int? studentId;
  int? testId;
  int? termId;
  int? classId;
  int? sectionId;
  Null obtainedMarks;
  int? batchId;
  int? boardId;

  Data(
      {this.recordId,
      this.studentId,
      this.testId,
      this.termId,
      this.classId,
      this.sectionId,
      this.obtainedMarks,
      this.batchId,
      this.boardId});

  Data.fromJson(Map<String, dynamic> json) {
    recordId = json['recordId'];
    studentId = json['studentId'];
    testId = json['testId'];
    termId = json['termId'];
    classId = json['classId'];
    sectionId = json['sectionId'];
    obtainedMarks = json['obtainedMarks'];
    batchId = json['batchId'];
    boardId = json['boardId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recordId'] = recordId;
    data['studentId'] = studentId;
    data['testId'] = testId;
    data['termId'] = termId;
    data['classId'] = classId;
    data['sectionId'] = sectionId;
    data['obtainedMarks'] = obtainedMarks;
    data['batchId'] = batchId;
    data['boardId'] = boardId;
    return data;
  }
}
