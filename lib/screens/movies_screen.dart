import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/views/movie_view_item.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesDatabase moviesDB;

  @override
  void initState() {
    super.initState();
    moviesDB = MoviesDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies List'),),
      body: FutureBuilder(
        future: moviesDB.SELECT(),
        builder: (context, AsyncSnapshot<List<MoviesDAO>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemBuilder: (context, index){
                return MovieViewItem(moviesDAO: snapshot.data![index],);
              },
            );
          } else {
            if(snapshot.hasError){
              return Center(child: Text('Something was wrong! :)'),);
            } else {
              return Center(child: Lottie.asset('assets/lottie/TecNMLoading.json')/*CircularProgressIndicator()*/,);
            }
          }
        }
      ),
    );
  }
}