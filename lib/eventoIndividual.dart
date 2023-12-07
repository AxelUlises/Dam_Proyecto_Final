import 'package:dam_proyecto_final/serviciosremotos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class eventoIndividual extends StatefulWidget {
  final String descripcion;
  final String tipoEvento;
  final String id;
  final String propietario;

  eventoIndividual({required this.descripcion, required this.tipoEvento, required this.id, required this.propietario});

  @override
  State<eventoIndividual> createState() => _eventoIndividualState();
}

class _eventoIndividualState extends State<eventoIndividual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EVENTO"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                "ÁLBUM EVENTO",
                style: TextStyle(color: Colors.red, fontSize: 40, fontFamily: 'BebasNeue'),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("TIPO DE EVENTO: ${widget.tipoEvento}"),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("PROPIEDAD DE:    ${widget.propietario}"),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("DESCRIPCIÓN:      ${widget.descripcion}"),
            ),
            SizedBox(height: 10),

            // AQUÍ VAN LAS FOTOS

            Center(
              child: ElevatedButton(
                  onPressed: (){},
                  child: Text("AGREGAR FOTOS")
              ),
            )
          ],
        ),
      ),
    );

  }
}
