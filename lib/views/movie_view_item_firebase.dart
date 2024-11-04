import 'package:flutter/material.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/firebase/movies_firebase.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/views/movie_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItemFirebase extends StatefulWidget {
  MovieViewItemFirebase({
    super.key, 
    required this.moviesDAO,
    required this.Uuid,
  });

  MoviesDAO moviesDAO;
  final Uuid;

  @override
  State<MovieViewItemFirebase> createState() => _MovieViewItemState();
}

class _MovieViewItemState extends State<MovieViewItemFirebase> {
  
  MoviesFirebase? dbMovies;
  
  @override
  void initState() {
    super.initState();
    dbMovies = MoviesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.moviesDAO.imgMovie!,
                height: 100,
              ),
              Expanded(
                child: ListTile(
                  title: Text(widget.moviesDAO.nameMovie!),
                  subtitle: Text(widget.moviesDAO.releaseDate!),
                ),
              ),
              IconButton(onPressed: (){
                WoltModalSheet.show(
                  context: context,
                  pageListBuilder: (context) => [
                    WoltModalSheetPage(
                      child: MovieView(moviesDAO: widget.moviesDAO)
                    )
                  ],
                );
              }, 
              icon: Icon(Icons.edit)),
              IconButton(
                onPressed: (){
                  dbMovies!.DELETE(
                    widget.Uuid
                  ).then((value){
                    if(value){
                      GlobalValues.flagUpdListMovies.value = !GlobalValues.flagUpdListMovies.value;
                      return QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Movie was successfully erased!',
                        autoCloseDuration: const Duration(seconds: 2),
                        showConfirmBtn: true
                      );
                    } else {
                      return QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        text: 'Something was wrong! :()',
                        autoCloseDuration: const Duration(seconds: 2),
                        showConfirmBtn: true
                      );
                    }
                  });
                },
                icon: Icon(Icons.delete)),
            ],
          ),
          Divider(),
          Text(widget.moviesDAO.overview!)
        ],
      ),
    );
  }
}