import 'package:flutter/material.dart';
import 'package:miloficiosapp/models/categoria.dart';
import 'package:miloficiosapp/views/solicitud.dart';

class ListarDetalleCategorias extends StatelessWidget {
  Categoria categoria;

  ListarDetalleCategorias(this.categoria);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoria.nombre),
      ),
      body: Column(
        children: [
          Image.network(categoria.urlBanner),
          Expanded(
            child: ListView.builder(
                itemCount: categoria.subcategorias.length,
                itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CrearSolicitud(
                                  categoria.subcategorias[index]),
                            ));
                      },
                      title: Text(categoria.subcategorias[index].nombre),
                    )),
          ),
        ],
      ),
    );
  }
}