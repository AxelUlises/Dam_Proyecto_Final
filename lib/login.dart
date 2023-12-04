import 'package:dam_proyecto_final/crearUsuario.dart';
import 'package:dam_proyecto_final/inicioApp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _contrasenaCont = TextEditingController();

  String email = "";
  String contrasena = "";

  void _iniciarSesion() async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: contrasena
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bienvenido: ${userCredential.user!.email}"),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => inicioApp())
      );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al Iniciar Sesión $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
              key: _forKey,
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Text("Unity Memories", style: TextStyle(
                      fontSize: 35, color: Colors.blue, fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _emailCont,
                    keyboardType:  TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Ingrese un correo";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox( height:20),
                  TextFormField(
                    controller: _contrasenaCont,
                    keyboardType:  TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Contraseña",
                        floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Ingrese la contraseña";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        contrasena = value;
                      });
                    },
                  ),
                  SizedBox( height:15),
                  ElevatedButton(
                      onPressed: (){
                        if(_forKey.currentState!.validate()){
                          _iniciarSesion();
                        }
                      },
                      child: Text("Autenticar", style: TextStyle(
                          fontSize: 20
                        ),
                      )
                  ),
                  SizedBox( height:10),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => crearusuario())
                        );
                      },
                      child: Text("Inscribirse", style: TextStyle(
                          fontSize: 20
                        ),
                      )
                  ),
                ],
              )
          ),
        ),
      ),

    );
  }
}