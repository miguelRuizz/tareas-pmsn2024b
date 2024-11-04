import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2024b/firebase/movies_firebase.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/views/movie_view_firebase.dart';
import 'package:pmsn2024b/views/movie_view_item.dart';
import 'package:pmsn2024b/views/movie_view_item_firebase.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreenFirebase extends StatefulWidget {
  const MoviesScreenFirebase({super.key});

  @override
  State<MoviesScreenFirebase> createState() => _MoviesScreenFirebaseState();
}

class _MoviesScreenFirebaseState extends State<MoviesScreenFirebase> {
  MoviesFirebase? dbMovies; // Se instancia la DB de Firebase
  @override
  void initState() {
    // TODO: implement initState
    dbMovies = MoviesFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        actions: [
          IconButton(
            onPressed: (){
              WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) => [
                  WoltModalSheetPage(
                    child: MovieViewFirebase()
                  )
                ],
              );
            },
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: StreamBuilder(
        stream: dbMovies!.SELECT(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var movies = snapshot.data!.docs;
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                // return Image.network(snapshot.data!.docs[index].get('imgMovie'));
                var movieData = movies[index];
                return MovieViewItemFirebase(
                  moviesDAO: MoviesDAO.fromMap(
                    {
                      'idMovie': 0,
                      'imgMovie': movieData.get('imgMovie'),//snapshot.data!.docs[index].get('imgMovie'),
                      'nameMovie': movieData.get('nameMovie'),
                      'overview': movieData.get('overview'),
                      'releaseDate': movieData.get('releaseDate').toString()
                    }
                  ), Uuid: movieData.id
                );
              },
            );
          } else {
            if(snapshot.hasError){
              return Center(child: Text(snapshot.toString()));
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
      ),
    );
  }
}