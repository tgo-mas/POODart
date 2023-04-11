import "package:flutter/material.dart";

class NewNavBar extends StatelessWidget {
  List<BottomNavigationBarItem> itens = [];

  NewNavBar(List<Icon> icons) {
    this.itens = icons.map((ic) => BottomNavigationBarItem(icon: ic, label: '')).toList();
  }

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: itens);
  }
}

class NewBody extends StatelessWidget {
  NewBody();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Text("La Fin Du Monde - Bock - 65 ibu"),
      ),
      Expanded(
        child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
      ),
      Expanded(
        child: Text("Duvel - Pilsner - 82 ibu"),
      ),
    ]);
  }
}

class NewBar extends StatelessWidget with PreferredSizeWidget {
  NewBar();

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(title: Text("Dicas"));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: Scaffold(
          appBar: NewBar(),
          body: NewBody(),
          bottomNavigationBar: NewNavBar([
            Icon(Icons.coffee_outlined),
            Icon(Icons.flag_outlined),
            Icon(Icons.local_drink_outlined)
          ]),
        ));
  }
}

void main() {
  MyApp app = MyApp();

  runApp(app);
}
