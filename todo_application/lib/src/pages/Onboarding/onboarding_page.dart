import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/src/models/utils/page_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: demo.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardContents(
                    image: demo[index].image,
                    title: demo[index].title,
                    subtext: demo[index].subtext,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Spacer(),
                const SizedBox(
                  width: 80,
                ),
                ...List.generate(
                  demo.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 65,
                  width: 65,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[300],
                    ),
                    onPressed: () {
                      _pageIndex == 2
                          ? Navigator.of(context)
                              .pushNamed(Routes.homePageRoute)
                          : _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                    },
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isActive ? 15 : 10,
      width: isActive ? 40 : 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isActive ? Colors.purple[300] : Colors.grey.shade400,
      ),
    );
  }
}

List<OnboardContents> demo = [
  OnboardContents(
      image: 'assets/images/onboard1.svg',
      title: 'Modify your work plan and stay motivated',
      subtext:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '),
  OnboardContents(
      image: 'assets/images/onboard2.svg',
      title: 'Analyze your work everday and stay on track',
      subtext:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '),
  OnboardContents(
      image: 'assets/images/onboard3.svg',
      title: 'Modify your work plan and stay motivated',
      subtext:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '),
];

// ignore: must_be_immutable
class OnboardContents extends StatelessWidget {
  String image;
  String title;
  String subtext;
  OnboardContents({
    Key? key,
    required this.image,
    required this.title,
    required this.subtext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(image),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            )),
        const Spacer(),
        Text(
          subtext,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
// assets/images/onboard2.svg
// WELCOME
// WELCOME