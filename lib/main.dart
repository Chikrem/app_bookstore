import 'dart:async';

import 'package:APP2/pages/first_page.dart';
import 'package:APP2/models/produtos_models.dart';
import 'package:APP2/pages/outra_pagina.dart';
import 'package:APP2/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/pedido_lista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: MyHomePage(title: 'Book Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ProdutosModels> _produtosModels = List<ProdutosModels> ();
  List<ProdutosModels> _listaCarrinho = [];

  FirebaseService db = new FirebaseService();

  StreamSubscription<QuerySnapshot> produtoSub;

  @override
  void initState() {
    super.initState();

    _produtosModels = new List();

    produtoSub?.cancel();
    produtoSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<ProdutosModels> products = snapshot.documents
          .map((documentSnapshot) => ProdutosModels.fromMap(documentSnapshot.data)).toList();
      setState(() {
        this._produtosModels = products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
        Padding(padding: const EdgeInsets.only(right: 16.0, top: 8.0),
        child: GestureDetector(
          child: Stack(
            alignment: Alignment.topCenter,
                children: <Widget> [
                  Icon(Icons.shopping_cart, size: 38,),
                  if(_listaCarrinho.length > 0)
                    Padding(padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                        child: Text(
                        _listaCarrinho.length.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  if(_listaCarrinho.isNotEmpty)
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Cart(_listaCarrinho),
                    ),
                  );
                },
              ),
            )
          ],
      ),
        drawer: Container(
          width: 170.0,
          child: Drawer(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              color: Colors.blueAccent,
              child: new ListView(
                padding: EdgeInsets.only(top: 50.0),
                children: <Widget> [
                  Container(
                    height: 120,
                      child: new UserAccountsDrawerHeader(
                        accountName: new Text(''),
                        accountEmail: new Text(''),
                        decoration: new BoxDecoration(
                        image: new DecorationImage(image: AssetImage('assets/images/book.png'),
                        fit: BoxFit.fill)

                      ),
                    ),
                  ),

                  new Divider( ),
                  new ListTile(
                    title: new Text('Home',
                      style: TextStyle(color: Colors.white),),
                    trailing: new Icon(Icons.home, size: 30.0, color: Colors.white,),
                    onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => OutraPagina(),
                     )
                    ),
                  ),

                  new Divider( ),
                  new ListTile(
                    title: new Text('Minhas Compras',
                      style: TextStyle(color: Colors.white),),
                    trailing: new Icon(Icons.shopping_bag, size: 30.0, color: Colors.white,),
                    onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OutraPagina(),
                    )
                    ),
                  ),

                  new Divider( ),
                  new ListTile(
                    title: new Text('Procurar',
                      style: TextStyle(color: Colors.white),),
                    trailing: new Icon(Icons.search, size: 30.0, color: Colors.white,),
                    onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OutraPagina(),
                    )
                    ),
                  ),

                  new Divider( ),
                  new ListTile(
                    title: new Text('Minha Conta',
                      style: TextStyle(color: Colors.white),),
                    trailing: new Icon(Icons.login, size: 30.0, color: Colors.white,),
                    onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OutraPagina(),
                    )
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
        body: _quadroProdutos(),
    );
  }

  GridView _quadroProdutos(){
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _produtosModels.length,
      itemBuilder: (context, index){
          final String image = _produtosModels[index].image;

          var item = _produtosModels[index];


          return Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => FirstPage(),
              )
              ),
                child: Center(
                  child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [

                    Expanded(
                      child: new Image.asset(
                          "assets/images/$image",
                          fit:BoxFit.contain,),),


                    Text(item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                    ),

                    SizedBox(
                      height: 15.0,
                    ),


                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(item.price.toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0,
                        color: Colors.black26
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(
                        right: 8.0,
                        bottom: 8.0,
                        ),
                        child:  Align(alignment: Alignment.bottomRight,
                          child: GestureDetector(
                              child: (!_listaCarrinho.contains(item))

                          ? Icon(Icons.shopping_cart,
                                color: Colors.blueAccent,
                                size: 38,
                              ) :

                            Icon(Icons.shopping_cart,
                                color: Colors.greenAccent,
                                size: 38,
                              ),

                              onTap: (){
                                setState(() {
                                  if(!_listaCarrinho.contains(item))
                                    _listaCarrinho.add(item);
                                  else
                                    _listaCarrinho.remove(item);
                                });

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                 )
                ),
            ),

          );
      },
    );
  }
}




