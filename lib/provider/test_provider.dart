import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';

class TestProvider extends ChangeNotifier{
  String _name = 'Miguel Ruiz';



  String get name => _name;

  set name(String value){
    _name = value;
    notifyListeners();
  }
  
   // Almacenar los ID de las películas favoritas
  final Set<int> _favoriteMovies = {};

  // Método para verificar si una película está en favoritos
  bool isFavorite(int movieId) {
    return _favoriteMovies.contains(movieId);
  }

  // Método para agregar o quitar una película de favoritos
  void toggleFavorite(int movieId) {
    if (_favoriteMovies.contains(movieId)) {
      _favoriteMovies.remove(movieId);
    } else {
      _favoriteMovies.add(movieId);
    }
    notifyListeners(); // Notificar a los listeners que el estado ha cambiado
  }

  Set<int> get favoriteMovies => _favoriteMovies;

  // Método para agregar favoritos
  void addFavorites(List<int> movies) {
    _favoriteMovies.addAll(movies); // Usar addAll para agregar múltiples elementos al Set
    notifyListeners();
  }

  // Método para limpiar el Set de favoritos
  void clearFavorites() {
    _favoriteMovies.clear();
    notifyListeners();
  }
}