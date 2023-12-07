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

  static Future<List<String>> recuperarDatos(String uid) async {
    var query = await baseremota.collection("usuarios").where('idUsuario', isEqualTo: uid).get();
    List<String> temporal = List.filled(2, ''); // Inicializa la lista con dos elementos vacíos.

    query.docs.forEach((element) {
      Map<String, dynamic> mapa = element.data();
      temporal[0] = mapa['nombre'];
      temporal[1] = mapa['nickname'];
    });

    return temporal;
  }

  static Future<void> actualizarDatosUsuario(String uid, String nuevoNombre, String nuevoNickname) async {
    try {
      var query = await FirebaseFirestore.instance.collection("usuarios").where('idUsuario', isEqualTo: uid).get();
      String idDoc = "";
      if (query.docs.isNotEmpty) {
        // Obtener el ID del primer documento que cumple con la consulta
        var idDocumento = query.docs.first.id;
        await FirebaseFirestore.instance.collection("usuarios").doc(idDocumento).update({
          'nombre': nuevoNombre,
          'nickname': nuevoNickname,
        });
        print("No hay al encontrar el documento del usuario $uid");
      } else {
        print("Error al encontrar el documento del usuario $uid");
        return null;
      }
    } catch (e) {
      print("Error al obtener el ID del documento: $e");
      return null;
    }
  }

  static Future<List> misEventos(String uid) async{
    List temp = [];
    var query = await baseremota.collection("eventos").where('propietario', isEqualTo: uid).get();

    query.docs.forEach((element) {
      Map<String, dynamic> dato = element.data();
      dato.addAll({
        'id': element.id
      });

      temp.add(dato);
    });

    return temp;
  }

  static Future<List> misInvitaciones(String uid) async{
    List temp = [];
    var query = await baseremota.collection("eventos").where('invitados', arrayContains: uid).get();

    query.docs.forEach((element) {
      Map<String, dynamic> dato = element.data();
      dato.addAll({
        'id': element.id
      });

      temp.add(dato);
    });

    return temp;
  }


}