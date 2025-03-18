class StudReportCardModel {
  StudentData? studentData;
  List<GroupedSubjects>? groupedSubjects;
  List<GroupedTerms>? groupedTerms;
  List<CoscholasticAreaData>? coscholasticAreaData;
  List<GradingCriteria>? gradingCriteria;
  List<String>? term;
  String? result;
  num? obtainedPercent;

  StudReportCardModel(
      {this.studentData,
      this.groupedSubjects,
      this.groupedTerms,
      this.coscholasticAreaData,
      this.gradingCriteria,
      this.term,
      this.result,
      this.obtainedPercent});

  StudReportCardModel.fromJson(Map<String, dynamic> json) {
    studentData = json['studentData'] != null
        ? StudentData.fromJson(json['studentData'])
        : null;
    if (json['groupedSubjects'] != null) {
      groupedSubjects = <GroupedSubjects>[];
      json['groupedSubjects'].forEach((v) {
        groupedSubjects!.add(GroupedSubjects.fromJson(v));
      });
    }
    if (json['groupedTerms'] != null) {
      groupedTerms = <GroupedTerms>[];
      json['groupedTerms'].forEach((v) {
        groupedTerms!.add(GroupedTerms.fromJson(v));
      });
    }
    if (json['coscholasticAreaData'] != null) {
      coscholasticAreaData = <CoscholasticAreaData>[];
      json['coscholasticAreaData'].forEach((v) {
        coscholasticAreaData!.add(CoscholasticAreaData.fromJson(v));
      });
    }
    if (json['gradingCriteria'] != null) {
      gradingCriteria = <GradingCriteria>[];
      json['gradingCriteria'].forEach((v) {
        gradingCriteria!.add(GradingCriteria.fromJson(v));
      });
    }
    term = json['term'].cast<String>();
    result = json['result'];
    obtainedPercent = json['obtainedPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentData != null) {
      data['studentData'] = studentData!.toJson();
    }
    if (groupedSubjects != null) {
      data['groupedSubjects'] =
          groupedSubjects!.map((v) => v.toJson()).toList();
    }
    if (groupedTerms != null) {
      data['groupedTerms'] = groupedTerms!.map((v) => v.toJson()).toList();
    }
    if (coscholasticAreaData != null) {
      data['coscholasticAreaData'] =
          coscholasticAreaData!.map((v) => v.toJson()).toList();
    }
    if (gradingCriteria != null) {
      data['gradingCriteria'] =
          gradingCriteria!.map((v) => v.toJson()).toList();
    }
    data['term'] = term;
    data['result'] = result;
    data['obtainedPercent'] = obtainedPercent;
    return data;
  }
}

class StudentData {
  num? studentID;
  int? batchID;
  int? termID;
  int? sectionID;
  String? schoolName;
  Null newAddress;
  num? currentYear;
  String? schoolLogo;
  String? studentName;
  String? fatherName;
  String? motherName;
  String? scholarNo;
  String? rollNo;
  String? dateOfBirth;
  String? academicYear;
  String? className;
  String? sectionName;
  int? attendance;
  String? promotedClass;
  String? staffSignatureLink;
  String? remark;
  int? classID;

  StudentData(
      {this.studentID,
      this.batchID,
      this.termID,
      this.sectionID,
      this.schoolName,
      this.newAddress,
      this.currentYear,
      this.schoolLogo,
      this.studentName,
      this.fatherName,
      this.motherName,
      this.scholarNo,
      this.rollNo,
      this.dateOfBirth,
      this.academicYear,
      this.className,
      this.sectionName,
      this.attendance,
      this.promotedClass,
      this.staffSignatureLink,
      this.remark,
      this.classID});

  StudentData.fromJson(Map<String, dynamic> json) {
    studentID = json['studentID'];
    batchID = json['batchID'];
    termID = json['termID'];
    sectionID = json['sectionID'];
    schoolName = json['schoolName'];
    newAddress = json['newAddress'];
    currentYear = json['currentYear'];
    schoolLogo = json['schoolLogo'];
    studentName = json['studentName'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    scholarNo = json['scholarNo'];
    rollNo = json['rollNo'];
    dateOfBirth = json['dateOfBirth'];
    academicYear = json['academicYear'];
    className = json['className'];
    sectionName = json['sectionName'];
    attendance = json['attendance'];
    promotedClass = json['promotedClass'];
    staffSignatureLink = json['staffSignatureLink'];
    remark = json['remark'];
    classID = json['classID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentID'] = studentID;
    data['batchID'] = batchID;
    data['termID'] = termID;
    data['sectionID'] = sectionID;
    data['schoolName'] = schoolName;
    data['newAddress'] = newAddress;
    data['currentYear'] = currentYear;
    data['schoolLogo'] = schoolLogo;
    data['studentName'] = studentName;
    data['fatherName'] = fatherName;
    data['motherName'] = motherName;
    data['scholarNo'] = scholarNo;
    data['rollNo'] = rollNo;
    data['dateOfBirth'] = dateOfBirth;
    data['academicYear'] = academicYear;
    data['className'] = className;
    data['sectionName'] = sectionName;
    data['attendance'] = attendance;
    data['promotedClass'] = promotedClass;
    data['staffSignatureLink'] = staffSignatureLink;
    data['remark'] = remark;
    data['classID'] = classID;
    return data;
  }
}

class GroupedSubjects {
  String? subjectName;
  List<Terms>? terms;
  bool? isOptional;

  GroupedSubjects({this.subjectName, this.terms, this.isOptional});

  GroupedSubjects.fromJson(Map<String, dynamic> json) {
    subjectName = json['subjectName'];
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(Terms.fromJson(v));
      });
    }
    isOptional = json['isOptional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectName'] = subjectName;
    if (terms != null) {
      data['terms'] = terms!.map((v) => v.toJson()).toList();
    }
    data['isOptional'] = isOptional;
    return data;
  }
}

class Terms {
  String? name;
  num? theoryMark;
  num? practicalMark;
  num? totallMark;
  num? maximumMarks;
  String? grade;
  bool? isOptional;

  Terms(
      {this.name,
      this.theoryMark,
      this.practicalMark,
      this.totallMark,
      this.maximumMarks,
      this.grade,
      this.isOptional});

  Terms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    theoryMark = json['theoryMark'];
    practicalMark = json['practicalMark'];
    totallMark = json['totallMark'];
    maximumMarks = json['maximumMarks'];
    grade = json['grade'];
    isOptional = json['isOptional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['theoryMark'] = theoryMark;
    data['practicalMark'] = practicalMark;
    data['totallMark'] = totallMark;
    data['maximumMarks'] = maximumMarks;
    data['grade'] = grade;
    data['isOptional'] = isOptional;
    return data;
  }
}

class GroupedTerms {
  String? term;
  String? testType;
  num? total;
  num? maximumMarks;
  num? percentage;
  String? grade;

  GroupedTerms(
      {this.term,
      this.testType,
      this.total,
      this.maximumMarks,
      this.percentage,
      this.grade});

  GroupedTerms.fromJson(Map<String, dynamic> json) {
    term = json['term'];
    testType = json['testType'];
    total = json['total'];
    maximumMarks = json['maximumMarks'];
    percentage = json['percentage'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term'] = term;
    data['testType'] = testType;
    data['total'] = total;
    data['maximumMarks'] = maximumMarks;
    data['percentage'] = percentage;
    data['grade'] = grade;
    return data;
  }
}

class CoscholasticAreaData {
  String? name;
  String? obtainedGrade;
  String? term;
  String? gradeTerm1;
  String? gradeTerm2;
  String? gradeUT1;
  String? gradeUT2;
  String? gradePre1;
  String? gradePre2;

  CoscholasticAreaData(
      {this.name,
      this.obtainedGrade,
      this.term,
      this.gradeTerm1,
      this.gradeTerm2,
      this.gradeUT1,
      this.gradeUT2,
      this.gradePre1,
      this.gradePre2});

  CoscholasticAreaData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    obtainedGrade = json['obtainedGrade'];
    term = json['term'];
    gradeTerm1 = json['gradeTerm1'];
    gradeTerm2 = json['gradeTerm2'];
    gradeUT1 = json['gradeUT1'];
    gradeUT2 = json['gradeUT2'];
    gradePre1 = json['gradePre1'];
    gradePre2 = json['gradePre2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['obtainedGrade'] = obtainedGrade;
    data['term'] = term;
    data['gradeTerm1'] = gradeTerm1;
    data['gradeTerm2'] = gradeTerm2;
    data['gradeUT1'] = gradeUT1;
    data['gradeUT2'] = gradeUT2;
    data['gradePre1'] = gradePre1;
    data['gradePre2'] = gradePre2;
    return data;
  }
}

class GradingCriteria {
  num? minimumPercentage;
  num? maximumPercentage;
  String? grade;
  String? gradeDescription;

  GradingCriteria(
      {this.minimumPercentage,
      this.maximumPercentage,
      this.grade,
      this.gradeDescription});

  GradingCriteria.fromJson(Map<String, dynamic> json) {
    minimumPercentage = json['minimumPercentage'];
    maximumPercentage = json['maximumPercentage'];
    grade = json['grade'];
    gradeDescription = json['gradeDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimumPercentage'] = minimumPercentage;
    data['maximumPercentage'] = maximumPercentage;
    data['grade'] = grade;
    data['gradeDescription'] = gradeDescription;
    return data;
  }
}
