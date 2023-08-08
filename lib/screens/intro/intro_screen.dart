import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/intro/final_intro_screen.dart';
import 'package:diabuddy/screens/intro/first_intro_page.dart';
import 'package:diabuddy/screens/intro/fourth_intro_page.dart';
import 'package:diabuddy/screens/intro/second_intro_page.dart';
import 'package:diabuddy/screens/intro/third_intro_page.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/custom_rectangle_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController pageController;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: CustomRectangleShape(),
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 25,
            ),
            child: PageView(
              controller: pageController,
              onPageChanged: (index) => {
                if (index == 3)
                  {
                    setState(() {
                      isLastPage = true;
                    })
                  }
                else
                  {
                    setState(() {
                      isLastPage = false;
                    })
                  }
              },
              children: const [
                FirstIntroPage(),
                SecondIntroPage(),
                ThirdIntroPage(),
                FourthIntroPage()
              ],
            ),
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            height: 100,
            child: isLastPage
                ? AppButton(
                    text:
                        AppLocalizations.of(context)!.fourthIntroPageButtonText,
                    callback: () {
                      UserSimplePreferences.setOnboardingScreenSkip(true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinalIntroScreen(),
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  )
                : Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 4,
                      effect: JumpingDotEffect(
                        activeDotColor: primaryColor,
                        dotColor: primaryColor.withOpacity(0.3),
                        dotHeight: 22,
                        dotWidth: 22,
                        spacing: 30,
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
