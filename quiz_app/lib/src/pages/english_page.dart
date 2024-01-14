import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/src/models/constants/colors.dart';

class EnglishPage extends StatefulWidget {
  const EnglishPage({super.key});

  @override
  State<EnglishPage> createState() => _EnglishPageState();
}

class _EnglishPageState extends State<EnglishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.bgColor,
        actions: [
          Text(
            'TImer',
            style: GoogleFonts.poppins(
              color: Colours.goldColor,
              fontSize: 22,
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: RichText(
              text: TextSpan(
                text: '1.',
                style: GoogleFonts.poppins(
                  color: Colours.goldColor,
                  fontSize: 22,
                ),
                children: [
                  TextSpan(
                    text: 'In literature, what is a protagonist?',
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
                itemCount: 4,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 70,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              "Option 1",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
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
                  onPressed: () {},
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
                  onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
