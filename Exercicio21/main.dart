import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<Map> tableStateNotifier =
      new ValueNotifier({"dados": [], "colunas": []});

  void carregar(index) {
    var callbacks = [carregarCafes, carregarCervejas, carregarNacoes];

    callbacks[index]();
  }

  void carregarCervejas() {
    tableStateNotifier.value = {
      "dados": [
        {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
        {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
        {"name": "Duvel", "style": "Pilsner", "ibu": "82"}
      ],
      "colunas": ["Nome", "Estilo", "IBU"]
    };
  }

  void carregarCafes() {
    tableStateNotifier.value = {
      "dados": [
        {"name": "Icla", "style": "Forte", "ibu": "65"},
        {"name": "Santa Clara", "style": "Amargo", "ibu": "54"},
        {"name": "São Braz", "style": "Concentrado", "ibu": "82"}
      ],
      "colunas": ["Nome", "Intensidade", "Nota"]
    };
  }

  void carregarNacoes() {
    tableStateNotifier.value = {
      "dados": [
        {"name": "Brazil", "style": "South America", "ibu": "65"},
        {"name": "Angola", "style": "Africa", "ibu": "54"},
        {"name": "Moçambique", "style": "Central America", "ibu": "82"}
      ],
      "colunas": ["Nome", "Continente", "IDH"]
    };
  }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                const properties = <String>["name", "style", "ibu"]; //Erro ao iniciar o projeto, mas some ao clicar na navbar
                return DataTableWidget(
                    jsonObjects: value["dados"],
                    propertyNames: properties,
                    columnNames: value["colunas"]);
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  var itemSelectedCallback;

  NewNavBar({this.itemSelectedCallback}) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          itemSelectedCallback(index);
          // carregarCervejas();
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;

  final List<String> columnNames;

  final List propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const ["Nome", "Estilo", "IBU"],
      this.propertyNames = const ["name", "style", "ibu"]});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}
