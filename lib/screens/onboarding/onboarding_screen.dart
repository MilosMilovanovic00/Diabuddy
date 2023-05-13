import 'package:diabuddy/screens/onboarding/start_onboarding_page.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/custom_rectangle_shape.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartOnboardingScreen extends StatelessWidget {
  const StartOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

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
              children: const [
                StartOnboardingPage(),
              ],
            ),
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            height: 100,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: SwapEffect(
                  activeDotColor: primaryColor,
                  dotColor: primaryColor.withOpacity(0.3),
                  dotHeight: 24,
                  dotWidth: 24,
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
