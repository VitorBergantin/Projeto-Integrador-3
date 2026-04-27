import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../data/ambientes_mock.dart';

class PontosController extends ChangeNotifier {
  double lati = 0.0;
  double long = 0.0;
  String erro = '';
  bool loading = true;

  PontosController() {
    getPosicao();
  }

Future<void> getPosicao() async {
  loading = true;
  notifyListeners();

  try {
    Position posicao = await _posicaoAtual();
    lati = posicao.latitude;
    long = posicao.longitude;
  } catch (e) {
    erro = 'Erro ao obter localização';
  }

  loading = false;
  notifyListeners();
}

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Por favor, habilite a localização');
    }

    permissao = await Geolocator.checkPermission();
    
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        return Future.error('Precisamos que autorize acesso a localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Por favor, habilite a localização');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      ),  
    );
  }

  String? pontoAtual;

  void verificarProximidade() {
    bool dentroDeAlgum = false;

    for (var amb in ambientesMock) {
      double distancia = Geolocator.distanceBetween(
        lati,
        long,
        amb.latitude,
        amb.longitude,
      );

      if (distancia < amb.raioMetros) {
        dentroDeAlgum = true;

        if (pontoAtual != amb.id) {
          pontoAtual = amb.id;
          notifyListeners();
        }

        return;
      }
    }

    if (!dentroDeAlgum && pontoAtual != null) {
      pontoAtual = null;
      notifyListeners();
    }
  }

  void atualizarLocalizacao(double novaLat, double novaLong) {
    lati = novaLat;
    long = novaLong;

    verificarProximidade();
    notifyListeners();
  }
}