import 'package:corider/providers/user_state.dart';
import 'package:flutter/material.dart';
import 'root.dart';

import 'package:corider/providers/user_state.dart';
import 'package:flutter/material.dart';
import 'root.dart';

class OnboardingScreen extends StatefulWidget {
  final UserState userState;
  const OnboardingScreen({super.key, required this.userState});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      backgroundColor: LinearGradient(
        colors: [Colors.blue, Colors.lightBlueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      title: 'Welcome to MoveMate',
      description:
      'Join us in reducing traffic congestion and promoting sustainable transportation. With MoveMate, carpooling becomes a delightful and eco-friendly way to commute.',
      imagePath: 'assets/images/carpool (1).png', // Add an image asset here
    ),
    const OnboardingPage(
      backgroundColor: LinearGradient(
        colors: [Colors.purple, Colors.deepPurpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      title: 'Find a Ride',
      description:
      "Easily discover rides shared by colleagues that match your schedule and route. Say goodbye to the hassle and enjoy a comfortable, shared journey.",
      imagePath: 'assets/images/carpool (1).png', // Add an image asset here
    ),
    const OnboardingPage(
      backgroundColor: LinearGradient(
        colors: [Colors.orange, Colors.deepOrangeAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      title: 'Offer a Ride',
      description:
      "By offering a ride on MoveMate, you help your colleagues and the planet. Share your journey and make commuting more efficient and social.",
      imagePath: 'assets/images/carpool (1).png', // Add an image asset here
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return _pages[index];
            },
          ),
          Positioned(
            bottom: 40.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPageIndicator(),
                _currentPage != _pages.length - 1
                    ? TextButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
                    : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => RootNavigationView(
                        userState: widget.userState,
                      ),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(_pages.length, (int index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: _currentPage == index ? 16.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.white : Colors.grey,
          ),
        );
      }),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final LinearGradient backgroundColor;
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200.0), // Display the image
          const SizedBox(height: 40.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Text.rich(
            TextSpan(
              text: description,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              children: const [
                TextSpan(
                  text: ' MoveMate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                TextSpan(
                  text: ' to ',
                ),
                TextSpan(
                  text: 'enjoy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
                // More text spans as needed
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
