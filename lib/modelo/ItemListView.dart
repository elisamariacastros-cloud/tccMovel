//classe modelo de objeto
class ItemListView {
  final String treino;
  final String descricao;

  ItemListView({required this.treino, required this.descricao});

  factory ItemListView.fromJson(Map<String, dynamic> json) {
    return ItemListView(
      treino: json['treino'],
      descricao: json['descricao'],
    );
  }
}
