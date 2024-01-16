import 'dart:convert';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/constants/colors.dart';
import '../models/history_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<HistoryModel?> fetchDataFromJson(String filePath) async {
    try {
      String contents = await rootBundle.loadString(filePath);
      Map<String, dynamic> jsonMap = json.decode(contents);
      return HistoryModel.fromJson(jsonMap);
    } catch (e) {
      log("Error fetchingdata : $e");
      return null;
    }
  }

  late PageController _pageController;

  HistoryModel? historyModel;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    fetchData();

    super.initState();
  }

  Future<void> fetchData() async {
    String filePath = 'assets/json/history.json';
    historyModel = await fetchDataFromJson(filePath);

    if (historyModel != null) {
      setState(() {});
    } else {
      print('Failed to fetch data from the JSON file.');
    }
  }

  bool isActive = false;
  isPressed() {
    setState(() {
      isActive = !isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.bgColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircularCountDownTimer(
              initialDuration: 0,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 3,
              duration: 120,
              fillColor: Colours.goldColor,
              ringColor: Colors.black,
              textStyle: GoogleFonts.poppins(color: Colors.white),
              onComplete: () => _showSubmitDialog(context),
              // onStart: () => _showStartDialog(context),
            ),
          )
        ],
      ),
      backgroundColor: Colours.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'English QUIZ',
                  style: GoogleFonts.poppins(
                    color: Colours.goldColor,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: historyModel!.history!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RichText(
                          text: TextSpan(
                            text: '${index + 1}. ',
                            style: GoogleFonts.poppins(
                                color: Colours.goldColor, fontSize: 22),
                            children: [
                              TextSpan(
                                text:
                                    '${historyModel!.history![index].question}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                            itemCount:
                                historyModel!.history![index].options!.length,
                            itemBuilder: ((context, indexs) {
                              return GestureDetector(
                                onTap: () {
                                  log(historyModel!
                                      .history![index].options![indexs]);
                                  var curr = historyModel!
                                      .history![index].options![indexs];
                                  var corr = historyModel!
                                      .history![index].correctOption;
                                  curr == corr ? isPressed() : log('FaIl');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 70,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: isActive
                                          ? Colours.goldColor
                                          : Colors.black,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Text(
                                            historyModel!.history![index]
                                                .options![indexs],
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeIn);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colours.goldColor),
                              child: Text(
                                'BACK',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                historyModel!.history!.length == index + 1
                                    ? _showSubmitDialog(context)
                                    : _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeIn);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colours.goldColor),
                              child: Text(
                                'NEXT',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

_showSubmitDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.bgColor,
          title: Text(
            "Want to Submit?",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colours.goldColor,
            ),
          ),
          content: ElevatedButton(
              onPressed: () {},
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colours.goldColor),
              child: Text(
                'SUBMIT',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              )),
        );
      });
}
