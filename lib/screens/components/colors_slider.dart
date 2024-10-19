//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorsSlider extends StatefulWidget {
  const ColorsSlider({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    required this.buttonWidth,
    this.colorHistory,
    this.onHistoryChanged,
    this.buttonTxt,
    required this.currentFont,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;
  final String? buttonTxt;
  final double buttonWidth; 
  final String currentFont;


  @override
  State<ColorsSlider> createState() => _ColorsSliderState();
}

class _ColorsSliderState extends State<ColorsSlider> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [ColorLabelType.hsl, ColorLabelType.hsv];
  bool _displayHexInputBar = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: widget.pickerColor,
                    onColorChanged: widget.onColorChanged,
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: _enableAlpha,
                    labelTypes: _labelTypes,
                    displayThumbColor: _displayThumbColor,
                    paletteType: _paletteType,
                    pickerAreaBorderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                    hexInputBar: _displayHexInputBar,
                    colorHistory: widget.colorHistory,
                    onHistoryChanged: widget.onHistoryChanged,
                  ),
                ),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.pickerColor,
          elevation: 10,
          side: BorderSide(
            color: Theme.of(context).primaryColor, // Color del borde
            width: 2,           // Grosor del borde
          ),
        ),
        child: Text(
          widget.buttonTxt ?? 'Color',
          style: GoogleFonts.getFont(
            widget.currentFont,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          )
        ),
      ),
    );
  }
}