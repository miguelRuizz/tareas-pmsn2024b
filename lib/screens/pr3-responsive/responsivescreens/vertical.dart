import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pmsn2024b/screens/components/colorpicker.dart';
import 'package:pmsn2024b/screens/components/colors_slider.dart';
import 'package:pmsn2024b/screens/pr3-responsive/content_model.dart';
import 'package:pmsn2024b/settings/global_values.dart';

class Vertical extends StatefulWidget {
  Vertical({super.key, required this.content, this.index});

  OnboardingContent content;
  int? index;

  @override
  State<Vertical> createState() => _VerticalState();
}

class _VerticalState extends State<Vertical> {
  

  @override
  Widget build(BuildContext context) {
    Color currentColor = Theme.of(context).scaffoldBackgroundColor;
    List<Color> colorHistory = [];

    void changeBgColor(Color color) => setState(() { /*currentColor = color*/ 
      GlobalValues.flagCustomTheme.value = true;
      Theme.of(context).copyWith(
        scaffoldBackgroundColor: color,
      );
    });
    void changePrColor(Color color) => setState(() { /*currentColor = color*/ 
      GlobalValues.flagCustomTheme.value = true;
      Theme.of(context).copyWith(
        primaryColor: color,
      );
    });
    
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Image.asset(
            widget.content.image!,
            height: currentHeight * .4,
            width: currentWidth * 2,
            // height: currentHeight * .1,
            // width: currentWidth * 1,
          ),
          Text(
            widget.content.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          widget.index != null && widget.index == 1 ?
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: currentWidth * .4,
                        child: TextButton(
                          onPressed: () {
                            GlobalValues.flagDarkTheme.value = false;
                          },
                          child: Icon(Icons.light_mode),
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
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: currentWidth * .4,
                        child: TextButton(
                          onPressed: () {
                            GlobalValues.flagDarkTheme.value = true;
                          },
                          child: Icon(Icons.dark_mode),
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
                  SizedBox(height: 10,),
                  ColorsSlider(
                    pickerColor: Theme.of(context).scaffoldBackgroundColor,
                    onColorChanged: changeBgColor,
                    buttonTxt: 'Color de Fondo',
                    colorHistory: colorHistory,
                    onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                  ),
                  ColorsSlider(
                    pickerColor: Theme.of(context).primaryColor,
                    onColorChanged: changePrColor,
                    buttonTxt: 'Color Primario',
                    colorHistory: colorHistory,
                    onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                  )
                ],
              ),
            )
          :
            Text(
              widget.content.description!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )
        ],
      ),
    );
  }
}