import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/pontos_controller.dart';
import '../data/ambientes_mock.dart';


class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PontosController>();

    if (controller.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (controller.erro.isNotEmpty) {
      return Scaffold(
        body: Center(child: Text(controller.erro)),
      );
    }

    final posicaoUsuario = LatLng(controller.lati, controller.long);

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: posicaoUsuario,
          zoom: 17,
        ),
        onMapCreated: (mapCtrl) {
          mapController = mapCtrl;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        markers: {
          // jogador
          Marker(
            markerId: const MarkerId('jogador'),
            position: posicaoUsuario,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
          ),

          ...ambientesMock.map((amb) {
              return Marker(
                markerId: MarkerId(amb.id),
                position: LatLng(amb.latitude, amb.longitude),
                infoWindow: InfoWindow(
                  title: amb.nome,
                  snippet: amb.descricao,
                ),
              );
            }),
          },
            circles: ambientesMock.map((amb) {
              return Circle(
                circleId: CircleId(amb.id),
                center: LatLng(amb.latitude, amb.longitude),
                radius: amb.raioMetros,
                strokeWidth: 2,
                strokeColor: controller.pontoAtual == amb.id
                    ? Colors.green // 👈 está dentro
                    : Colors.red,
                fillColor: Colors.transparent,
              );
            }).toSet(),
      ),
    );
  }
}