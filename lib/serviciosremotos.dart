import 'package:cloud_firestore/cloud_firestore.dart';


var baseremota = FirebaseFirestore.instance;

class DB{
  static Future<String> creaEvento(Map<String, dynamic> evento) async {
    DocumentReference eventoRef = await baseremota.collection("eventos").add(evento);
    return eventoRef.id;
  }

  static Future<String> creaUsuario(Map<String, dynamic> usuario) async {
    DocumentReference eventoRef = await baseremota.collection("usuarios").add(usuario);
    return eventoRef.id;
  }

  static Future<String> recuperarNombre(String iud) async {
    var query = await FirebaseFirestore.instance.collection("usuarios").where('idUsuario', isEqualTo: iud).get();

    if (query.docs.isNotEmpty) {
      // Accede al primer documento resultante
      var primerDocumento = query.docs.first;

      // Obtén el valor del campo 'nombre'
      var nombre = primerDocumento['nombre'];

      // Devuelve el nombre
      return nombre ?? ''; // Asegúrate de manejar el caso en el que el campo 'nombre' podría ser nulo
    } else {
      // Manejar el caso en el que no se encontraron documentos
      return ''; // Puedes devolver una cadena vacía o algún valor predeterminado
    }
  }

  static Future<String> recuperarAbr(String iud) async {
    var query = await FirebaseFirestore.instance.collection("usuarios").where('nickname', isEqualTo: iud).get();

    if (query.docs.isNotEmpty) {
      // Accede al primer documento resultante
      var primerDocumento = query.docs.first;

      // Obtén el valor del campo 'nombre'
      var nombre = primerDocumento['nickname'];

      // Devuelve el nombre
      return nombre ?? ''; // Asegúrate de manejar el caso en el que el campo 'nombre' podría ser nulo
    } else {
      // Manejar el caso en el que no se encontraron documentos
      return ''; // Puedes devolver una cadena vacía o algún valor predeterminado
    }
  }
  
  

}