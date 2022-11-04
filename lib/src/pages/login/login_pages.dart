import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:uber_demo_udemy/src/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginController  con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.topCenter,
        height: 50,
        child: _textdontHaveCount(),
      ),
      body: Stack(
        //Posicionar  elementos uno debajo del otro
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            //Posicionar  elementos uno debajo del otro (Vertical)

            children: [_imageCover(), _textAppName()],
          )
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      color: Colors.amber,
      alignment: Alignment.center,
    );
  }

  //Private
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        alignment: Alignment.center,
        child: Image.network(
          "https://miro.medium.com/max/500/1*acOrLPKlQa2zyEG7Er8eng.png",
          width: 130,
          height: 130,
        ),
      ),
    );
  }

  Widget _textAppName() {
    return const Text(
      "DELIVERY MYSQL",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.32, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.075))
          ]),
      child: SingleChildScrollView(
        child: Column(children: [
          _texYourInfo(),
          _textGFieldEmail(),
          _textFieldPassword(),
          _buttomLogin()
        ]),
      ),
    );
  }

  Widget _textGFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: con.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'Correo electronico', prefixIcon: Icon(Icons.email))),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: con.passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: Icon(Icons.lock),
          )),
    );
  }

  Widget _buttomLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.login(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            "LOGIN",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _texYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 40),
      child: const Text("INGRESA ESTA INFORMACIÓN",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            
          )),
    );
  }

  Widget _textdontHaveCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Text(
          "¿No tienes cuenta ?",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: ()=> con.goToRegisterPage(),
          child:const  Text(
            "Registrate Aqui!!",
            style: TextStyle(
                color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }
}
