import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.person),
        ),
      ),
    );
    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.password),
        ),
      ),
    );

    final btnLogin = Positioned(
      bottom: 40,
      width: MediaQuery.of(context).size.width * .9,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 177, 47, 0),
            foregroundColor: Colors.white, // Azul oscuro
          ),
          onPressed: () {
            isLoading = true;
            setState(() {});
            Future.delayed(
              const Duration(milliseconds: 4000)
            ).then((value) => {
              isLoading = false,
              setState(() {}),
              Navigator.pushNamed(context, "/pr3-responsive"),
            });
          },
          child: const Text('Ingresar')),
    );

    final btnYakult = Positioned(
      top: 10,
      right: 5,
      width: MediaQuery.of(context).size.width * .25,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 215, 137, 207),
            foregroundColor: Colors.white, // Azul oscuro
          ),
          onPressed: () {
            isLoading = true;
            setState(() {});
            Future.delayed(
              const Duration(milliseconds: 4000)
            ).then((value) => {
              isLoading = false,
              setState(() {}),
              Navigator.pushNamed(context, "/yakult"),
            });
          },
          child: const Text('Ver Yakult')),
    );

    final gifLoading = Positioned(
      top: 150,
      child: SizedBox(
        width: 250,  // Ancho deseado
        height: 250, // Altura deseada
        child: Lottie.asset('assets/lottie/TecNMLoading.json'),//Image.asset('assets/orangutangif.gif'),
      ),
    );

    final ctnCredentials = Positioned(
      bottom: 90,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 215, 122, 1),
            borderRadius: BorderRadius.circular(20)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser, txtPwd],
        ),
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/borneorainforest.jpg'))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 35,
              child: Image.asset(
                'assets/monkey-logo.png',
                width: 160,
              )
            ),
            ctnCredentials,
            btnLogin,
            btnYakult,
            isLoading ? gifLoading : Container()
          ],
        ),
      ),
    );
  }
}
