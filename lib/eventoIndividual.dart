import 'package:dam_proyecto_final/serviciosremotos.dart';
import 'package:file_picker/file_picker.dart';
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
  String archivoRemoto = "";
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
            Container(
              height: 450,
              child: FutureBuilder(
                future: CR.mostrarTodos(widget.descripcion),
                builder: (context, listaRegreso) {
                  if (listaRegreso.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: listaRegreso.data?.items.length,
                      itemBuilder: (context, indice) {
                        final nombreImagen = listaRegreso.data!.items[indice].name;

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: CR.obtenerURLimagen(widget.descripcion, nombreImagen),
                            builder: (context, URL) {
                              if (URL.hasData) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Stack(
                                            children: [
                                              Image.network(URL.data!, fit: BoxFit.contain),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.white,),
                                                  onPressed: () {
                                                    Navigator.pop(context); // Cierra el diálogo
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    child: Image.network(URL.data!, fit: BoxFit.cover),
                                  ),
                                );
                              } else if (URL.hasError) {
                                return Text('Error loading image');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        );
                      },
                    );
                  } else if (listaRegreso.hasError) {
                    // Return an error widget if there is an error
                    return Text('Error loading data');
                  } else {
                    // Return a loading indicator while the future is still in progress
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),



            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                  onPressed: () async{
                    final archivoAEnviar = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png','jpg','jpeg']
                    );

                    if(archivoAEnviar==null){
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ERROR! No se seleccionó ARCHIVO")));
                      });
                      return;
                    }

                    var path = archivoAEnviar.files.single.path!!;
                    var nombre = archivoAEnviar.files.single.name!!;
                    var nombreCarpeta = widget.descripcion;

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SUBIENDO ARCHIVO")));
                    });

                    CR.subirArchivo(path, nombre, nombreCarpeta);

                  },
                  child: Text("AGREGAR FOTOS")
              ),
            )
          ],
        ),
      ),
    );

  }
}

