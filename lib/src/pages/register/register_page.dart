import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/register/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterController registerCon = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _buttonBack(),
        _imageUser(context)
      ],
    ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      color: Colors.amber,
      alignment: Alignment.center,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.32, left: 10, right: 10),
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
          _textFieldName(),
          _textFieldLastName(),
          _textFieldPhone(),
          _textFieldPassword(),
          _textFieldConfirmPassword(),
          _buttomRegister(context)
        ]),
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _textGFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: registerCon.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'Correo electronico', prefixIcon: Icon(Icons.email))),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: registerCon.nameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: 'Nombre', prefixIcon: Icon(Icons.person))),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: registerCon.lastNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: 'Apellido', prefixIcon: Icon(Icons.person_outline))),
    );
  }

  Widget _textFieldPhone() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            controller: registerCon.phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Telefono',
              prefixIcon: Icon(Icons.phone),
            )));
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: registerCon.passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: Icon(Icons.lock),
          )),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: registerCon.confirmPasswordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Confirmar Contraseña',
            prefixIcon: Icon(Icons.lock),
          )),
    );
  }

  Widget _buttomRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => registerCon.register(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            "Registrarse",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () => registerCon.showAlertDialog(context),
          child: GetBuilder<RegisterController>(
            builder: (value)=>CircleAvatar(
            backgroundImage: registerCon.imageFile != null
                ? FileImage(registerCon.imageFile!)
                : AssetImage("assets/img/delivery.png") as ImageProvider,
            radius: 80,
            backgroundColor: Colors.white,
          ),
          )
        ),
      ),
    );
  }

  Widget _texYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: const Text("INGRESA ESTA INFORMACIÓN",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
