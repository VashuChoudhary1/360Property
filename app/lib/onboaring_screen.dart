import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  int currentIndex = 0;

  final List<String> titles = [
    'Your Property Journey Starts Here.',
    'All-in-One Real Estate Partner.',
    'Focused on What Matters.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                isLastPage = (index == 2);
              });
            },
            children: const [
              OnboardPage(image: 'assets/house.png'),
              OnboardPage(image: 'assets/building.png'),
              OnboardPage(image: 'assets/village.png'),
            ],
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('360 PROPERTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    _controller.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: const Text('Skip >|',
                      style: TextStyle(color: Colors.red, fontSize: 16)),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 110,
            left: 20,
            right: 20,
            child: Text(
              titles[currentIndex],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    activeDotColor: Color(0xFFFF0000),
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0000),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NextScreen()));
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    isLastPage ? "Let's Start" : "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
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

class OnboardPage extends StatelessWidget {
  final String image;

  const OnboardPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Next Screen')),
    );
  }
}
