import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class crearusuario extends StatefulWidget {
  const crearusuario({super.key});

  @override
  State<crearusuario> createState() => _crearusuarioState();
}

class _crearusuarioState extends State<crearusuario> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _contrasenaCont = TextEditingController();

  String email = "";
  String contrasena = "";

  // Función para manejar el registro de usuario
  void _handleSingUp(BuildContext context) async {
    try {
      // Intenta registrar al usuario con el correo y la contraseña proporcionados
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: contrasena,
      );

      // Muestra un SnackBar con el correo del usuario registrado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario registrado: ${userCredential.user!.email}"),
        ),
      );

      // Después de mostrar el SnackBar, navega a la interfaz de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
    } catch (e) {
      // Si hay un error durante el registro, muestra un SnackBar con el mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar usuario: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicio Autenticación"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
              key: _forKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Crear Usuario",
                    style: TextStyle(fontSize: 35, color: Colors.blue),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _emailCont,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                        floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _contrasenaCont,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña",
                        floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // Al presionar el botón, valida el formulario y maneja el registro
                      if (_forKey.currentState!.validate()) {
                        _handleSingUp(context);
                      }
                    },
                    child: Text("Registrar", style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
