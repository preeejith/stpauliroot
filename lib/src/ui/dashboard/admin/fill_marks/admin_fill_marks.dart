import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/service/model/get_batch_model.dart';
import 'package:iroots/src/service/model/get_class_model.dart';
import 'package:iroots/src/service/model/get_section_model.dart';
import 'package:iroots/src/service/model/get_staff_model.dart';
import 'package:iroots/src/service/model/get_term_model.dart';
import 'package:iroots/src/ui/dashboard/admin/fill_marks/admin_fill_controller.dart';
import 'package:iroots/src/utility/app_snackbar.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:iroots/src/utility/widget/flutter_typeahead.dart';

//mefillmarksection
class AdminFillMarksScreen extends StatefulWidget {
  final bool fromAdmin;
  final StaffDetail? staffDetail;

  const AdminFillMarksScreen({
    super.key,
    required this.fromAdmin,
    this.staffDetail,
  });

  @override
  State<AdminFillMarksScreen> createState() => _AdminFillMarksScreenState();
}

class _AdminFillMarksScreenState extends State<AdminFillMarksScreen> {
  AdminFillController con = Get.put(AdminFillController());

  void getData() async {
    await con.getData(
      fromAdmin: widget.fromAdmin,
      staffId: widget.staffDetail,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: ConstClass.dashBoardColor,
        title: AppUtil.customText(
          text: "Fill Marks",
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => con.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                if (widget.fromAdmin)
                                  const SizedBox(height: 12),
                                if (widget.fromAdmin) _Staff(con: con),
                                if (widget.fromAdmin == false)
                                  customDropDown("Select Staff",
                                      widget.staffDetail?.name ?? ""),
                                const SizedBox(height: 12),
                                _Class(con: con),
                                const SizedBox(height: 12),
                                _Section(con: con),
                                const SizedBox(height: 12),
                                _Term(con: con),
                                const SizedBox(height: 12),
                                _Batch(con: con),
                                const SizedBox(height: 12),
                                _ShowButton(
                                  onPressed: () {
                                    if (con.selectedStaff.value.stafId
                                            .toString()
                                            .isNotNullOrEmpty &&
                                        con.selectedClass.value.dataListItemId
                                            .toString()
                                            .isNotNullOrEmpty &&
                                        con.selectedSection.value.dataListItemId
                                            .toString()
                                            .isNotNullOrEmpty &&
                                        con.selectedTerm.value.termId
                                            .toString()
                                            .isNotNullOrEmpty &&
                                        con.selectedBatch.value.batchId
                                            .toString()
                                            .isNotNullOrEmpty) {
                                      con.showData();
                                    } else {
                                      toast("Select all dropdown for continue",
                                          false);
                                    }
                                  },
                                ),
                                _RedNotes(con: con),
                              ],
                            ),
                          ),
                          if (con.subject.isNotEmpty) _Grid(con: con),
                          if (con.subject.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: ConstClass.themeColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: ConstClass.themeColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (con.subject.isNotEmpty) {
                                    con.submitData();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  child: AppUtil.customText(
                                    text: "Save",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (con.subject.isNotEmpty)
                            SizedBox(height: Get.height * 0.12)
                        ],
                      ),
                    ),
                  ),
                  if (con.showLoading.value)
                    Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.grey.withOpacity(0.4),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                ],
              ),
      ),
    );
  }

  Widget customDropDown(String? title, String? buttonValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtil.customText(
          text: title,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff94A3B8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  buttonValue ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Grid

class _Grid extends StatelessWidget {
  final AdminFillController con;

  const _Grid({required this.con});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height * 0.6),
      child: Scrollbar(
        controller: con.verticalScrollController,
        thickness: 8,
        radius: const Radius.circular(8),
        interactive: true,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: con.verticalScrollController,
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              DataTable(
                border: TableBorder.all(),
                columns: List<DataColumn>.generate(
                  1,
                  (index) => DataColumn(
                    label: AppUtil.customText(
                      textAlign: TextAlign.center,
                      text: "Student Name",
                      style: const TextStyle(
                        color: Color(0xff0F172A),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                rows: con.studentList
                    .asMap()
                    .map((index, item) {
                      return MapEntry(
                        index,
                        DataRow(
                          cells: List.generate(1, (i1) {
                            return DataCell(AppUtil.customText(
                              textAlign: TextAlign.center,
                              text: item.name,
                              style: const TextStyle(
                                color: Color(0xff334155),
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ));
                          }),
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
              Expanded(
                child: Scrollbar(
                  controller: con.horizontalScrollController,
                  thickness: 8,
                  radius: const Radius.circular(8),
                  interactive: true,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: con.horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Scrollable(
                      viewportBuilder:
                          (BuildContext context, ViewportOffset position) {
                        return DataTable(
                          border: TableBorder.all(),
                          columns: List<DataColumn>.generate(
                            con.subject.length,
                            (index) => DataColumn(
                              label: AppUtil.customText(
                                textAlign: TextAlign.center,
                                text: con.subject[index].testName,
                                style: const TextStyle(
                                  color: Color(0xff0F172A),
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          rows: con.studentList
                              .asMap()
                              .map((index, item) {
                                return MapEntry(
                                  index,
                                  DataRow(
                                    cells: List.generate(
                                        item.subject.length + 1, (i1) {
                                      return DataCell(
                                        i1 == (item.subject.length)
                                            ? widgetTextField(
                                                enabled: true,
                                                hint: "Remark",
                                                controllerEmail:
                                                    item.remarkController,
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLength: 1000,
                                              )
                                            : item.subject[i1].isOptional ==
                                                    true
                                                ? widgetTextField1(
                                                    enabled: item.subject[i1]
                                                                .enabled ==
                                                            true
                                                        ? false
                                                        : true,
                                                    hint: "",
                                                    controllerEmail: item
                                                        .subject[i1].controller,
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(
                                                            signed: true),
                                                    maxLength: 1,
                                                  )
                                                : widgetTextField(
                                                    enabled: item.subject[i1]
                                                                .enabled ==
                                                            true
                                                        ? false
                                                        : true,
                                                    hint: "",
                                                    controllerEmail: item
                                                        .subject[i1].controller,
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(
                                                            signed: true),
                                                    maxLength: 3,
                                                  ),
                                      );
                                    }),
                                  ),
                                );
                              })
                              .values
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget widgetTextField({
    required TextEditingController controllerEmail,
    required String hint,
    required TextInputType? keyboardType,
    required int maxLength,
    bool? enabled = true,
  }) {
    if (controllerEmail.text.trim() == "0") {
      controllerEmail.text = "";
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          enabled: enabled ?? true,
          hintText: hint,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xff94A3B8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          fontWeight: enabled == true ? FontWeight.w500 : FontWeight.w400,
          color: enabled == true ? Colors.black : Colors.grey,
        ),
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        maxLength: maxLength,
      ),
    );
  }

  static Widget widgetTextField1({
    required TextEditingController controllerEmail,
    required String hint,
    required TextInputType? keyboardType,
    required int maxLength,
    bool? enabled = true,
  }) {
    if (controllerEmail.text.trim() == "0") {
      controllerEmail.text = "";
    }
    final Set<String> allowedValues = {'-1', '1', '2', '3', '4'};

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          enabled: enabled ?? true,
          hintText: 'Enter 1, 2, 3, or 4',
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xff94A3B8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          fontWeight: enabled == true ? FontWeight.w500 : FontWeight.w400,
          color: enabled == true ? Colors.black : Colors.grey,
        ),
        keyboardType: keyboardType,
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            // Validate against the allowed values set
            if (newValue.text.isEmpty ||
                allowedValues.contains(newValue.text)) {
              return newValue;
            }
            return oldValue;
          }),
        ],
        textInputAction: TextInputAction.next,
        maxLength: maxLength,
      ),
    );
  }
}

/// Batch

class _Batch extends StatelessWidget {
  final AdminFillController con;

  const _Batch({required this.con});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Select Batch',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff94A3B8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    controller: con.batchController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Select Batch",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                      filled: true,
                      counterStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    List<BatchModel> indTemp = [];
                    for (int i = 0; i < con.batchList.length; i++) {
                      if (removeDiacritics(
                              con.batchList[i].batchName!.trim().toLowerCase())
                          .contains(
                              removeDiacritics(pattern.trim().toLowerCase()))) {
                        if (indTemp
                            .where((element) =>
                                element.batchName!.trim().toLowerCase() ==
                                con.batchList[i].batchName!
                                    .trim()
                                    .toLowerCase())
                            .isEmpty) {
                          indTemp.add(con.batchList[i]);
                        }
                      }
                    }

                    return indTemp;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Select Term";
                    }
                    return null;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.batchName ?? "",
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    con.batchController.text = suggestion.batchName ?? "";
                    con.selectedBatch.value = suggestion;
                  },
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Term

class _Term extends StatelessWidget {
  final AdminFillController con;

  const _Term({required this.con});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Select Term',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff94A3B8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    controller: con.termController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Select Term",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                      filled: true,
                      counterStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    List<TermModel> indTemp = [];
                    for (int i = 0; i < con.termList.length; i++) {
                      if (removeDiacritics(
                              con.termList[i].termName!.trim().toLowerCase())
                          .contains(
                              removeDiacritics(pattern.trim().toLowerCase()))) {
                        if (indTemp
                            .where((element) =>
                                element.termName!.trim().toLowerCase() ==
                                con.termList[i].termName!.trim().toLowerCase())
                            .isEmpty) {
                          indTemp.add(con.termList[i]);
                        }
                      }
                    }

                    return indTemp;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Select Term";
                    }
                    return null;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.termName ?? "",
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    con.termController.text = suggestion.termName ?? "";
                    con.selectedTerm.value = suggestion;
                  },
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Section

class _Section extends StatelessWidget {
  final AdminFillController con;

  const _Section({required this.con});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Select Section',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff94A3B8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    controller: con.sectionController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Select Section",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                      filled: true,
                      counterStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    List<SectionModel> indTemp = [];
                    for (int i = 0; i < con.sectionList.length; i++) {
                      if (removeDiacritics(con.sectionList[i].dataListItemName!
                              .trim()
                              .toLowerCase())
                          .contains(
                              removeDiacritics(pattern.trim().toLowerCase()))) {
                        if (indTemp
                            .where((element) =>
                                element.dataListItemName!
                                    .trim()
                                    .toLowerCase() ==
                                con.sectionList[i].dataListItemName!
                                    .trim()
                                    .toLowerCase())
                            .isEmpty) {
                          indTemp.add(con.sectionList[i]);
                        }
                      }
                    }

                    return indTemp;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Select Section";
                    }
                    return null;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.dataListItemName ?? "",
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    con.sectionController.text =
                        suggestion.dataListItemName ?? "";
                    con.selectedSection.value = suggestion;
                    con.getTermList();
                    con.getBatchList();
                  },
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Class

class _Class extends StatelessWidget {
  final AdminFillController con;

  const _Class({required this.con});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Select Class',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff94A3B8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    controller: con.classController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Select Class",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                      filled: true,
                      counterStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    List<ClassModel> indTemp = [];
                    for (int i = 0; i < con.classList.length; i++) {
                      if (removeDiacritics(con.classList[i].dataListItemName!
                              .trim()
                              .toLowerCase())
                          .contains(
                              removeDiacritics(pattern.trim().toLowerCase()))) {
                        if (indTemp
                            .where((element) =>
                                element.dataListItemName!
                                    .trim()
                                    .toLowerCase() ==
                                con.classList[i].dataListItemName!
                                    .trim()
                                    .toLowerCase())
                            .isEmpty) {
                          indTemp.add(con.classList[i]);
                        }
                      }
                    }

                    return indTemp;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Select Class";
                    }
                    return null;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.dataListItemName ?? "",
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    con.classController.text =
                        suggestion.dataListItemName ?? "";
                    con.selectedClass.value = suggestion;
                    con.getSectionList();
                  },
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Staff

class _Staff extends StatelessWidget {
  final AdminFillController con;

  const _Staff({required this.con});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Select Staff',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff94A3B8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    controller: con.staffController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Select Staff",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                      filled: true,
                      counterStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    List<StaffModel> indTemp = [];
                    for (int i = 0; i < con.staffList.length; i++) {
                      if (removeDiacritics(
                              con.staffList[i].name!.trim().toLowerCase())
                          .contains(
                              removeDiacritics(pattern.trim().toLowerCase()))) {
                        if (indTemp
                            .where((element) =>
                                element.name!.trim().toLowerCase() ==
                                con.staffList[i].name!.trim().toLowerCase())
                            .isEmpty) {
                          indTemp.add(con.staffList[i]);
                        }
                      }
                    }

                    return indTemp;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Select Staff";
                    }
                    return null;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.name ?? "",
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    con.staffController.text = suggestion.name ?? "";
                    con.selectedStaff.value = suggestion;
                    con.classController.clear();
                    con.getClassList(showLoader: false);
                  },
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShowButton extends StatelessWidget {
  final void Function()? onPressed;

  const _ShowButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1.0, color: Color(0xff94A3B8)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              "Show",
              style: TextStyle(
                color: Color(0xff1575FF),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RedNotes extends StatelessWidget {
  final AdminFillController con;

  const _RedNotes({required this.con});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        color: const Color(0xffFFF1F2),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppUtil.customText(
                  text: "Important Note:",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    con.isNotesOpen.toggle();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/${con.isNotesOpen.value ? "arrow_down" : "arrow_up"}.svg",
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Visibility(
              visible: con.isNotesOpen.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppUtil.customText(
                    text: "• Absent mark will be indicated by '-1'.",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  AppUtil.customText(
                    text: "• Please enter only '-1' and digits.",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  AppUtil.customText(
                    text:
                        "• If the entered marks exceed the maximum marks,the input field will be outlined in red to indicate the exceeded value.",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  AppUtil.customText(
                    text:
                        "• For optional subjects, these marks correspond to the following grades: \n     • 1 - A \n     • 2 - B \n     • 3 - C \n     • 4 - D",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
