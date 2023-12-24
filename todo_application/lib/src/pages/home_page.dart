import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 247, 233, 247),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 247, 233, 247),
        backgroundColor: Colors.grey[100],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Icon(Icons.menu),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20),
                  child: Text(
                    "Hi Shouyo!",
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "20 remaining tasks",
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.search),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Search your tasks",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.expand_more_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Your Tasks',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
