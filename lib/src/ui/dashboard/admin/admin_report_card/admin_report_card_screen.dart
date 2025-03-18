import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/service/model/get_batch_model.dart';
import 'package:iroots/src/service/model/get_class_model.dart';
import 'package:iroots/src/service/model/get_section_model.dart';
import 'package:iroots/src/service/model/get_term_model.dart';
import 'package:iroots/src/ui/dashboard/admin/admin_report_card/admin_report_card_controller.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:iroots/src/utility/widget/flutter_typeahead.dart';

class AdminReportCardScreen extends StatelessWidget {
  AdminReportCardScreen({super.key});

  final AdminReportCardController con = Get.put(AdminReportCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: ConstClass.dashBoardColor,
        title: AppUtil.customText(
          text: "Report Card",
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
                          const SizedBox(height: 12),
                          _Class(con: con),
                          const SizedBox(height: 12),
                          _Section(con: con),
                          const SizedBox(height: 12),
                          _Term(con: con),
                          const SizedBox(height: 12),
                          _Batch(con: con),
                          const SizedBox(height: 12),
                          // _ShowButton(
                          //   onPressed: () {
                          //     if (con.selectedStaff.value.stafId
                          //             .toString()
                          //             .isNotNullOrEmpty &&
                          //         con.selectedClass.value.dataListItemId
                          //             .toString()
                          //             .isNotNullOrEmpty &&
                          //         con.selectedSection.value.dataListItemId
                          //             .toString()
                          //             .isNotNullOrEmpty &&
                          //         con.selectedTerm.value.termId
                          //             .toString()
                          //             .isNotNullOrEmpty &&
                          //         con.selectedBatch.value.batchId
                          //             .toString()
                          //             .isNotNullOrEmpty) {
                          //       con.showData();
                          //     } else {
                          //       toast(
                          //           "Select all dropdown for continue", false);
                          //     }
                          //   },
                          // ),
                          // const SizedBox(height: 12),
                          // if (con.subject.isNotEmpty)
                          //   if (con.subject.isNotEmpty) _Grid(con: con),
                          // if (con.subject.isNotEmpty)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 12),
                          //     child: OutlinedButton(
                          //       style: OutlinedButton.styleFrom(
                          //         backgroundColor: ConstClass.themeColor,
                          //         side: BorderSide(
                          //           width: 1.5,
                          //           color: ConstClass.themeColor,
                          //         ),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(8.0),
                          //         ),
                          //       ),
                          //       onPressed: () {
                          //         con.submitData();
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //           horizontal: 0,
                          //           vertical: 10,
                          //         ),
                          //         child: AppUtil.customText(
                          //           text: "Save",
                          //           style: const TextStyle(
                          //             color: Colors.white,
                          //             fontFamily: 'Open Sans',
                          //             fontWeight: FontWeight.w600,
                          //             fontSize: 14,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // if (con.subject.isNotEmpty)
                          //   SizedBox(height: Get.height * 0.12)
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
}

/// Batch

class _Batch extends StatelessWidget {
  final AdminReportCardController con;

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
  final AdminReportCardController con;

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
  final AdminReportCardController con;

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
  final AdminReportCardController con;

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
