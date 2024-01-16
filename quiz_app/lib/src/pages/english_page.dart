import 'dart:convert';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/src/models/constants/colors.dart';
import 'package:quiz_app/src/models/english_model.dart';

class EnglishPage extends StatefulWidget {
  const EnglishPage({super.key});

  @override
  State<EnglishPage> createState() => _EnglishPageState();
}

class _EnglishPageState extends State<EnglishPage> {
  Future<EnglishModel?> fetchDataFromJson(String filePath) async {
    try {
      String contents = await rootBundle.loadString(filePath);
      Map<String, dynamic> jsonMap = json.decode(contents);
      return EnglishModel.fromJson(jsonMap);
    } catch (e) {
      log("Error fetchingdata : $e");
      return null;
    }
  }

  late PageController _pageController;

  EnglishModel? englishModel;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    fetchData();

    super.initState();
  }

  Future<void> fetchData() async {
    String filePath = 'assets/json/english.json';
    englishModel = await fetchDataFromJson(filePath);

    if (englishModel != null) {
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

  final Color _correctAns = Colors.black;
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
                itemCount: englishModel!.english!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RichText(
                          text: TextSpan(
                            text: '${index + 1}. ',
                            style: GoogleFonts.poppins(
                              color: Colours.goldColor,
                              fontSize: 22,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${englishModel!.english![index].question}',
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
                                englishModel!.english![index].options!.length,
                            itemBuilder: ((context, indexs) {
                              return GestureDetector(
                                onTap: () {
                                  log(englishModel!
                                      .english![index].options![indexs]);
                                  var curr = englishModel!
                                      .english![index].options![indexs];
                                  var corr = englishModel!
                                      .english![index].correctOption;
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
                                            englishModel!.english![index]
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
                                englishModel!.english!.length == index + 1
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.goldColor),
                child: Text(
                  'SUBMIT',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                )),
          );
        });
  }

  _showStartDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.bgColor,
          title: Text(
            'Ready to start',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colours.goldColor,
            ),
          ),
          content: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colours.goldColor),
              child: Text(
                'START',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              )),
        );
      },
    );
  }
}
