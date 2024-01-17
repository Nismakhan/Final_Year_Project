import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/elevated_button_style.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final ValueNotifier<int> currentIndex = ValueNotifier(0);
  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String>> onboardingData = [
    {
      'title': "Welcome to Notice Board",
      'description':
          "Welcome to the Notice - your hub for efficient communication and information sharing. Discover official notices from organizations and connect with users. Get started to stay informed!",
      'image': "assets/images/onboarding1.png",
    },
    {
      'title': "User Registration",
      'description':
          "Unlock the full potential of [Project Name]! Register today to create your account. Your data is secure with us, and registration is your gateway to posting notices, messaging, and more.",
      'image': "assets/images/onboarding2.png",
    },
    {
      'title': " Unique User ID:",
      'description':
          "You're now part of this app! Your unique User ID sets you apart. It's your authentic digital identity, making your interactions personal and meaningful. Remember it; it's your key to the community!",
      'image': "assets/images/onboarding3.png",
    },
  ];

  void nextPage() {
    if (currentIndex.value < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void navigateToLoginScreen() {
    Navigator.of(context).pushReplacementNamed(AppRouter.userOrganization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: InkWell(
              onTap: () {
                // _pageController.jumpToPage(onboardingData.length - 1);
                navigateToLoginScreen();
              },
              child: currentIndex.value == onboardingData.length - 1
                  ? const SizedBox()
                  : Text(
                      'Skip',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.lightGreyColor,
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: kIsWeb ? 600 : screenWidth(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 18.h),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex.value = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return buildPageContent(
                      onboardingData[index]['title']!,
                      onboardingData[index]['description']!,
                      onboardingData[index]['image']!,
                      index == onboardingData.length - 1,
                    );
                  },
                ),
                Positioned(
                  bottom: 180.h,
                  width: 350.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < onboardingData.length; i++)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Container(
                            width: 25.w,
                            height: 6.50.h,
                            decoration: ShapeDecoration(
                              color: currentIndex.value == i
                                  ? AppColors.blueColor
                                  : AppColors.lightGreyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ValueListenableBuilder<int>(
                    valueListenable: currentIndex,
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: value == onboardingData.length - 1
                            ? navigateToLoginScreen
                            : nextPage,
                        style: elevatedButtonStyles(),
                        child: Text(
                          value == onboardingData.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageContent(
      String title, String description, String image, bool isLastPage) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 374.w,
          height: 335.3.h,
        ),
        SizedBox(height: 54.h),
        SizedBox(
          width: 380.w,
          height: 180.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 13.h),
              SizedBox(
                width: 390.w,
                height: 130.h,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.spMin,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
