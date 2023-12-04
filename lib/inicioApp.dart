import 'package:flutter/material.dart';

class inicioApp extends StatefulWidget {
  const inicioApp({super.key});

  @override
  State<inicioApp> createState() => _inicioAppState();
}

class _inicioAppState extends State<inicioApp> {
  String titulo = "Unity Memories App";
  int _index = 0;

  final descripcion = TextEditingController();
  final fechaInicio = TextEditingController();
  final tipoEvento  = TextEditingController();
  final fechaFinal  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: dinamico(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(child: Text("U"),),
                SizedBox(height: 20,),
                Text("Usuario", style: TextStyle(color: Colors.white, fontSize: 20),)
              ],
            ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            _item(Icons.event, "MIS EVENTOS", 0),
            _item(Icons.mode_of_travel_outlined, "INVITACIONES", 1),
            _item(Icons.create_new_folder, "CREAR EVENTO", 2),
            _item(Icons.settings, "CONFIGURACIÓN", 3),
            _item(Icons.exit_to_app, "SALIR", 4),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icono, String texto, int indice) {
    return ListTile(
      onTap: (){
        setState(() {
          _index = indice;
        });
        Navigator.pop(context);
      },
      title: Row(
        children: [Expanded(child: Icon(icono)), Expanded(child: Text(texto),flex: 3,)],
      ),
    );
  }

  Widget dinamico(){
    if(_index == 1){
      return invitaciones();
    }
    if(_index == 2){
      return crearEvento();
    }
    if(_index == 3){
      return configuracion();
    }
    if(_index == 4){
      return salir();
    }
    return misEventos();
  }
  
  Widget misEventos(){
    return ListView();
  }

  Widget invitaciones(){
    return ListView();
  }

  Widget crearEvento(){
    return ListView(
      padding: EdgeInsets.all(40),
      children: [
        Center(
          child: Text("EVENTO NUEVO", style: TextStyle(
              fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          controller: descripcion,
          decoration: InputDecoration(
              labelText: "DESCRIPCION:",
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always
          ),
        ),
        SizedBox(height: 15,),
        TextField(
          controller: fechaInicio,
          decoration: InputDecoration(
              labelText: "FECHA INICIO:",
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 15,),
        TextField(
          controller: tipoEvento,
          decoration: InputDecoration(
              labelText: "TIPO EVENTO:",
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always
          ),
        ),
        SizedBox(height: 15,),
        TextField(
          controller: fechaFinal,
          decoration: InputDecoration(
              labelText: "FECHA FINAL ",
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: (){

                },
                child: Text("Crear")
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _index = 0;
                  });
                },
                child: Text("Cancelar")
            ),
          ],
        )
      ],
    );
  }

  Widget configuracion(){
    return ListView();
  }

  Widget salir(){
    return ListView();
  }

}
