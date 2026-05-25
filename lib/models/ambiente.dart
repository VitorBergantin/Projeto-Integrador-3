import 'package:cloud_firestore/cloud_firestore.dart';

class Ambiente {
  final String id;
  final String nome;
  final String descricao;
  final double latitude;
  final double longitude;
  final double raioMetros;

  const Ambiente({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.latitude,
    required this.longitude,
    required this.raioMetros,
  });

  factory Ambiente.fromFirestore(
    Map<String, dynamic> data, {
    String? documentId,
  }) {
    final localizacao = data['localização'] ?? data['localizacao'];
    final latitude = _readCoordinate(
      data,
      localizacao,
      primaryKey: 'latitude',
      geoPointGetter: (geoPoint) => geoPoint.latitude,
    );
    final longitude = _readCoordinate(
      data,
      localizacao,
      primaryKey: 'longitude',
      geoPointGetter: (geoPoint) => geoPoint.longitude,
    );

    return Ambiente(
      id: (data['id'] as String?)?.trim().isNotEmpty == true
          ? (data['id'] as String).trim()
          : (documentId ?? ''),
      nome: data['nome'] ?? '',
      descricao: data['descricao'] ?? '',
      latitude: latitude,
      longitude: longitude,
      raioMetros: _readDouble(data['raioMetros'] ?? data['raio'] ?? 35),
    );
  }

  static double _readCoordinate(
    Map<String, dynamic> data,
    dynamic localizacao, {
    required String primaryKey,
    required double Function(GeoPoint geoPoint) geoPointGetter,
  }) {
    final direct = data[primaryKey];
    if (direct != null) {
      return _readDouble(direct);
    }

    if (localizacao is GeoPoint) {
      return geoPointGetter(localizacao);
    }

    if (localizacao is Map<String, dynamic>) {
      return _readDouble(localizacao[primaryKey]);
    }

    if (localizacao is Map) {
      return _readDouble(localizacao[primaryKey]);
    }

    return 0;
  }

  static double _readDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '.')) ?? 0;
    }
    return 0;
  }
}
