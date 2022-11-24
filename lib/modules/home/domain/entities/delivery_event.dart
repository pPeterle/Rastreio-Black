class DeliveryEvent {
  final String status;
  final String data;
  final String hora;
  final String? origem;
  final String? destino;
  final String? local;

  const DeliveryEvent({
    required this.status,
    required this.data,
    required this.hora,
    this.origem,
    this.destino,
    this.local,
  });
}
