import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

var baseremota = FirebaseFirestore.instance;
var carpetaRemota = FirebaseStorage.instance;

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
      var query = await baseremota.collection("usuarios").where('idUsuario', isEqualTo: uid).get();
      if (query.docs.isNotEmpty) {
        // Obtener el ID del primer documento que cumple con la consulta
        var idDocumento = query.docs.first.id;
        await baseremota.collection("usuarios").doc(idDocumento).update({
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

  static Future<List> buscarInvitacion(String idinvitacion) async {
    List temp = [];

    try {
      var documento = await baseremota.collection("eventos").doc(idinvitacion).get();

      if (documento.exists) {
        // El documento existe, puedes acceder a sus datos
        var datos = documento.data();
        print("Datos del documento con ID $idinvitacion: $datos");

        temp.add(documento.data());
        print(temp);
      } else {
        // El documento no existe
        print("No se encontró ningún documento con el ID $idinvitacion");
      }


    } catch (e) {
      // Manejar el error según sea necesario
      print("Error al obtener el documento: $e");
    }

    return temp;

  }

  static Future agregarInvitado(String id, String uid) async {
    try {
      // Referencia al documento en la colección "eventos"
      var referenciaEvento = await baseremota.collection("eventos").doc(id).get().then((value) {
        if (value.exists) {
          // Verificar si el documento existe antes de acceder a sus datos
          Map<String, dynamic>? mapa = value.data();

          if (mapa != null && mapa.isNotEmpty) {
            List<dynamic> idInvitado = mapa['invitados'] ?? [];
            idInvitado.add(uid);

            baseremota.collection("eventos").doc(id).update({'invitados': idInvitado});
          } else {
            print("El documento está vacío o no contiene datos.");
          }
        } else {
          print("El documento con ID $id no existe.");
        }
      });

      print("Invitado agregado con éxito al evento con ID $id");
    } catch (e) {
      // Manejar el error según sea necesario
      print("Error al agregar invitado: $e");
    }
  }



}

class CR{
  static Future subirArchivo(String path, String nombreImagen, String nombreCarpeta) async {
    var file = File(path);

    return await carpetaRemota.ref("$nombreCarpeta/$nombreImagen").putFile(file);
  }

  static Future<ListResult> mostrarTodos( nombreCarpeta) async{
    String carpeta = nombreCarpeta;
    return await carpetaRemota.ref(carpeta).listAll();
  }

  static Future<String> obtenerURLimagen(String nombreCarpeta,String nombre)async{
    return await carpetaRemota.ref("$nombreCarpeta/$nombre").getDownloadURL();
  }

}








