class Produto {
  double preco;
  String desc;
  DateTime validade;
  bool isValido() {
    if (DateTime.now().toUtc().isBefore(validade)) {
      return true;
    } else {
      return false;
    }
  }

  Produto(this.preco, this.desc, this.validade);
}

class Item {
  double qtd;
  Produto prod;
  double preco() => this.qtd * prod.preco;
  Item(this.qtd, this.prod);
}

class Venda {
  DateTime data;
  List<Item> itens;
  double total() {
    var map = itens.map((e) => e.preco());
    return map.reduce((v, el) => v + el);
  }

  Venda(this.data, this.itens);
}

void main(List<String> args) {
  var prod = Produto(43.99, "Este é um produto.", DateTime(2023, 3, 31));
  var prod2 = Produto(12.5, "Esse é pra você", DateTime(2023, 5, 30));
  var prod3 = Produto(20, "Garfo especial", DateTime(2023, 3, 25));
  var itens = [Item(12, prod), Item(5, prod2), Item(15, prod3)];
  var venda = Venda(DateTime(2023, 3, 13), itens);
  print(venda.total());
}
