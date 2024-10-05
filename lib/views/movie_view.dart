import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:toastification/toastification.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key, this.moviesDAO});

  MoviesDAO? moviesDAO;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {

  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();
  MoviesDatabase? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
    if(widget.moviesDAO != null){
      conName.text = widget.moviesDAO!.nameMovie!;
      conOverview.text = widget.moviesDAO!.overview!;
      conImgMovie.text = widget.moviesDAO!.imgMovie!;
      conRelease.text = widget.moviesDAO!.releaseDate!;
    }
  }

  @override
  Widget build(BuildContext context) {

    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: InputDecoration(
        hintText: 'Nombre de la película'
      ),
    );
    final txtOverview = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Sinopsis de la película'
      )
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: InputDecoration(
        hintText: 'Póster de la película'
      )
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: conRelease,
      decoration: InputDecoration(
        hintText: 'Fecha de lanzamiento'
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025)
        );

        if(pickedDate != null){
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          conRelease.text = formattedDate;
          setState(() {});
        }
      },
    );
    final btnSave = ElevatedButton(
      onPressed: (){
        if(widget.moviesDAO == null){
          moviesDatabase!.INSERT('tblmovies', {
            'nameMovie': conName.text,
            'overview': conOverview.text,
            'idGenre': 1,
            'imgMovie': conImgMovie.text,
            'releaseDate': conRelease.text,
          }).then((value) {
            final msj;
            QuickAlertType type;
            if(value > 0){
              GlobalValues.flagUpdListMovies.value = !GlobalValues.flagUpdListMovies.value;
              type = QuickAlertType.success;
              msj = 'Transaction Completed Successfully!';
            } else {
              type = QuickAlertType.error;
              msj = 'Something was wrong!';
            }
            return QuickAlert.show(
              context: context,
              type: type,
              text: msj,
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true
            );
          });
        } else {
          moviesDatabase!.UPDATE('tblmovies', {
            'idMovie': widget.moviesDAO!.idMovie,
            'nameMovie': conName.text,
            'overview': conOverview.text,
            'idGenre': 1,
            'imgMovie': conImgMovie.text,
            'releaseDate': conRelease.text,
          }).then((value){
            final msj;
            QuickAlertType type;
            if(value > 0) {
              GlobalValues.flagUpdListMovies.value = !GlobalValues.flagUpdListMovies.value;
              type = QuickAlertType.success;
              msj = 'Transaction Completed Successfully!';
            } else {
              type = QuickAlertType.error;
              msj = 'Something was wrong!';
            }
            return QuickAlert.show(
              context: context,
              type: type,
              text: msj,
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true
            );
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[200]
      ), 
      child: const Text('Guardar'),
    );

    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        txtNameMovie,
        txtOverview,
        txtImgMovie,
        txtRelease,
        SizedBox(
          height: 10,
        ),
        btnSave
      ],
    );
  }
}