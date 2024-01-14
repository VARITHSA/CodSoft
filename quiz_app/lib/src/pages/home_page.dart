// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/src/models/constants/colors.dart';
import 'package:quiz_app/src/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Text(
              "Hey Shouyo!",
              style: GoogleFonts.poppins(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select the subject:",
              style: GoogleFonts.poppins(
                fontSize: 26,
                color: Colours.goldColor,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                CustomCard(
                  name: 'assets/images/english.svg',
                  title: 'English',
                  routeName: Routes.englishPageRoute,
                ),
                CustomCard(
                  name: 'assets/images/history.svg',
                  title: 'History',
                  routeName: Routes.historyPageRoute,
                ),
              ],
            ),
            Row(
              children: [
                CustomCard(
                  name: 'assets/images/maths.svg',
                  title: 'Maths',
                  routeName: Routes.mathsPageRoute,
                ),
                CustomCard(
                  name: 'assets/images/science.svg',
                  title: 'Science',
                  routeName: Routes.sciencePageRoute,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Didn't find your subject?",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () => _showDialog(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "send the subject you are searching for",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colours.goldColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_showDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Give Subject',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.20,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Subject',
                  hintStyle: GoogleFonts.poppins(color: Colours.goldColor),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.goldColor),
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class CustomCard extends StatefulWidget {
  CustomCard({
    required this.name,
    required this.title,
    required this.routeName,
    super.key,
  });
  String name;
  String title;
  String routeName;
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late Color _color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _color = Colours.goldColor;
            Navigator.pushNamed(context, widget.routeName);
            _color = Colors.black;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 220,
          width: 180,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SvgPicture.asset(widget.name),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colours.goldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
