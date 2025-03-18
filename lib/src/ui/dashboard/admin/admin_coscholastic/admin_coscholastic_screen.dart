import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/service/model/get_batch_model.dart';
import 'package:iroots/src/service/model/get_class_model.dart';
import 'package:iroots/src/service/model/get_section_model.dart';
import 'package:iroots/src/service/model/get_staff_model.dart';
import 'package:iroots/src/service/model/get_term_model.dart';
import 'package:iroots/src/ui/dashboard/admin/admin_coscholastic/admin_coscholastic_controller.dart';
import 'package:iroots/src/utility/app_snackbar.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:iroots/src/utility/widget/flutter_typeahead.dart';

//meco-scholasticform
class AdminCoScholasticScreen extends StatefulWidget {
  final bool fromAdmin;
  final StaffDetail? staffDetail;

  const AdminCoScholasticScreen({
    super.key,
    required this.fromAdmin,
    this.staffDetail,
  });

  @override
  State<AdminCoScholasticScreen> createState() =>
      _AdminCoScholasticScreenState();
}

class _AdminCoScholasticScreenState extends State<AdminCoScholasticScreen> {
  final AdminCoScholasticController con =
      Get.put(AdminCoScholasticController());

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
          text: "Fill Co-Scholastics",
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        children: [
                          if (widget.fromAdmin) const SizedBox(height: 12),
                          if (widget.fromAdmin) _Staff(con: con),
                          if (widget.fromAdmin == false)
                            customDropDown(
                                "Select Staff", widget.staffDetail?.name ?? ""),
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
                                toast(
                                    "Select all dropdown for continue", false);
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          if (con.subject.isNotEmpty)
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
                                  con.submitData();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 10,
                                  ),
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

/// Batch

class _Batch extends StatelessWidget {
  final AdminCoScholasticController con;

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

/// Grid

class _Grid extends StatefulWidget {
  final AdminCoScholasticController con;

  const _Grid({required this.con});

  @override
  State<_Grid> createState() => _GridState();
}

class _GridState extends State<_Grid> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height * 0.6),
      child: Scrollbar(
        controller: widget.con.verticalScrollController,
        thickness: 8,
        radius: const Radius.circular(8),
        interactive: true,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: widget.con.verticalScrollController,
          scrollDirection: Axis.vertical,
          child: Scrollbar(
            controller: widget.con.horizontalScrollController,
            thickness: 8,
            radius: const Radius.circular(8),
            interactive: true,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: widget.con.horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: Scrollable(
                viewportBuilder:
                    (BuildContext context, ViewportOffset position) {
                  return DataTable(
                    border: TableBorder.all(),
                    columns: List<DataColumn>.generate(
                      widget.con.subject.length,
                      (index) => DataColumn(
                        label: AppUtil.customText(
                          textAlign: TextAlign.center,
                          text: widget.con.subject[index].title,
                          style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    rows: widget.con.studentList
                        .asMap()
                        .map((index, item) {
                          return MapEntry(
                            index,
                            DataRow(
                              cells:
                                  List.generate(item.subject.length + 3, (i1) {
                                return DataCell(
                                  i1 == 0 || i1 == 1
                                      ? AppUtil.customText(
                                          textAlign: TextAlign.center,
                                          text: i1 == 0
                                              ? "${index + 1}"
                                              : i1 == 1
                                                  ? item.name
                                                  : "",
                                          style: const TextStyle(
                                            color: Color(0xff334155),
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      : i1 == (item.subject.length + 2)
                                          ? OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.yellow.shade700,
                                                side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.yellow.shade700,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                for (var e in item.subject) {
                                                  e.value.value = "";
                                                }
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 2),
                                                child: AppUtil.customText(
                                                  text: "Clear All",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                Expanded(
                                                  child: Obx(
                                                    () => Row(
                                                      children: [
                                                        Radio(
                                                          value: item
                                                              .subject[i1 - 2]
                                                              .value
                                                              .value,
                                                          groupValue: "A",
                                                          onChanged:
                                                              (newValue) {
                                                            item.subject[i1 - 2]
                                                                    .value =
                                                                "A".obs;
                                                            setState(() {});
                                                          },
                                                        ),
                                                        AppUtil.customText(
                                                          text: "A",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Obx(
                                                    () => Row(
                                                      children: [
                                                        Radio(
                                                          value: item
                                                              .subject[i1 - 2]
                                                              .value
                                                              .value,
                                                          groupValue: "B",
                                                          onChanged:
                                                              (newValue) {
                                                            item.subject[i1 - 2]
                                                                    .value =
                                                                "B".obs;
                                                            setState(() {});
                                                          },
                                                        ),
                                                        AppUtil.customText(
                                                          text: "B",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Obx(
                                                    () => Row(
                                                      children: [
                                                        Radio(
                                                          value: item
                                                              .subject[i1 - 2]
                                                              .value
                                                              .value,
                                                          groupValue: "C",
                                                          onChanged:
                                                              (newValue) {
                                                            item.subject[i1 - 2]
                                                                    .value =
                                                                "C".obs;
                                                            setState(() {});
                                                          },
                                                        ),
                                                        AppUtil.customText(
                                                          text: "C",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Obx(
                                                    () => Row(
                                                      children: [
                                                        Radio(
                                                          value: item
                                                              .subject[i1 - 2]
                                                              .value
                                                              .value,
                                                          groupValue: "D",
                                                          onChanged:
                                                              (newValue) {
                                                            item.subject[i1 - 2]
                                                                    .value =
                                                                "D".obs;
                                                            setState(() {});
                                                          },
                                                        ),
                                                        AppUtil.customText(
                                                          text: "D",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
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
      ),
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

/// Term

class _Term extends StatelessWidget {
  final AdminCoScholasticController con;

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
  final AdminCoScholasticController con;

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
  final AdminCoScholasticController con;

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
  final AdminCoScholasticController con;

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
