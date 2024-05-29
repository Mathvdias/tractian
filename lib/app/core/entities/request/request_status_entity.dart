enum RequestStatusEntity {
  analisys('Em análise', 0xFFfcb900, 0xFFEB575),
  accepted('Aprovado', 0xFF129166, 0xFF0a4531),
  rejected('Recusado', 0xFFEB5757, 0xE94949),
  concluded('Concluído', 0xFF129166, 0xFF0a4531),
  notDefined('Não definido', 0xFF010101, 0xFFFFFFFF);

  final String label;
  final int color;
  final int foregroundColor;

  const RequestStatusEntity(this.label, this.color, this.foregroundColor);

  static RequestStatusEntity fromString(String name) {
    switch (name) {
      case 'analysis':
        return RequestStatusEntity.analisys;
      case 'accepted':
        return RequestStatusEntity.accepted;
      case 'rejected':
        return RequestStatusEntity.rejected;
      case 'concluded':
        return RequestStatusEntity.concluded;
      default:
        return RequestStatusEntity.notDefined;
    }
  }
}
