import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MoviesFirebase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  MoviesFirebase(){
    collectionReference = firebaseFirestore.collection('movies');
  }

  Future<bool> INSERT(Map<String, dynamic> movie) async {
    try {
      collectionReference!.doc().set(movie);
    } catch (e) {
      kDebugMode ? print('Excepción al insertar: ${e}') : '';
      return false;
    }
    return true;
  }

  Future<bool> UPDATE(Map<String, dynamic> movie, String uid) async {
    try {
      collectionReference!.doc(uid).update(movie);
    } catch (e) {
      kDebugMode ? print('Excepción al actualizar: ${e}') : '';
      return false;
    }
    return true;
  }

  Future<bool> DELETE(String uid) async {
    try {
      collectionReference!.doc(uid).delete();
    } catch (e) {
      kDebugMode ? print('Excepción al borrar: ${e}') : '';
      return false;
    }
    return true;
  }
  
  Stream<QuerySnapshot> SELECT() {
    return collectionReference!.snapshots(); // Retorna todos los documentos de Firebase
  }
}