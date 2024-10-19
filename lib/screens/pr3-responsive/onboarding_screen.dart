import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmsn2024b/screens/pr3-responsive/content_model.dart';
import 'package:pmsn2024b/screens/pr3-responsive/responsivescreens/horizontal.dart';
import 'package:pmsn2024b/screens/pr3-responsive/responsivescreens/vertical.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;
  Color? _selectedBgColor; // Color inicial del fondo
  Color? _selectedPrColor; // Color inicial primario
  String? _selectedFont; // Fuente de letra inicial
  void changeBgColor(Color color) => setState(() { /*currentColor = color*/ 
    _selectedBgColor = color;
      // GlobalValues.flagCustomTheme.value++;
      // GlobalValues.flagDarkTheme.value = false;
      // GlobalValues.customScaffoldBackgroundColor.value = color;
      // Theme.of(context).copyWith(
      //   scaffoldBackgroundColor: color,
      // );
  });
  void changePrColor(Color color) => setState(() { /*currentColor = color*/ 
    _selectedPrColor = color;
    // GlobalValues.flagCustomTheme.value++;
    // GlobalValues.flagDarkTheme.value = false;
    // GlobalValues.customPrimaryColor.value = color;
    // Theme.of(context).copyWith(
    //   primaryColor: color,
    // );
  });
  // Función callback que hace que las variables de color sean null
  void resetColors() {
    setState(() {
      _selectedBgColor = null;
      _selectedPrColor = null;
      _selectedFont = null;
      print('El bg color es: ' + _selectedBgColor.toString());
    });
  }
  void changeFont(String font) {
    setState(() {
      _selectedFont = font;
      print(_selectedFont);
    });
  }

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
    // _selectedBgColor = Theme.of(context).scaffoldBackgroundColor;
    // _selectedPrColor = Theme.of(context).primaryColor;
    final currentWidth = MediaQuery.of(context).size.width;
    final ThemeData currentTheme = _selectedBgColor != null || _selectedPrColor != null || _selectedFont != null
    ? ThemeData(
      primaryColor: _selectedPrColor ?? Theme.of(context).primaryColor,  // Color primario personalizado
      scaffoldBackgroundColor: _selectedBgColor ?? Theme.of(context).scaffoldBackgroundColor, // Color de fondo personalizado
      textTheme: Theme.of(context).textTheme.apply(
        fontFamily: _selectedFont ?? Theme.of(context).textTheme.titleLarge!.fontFamily!.replaceAll('_regular', ''),
      ),
    ) : 
    Theme.of(context);

    return Theme(
      data: currentTheme,
      child: Scaffold(
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
                    return Vertical(
                      content: contents[i], 
                      index: currentIndex,
                      onBgColorChange: changeBgColor,
                      onPrColorChange: changePrColor,
                      onFontChange: changeFont,
                      currentFont: _selectedFont ?? Theme.of(context).textTheme.titleLarge!.fontFamily!.replaceAll('_regular', ''),
                      currentBgColor: _selectedBgColor,
                      currentPrColor: _selectedPrColor,
                      resetColors: resetColors,
                    );
                  } else {
                    return Horizontal(
                      content: contents[i],
                      index: currentIndex,
                      onBgColorChange: changeBgColor,
                      onPrColorChange: changePrColor,
                      onFontChange: changeFont,
                      currentFont: _selectedFont ?? Theme.of(context).textTheme.titleLarge!.fontFamily!.replaceAll('_regular', ''),
                      currentBgColor: _selectedBgColor,
                      currentPrColor: _selectedPrColor,
                      resetColors: resetColors,
                    );
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
                    currentIndex == contents.length - 1 ? 'Continue' : 'Next',
                    style: GoogleFonts.getFont(
                      _selectedFont ?? Theme.of(context).textTheme.titleLarge!.fontFamily!.replaceAll('_regular', ''),
                    )
                ),
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
                  backgroundColor: _selectedPrColor ?? Theme.of(context).primaryColor, // Color de fondo
                  foregroundColor: Colors.white, // Color del texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
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
        color: _selectedPrColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
