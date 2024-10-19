import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conUser = TextEditingController();
  final conEmail = TextEditingController();
  final conPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/borneorainforest.jpg'))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ctnCredentials(),               
              btnRegister(),
            ],
          )),
    );
  }

  Widget txtUser() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget txtEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conEmail,
      decoration: const InputDecoration(
        prefixIcon: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget txtPwd() {
    return TextFormField(
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
  }

  Widget btnRegister() {
    return Positioned(
      bottom: 190,
      width: MediaQuery.of(context).size.width * .9,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 194, 102, 130),
            foregroundColor: Colors.white, // Azul oscuro
          ),
          onPressed: () {
            setState(() {});
            Navigator.pushNamed(context, "/register");
          },
          child: const Text('Registrarse')),
    );
  }

  Widget ctnCredentials() {
    return Positioned(
      top: 200,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(175, 133, 215, 1),
            borderRadius: BorderRadius.circular(20)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser(), txtEmail(), txtPwd()],
        ),
      ),
    );
  }
}
