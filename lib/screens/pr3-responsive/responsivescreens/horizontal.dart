import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmsn2024b/screens/components/colors_slider.dart';
import 'package:pmsn2024b/screens/pr3-responsive/content_model.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Horizontal extends StatefulWidget {
  Horizontal(
    {
      super.key, 
      required this.content,
      this.index, 
      required this.onBgColorChange, 
      required this.onPrColorChange,
      required this.onFontChange,
      this.currentFont,
      required this.resetColors,
      this.currentBgColor,
      this.currentPrColor,
    }
  );

  OnboardingContent content;
  int? index;
  Function(Color) onBgColorChange;
  Function(Color) onPrColorChange;
  Function(String) onFontChange;
  String? currentFont;
  Color? currentBgColor;
  Color? currentPrColor;
  VoidCallback resetColors;

  @override
  State<Horizontal> createState() => _HorizontalState();
}

class _HorizontalState extends State<Horizontal> {
  final List<String> fonts = ['Roboto', 'Lobster', 'Poppins', 'Pacifico', 'Oswald'];

  @override
  Widget build(BuildContext context) {
    List<Color> colorHistory = [];
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                widget.content.image!,
                height: currentHeight * .5,
              ),
            ]
          ),
          Expanded(
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.content.title!,
                  style: GoogleFonts.getFont(
                    widget.currentFont != null ? widget.currentFont! : 'Roboto',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.index != null && widget.index == 1 ?
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: currentWidth * .2,
                          child: TextButton(
                            onPressed: () {
                              GlobalValues.flagDarkTheme.value = false;
                              GlobalValues.flagCustomTheme.value = 0;
                              widget.resetColors();
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
                          width: currentWidth * .2,
                          child: TextButton(
                            onPressed: () {
                              GlobalValues.flagDarkTheme.value = true;
                              GlobalValues.flagCustomTheme.value = 0;
                              widget.resetColors();
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tema personalizado',
                              style: GoogleFonts.getFont(
                                widget.currentFont != null ? widget.currentFont! : 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ColorsSlider(
                                  pickerColor: Theme.of(context).scaffoldBackgroundColor,
                                  onColorChanged: widget.onBgColorChange,
                                  buttonTxt: 'Fondo',
                                  buttonWidth: MediaQuery.of(context).size.width * .15,
                                  colorHistory: colorHistory,
                                  onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                                  currentFont: widget.currentFont != null ? widget.currentFont! : 'Roboto',
                                ),
                                ColorsSlider(
                                  pickerColor: Theme.of(context).primaryColor,
                                  onColorChanged: widget.onPrColorChange,
                                  buttonTxt: 'Primario',
                                  buttonWidth: MediaQuery.of(context).size.width * .15,
                                  colorHistory: colorHistory,
                                  onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                                  currentFont: widget.currentFont != null ? widget.currentFont! : 'Roboto',
                                ),
                                SizedBox(height: 5),
                                dropDownBtn(),
                              ],
                            ),
                            Container(
                              width: currentWidth * .15,
                              child: TextButton(
                                onPressed: () {
                                  if(widget.currentBgColor != null || widget.currentPrColor != null || widget.currentFont != 'Roboto'){
                                  print('Fuente actual $widget.currentFont');
                                  GlobalValues.flagCustomTheme.value++;
                                  GlobalValues.flagDarkTheme.value = false;
                                  GlobalValues.customPrimaryColor.value = Theme.of(context).primaryColor;
                                  GlobalValues.customScaffoldBackgroundColor.value = Theme.of(context).scaffoldBackgroundColor;
                                  GlobalValues.customFontFamily.value = widget.currentFont != null ? widget.currentFont! : 'Roboto';
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: '¡Tema guardado con éxito!',
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );
                                  } else { // Ambas son nulas
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.warning,
                                      text: 'Elige al menos un color personalizado',
                                      autoCloseDuration: const Duration(seconds: 4),
                                      showConfirmBtn: true
                                    );
                                  }
                                },
                                child: Text(
                                  'Aplicar',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    widget.currentFont != null ? widget.currentFont! : 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor, // Color de fondo
                                  foregroundColor: Colors.white,//Theme.of(context).textTheme.bodyMedium!.color, // Color del texto
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
                :
                Text(
                  widget.content.description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownBtn(){
    return Container(
      width: MediaQuery.of(context).size.width * .15,
      child: DecoratedBox(
        decoration: BoxDecoration( 
          color: Theme.of(context).primaryColor, //background color of dropdown button
          borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: DropdownButton<String>(
              value: widget.currentFont,
              underline: SizedBox(),
              dropdownColor: Theme.of(context).primaryColor,
              items: fonts.map((String font) {
                return DropdownMenuItem<String>(
                  value: font,
                  child: Text(
                    font,
                    style: GoogleFonts.getFont(font), // Aplicar fuente de muestra
                  ),
                );
              }).toList(),
              onChanged: (String? newFont) {
                widget.onFontChange(newFont!);
              },
            ),
        ),
        ),
    );
  }
}