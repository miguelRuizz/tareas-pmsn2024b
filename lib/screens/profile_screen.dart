import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:pmsn2024b/main.dart';
import 'package:pmsn2024b/screens/components/camera_screen.dart';
import 'package:pmsn2024b/screens/start_screen.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Uri _url = Uri.parse('https://github.com/miguelRuizz');

  // Abre la URL a mi github
  Future<void> _githubURL() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future pickImage() async {
    try {
      final imgPerfil = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imgPerfil == null) return;
      final imageTemp = File(imgPerfil.path);
      setState(() => GlobalValues.pfpImage.value = imageTemp);
    } on PlatformException catch (e) {
      print('Error al cambiar imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Perfil'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Column(
        children: <Widget>[
          userInfo(),
          Expanded(child: sideContactMenu()),
        ],
      ),
    );
  }

  Widget userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            // Imagen de perfil
            currentAccountPicture: ValueListenableBuilder<File?>(
              valueListenable: GlobalValues.pfpImage,
              builder: (context, imageFile, child) {
                return CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      final position = details.globalPosition;
                      popUpMenuPfp(context, position);
                    },
                    child: ClipOval(
                      child: imageFile != null
                      ? Image.file(
                          imageFile,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/orangutanpfp.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                    ),
                  ),
                );
              },
            ),

            // Datos del Usuario
            accountName: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(86, 78, 0, 0)),
              child: const Text(
                'Pongo Pygmaeus',
              )
            ),
            accountEmail: Container(
              child: ElevatedButton(
                onPressed: () async {
                  await EasyLauncher.email(email: 'pongopygmaeus@gmail.com');
                },
                child: Text("pongopygmaeus@gmail.com"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Elimina el padding
                  minimumSize: Size(0, 0), // Establece un tamaño mínimo si es necesario
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Ajusta el tamaño del botón
                ),
              ),
            ),

            // Imagen de fondo
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/borneobackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> popUpMenuPfp(BuildContext context, Offset position) {
    return showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // Lado izquierdo del menú
        position.dy, // Lado superior del menú
        MediaQuery.of(context).size.width, // Lado derecho del menú
        MediaQuery.of(context).size.height, // Lado inferior del menú
      ),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'camera',
          child: ListTile(
            leading: Icon(Icons.camera),
            title: Text('Nueva foto'),
          ),
        ),
        const PopupMenuItem<String>(
          value:'gallery',
          child: ListTile(
            leading: Icon(Icons.image),
            title: Text('Elegir de galería'),
          ),
        ),
        //const PopupMenuDivider(),
      ],
    ).then((value){
      if(value!=null){
        if(value == 'gallery'){
          pickImage();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CameraScreen(),
            ),
          );
        }
      } 
    });
  }

  Widget sideContactMenu() {
    return Row(
      children: [
        // Menú lateral estático
        Container(
          width: MediaQuery.of(context).size.width*.42,  // Ancho del menú lateral
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Center(child: Text('Contacto')),
              ),
              Divider(thickness: 2, height: 0,),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(Icons.phone),
                title: Text('4612727474', style: TextStyle(fontSize: 14)),
                onTap: () async {await EasyLauncher.call(number: "4612727474");},
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(SimpleIcons.github),
                title: Text('GitHub', style: TextStyle(fontSize: 15)),
                onTap: _githubURL,
              ),
              // Agrega más ListTiles aquí según lo necesario
            ],
          ),
        ),
        // Contenido principal
        Expanded(
          child: Center(
            child: Text('Contenido Principal de la App'),
          ),
        ),
      ],
    );
  }
}