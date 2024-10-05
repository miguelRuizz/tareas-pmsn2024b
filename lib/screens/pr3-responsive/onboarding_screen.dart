import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmsn2024b/screens/pr3-responsive/content_model.dart';
import 'package:pmsn2024b/screens/pr3-responsive/responsivescreens/horizontal.dart';
import 'package:pmsn2024b/screens/pr3-responsive/responsivescreens/vertical.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    String currentForm = currentWidth < 600 ? 'vertical' : 'horizontal' ;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                if(currentWidth < 600){
                  currentForm = 'vertical';
                  return Vertical(content: contents[i], index: currentIndex,);
                } else {
                  currentForm = 'horizontal';
                  return Horizontal(content: contents[i]);
                }
              }
            ),
          ),
          Container(
            // Puntitos de selección actual
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            // Botón de siguiente
            height: 60,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 15),
            width: double.infinity,
            child: TextButton(
              child: Text(
                  currentIndex == contents.length - 1 ? 'Continue' : 'Next'),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushNamed(context, "/home");
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn
                );
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor, // Color de fondo
                foregroundColor: Colors.white, // Color del texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
