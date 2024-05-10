import 'package:APP2/models/produtos_models.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  List<ProdutosModels> _produtosModels = List<ProdutosModels> ();
  List<ProdutosModels> _listaCarrinho = List<ProdutosModels> ();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color(0xFFFF0000),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          SizedBox(height: 25.0),
          Padding(padding: EdgeInsets.only(left: 5.0),
            child: Row(
              children: <Widget>[
                Text('item name',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 105.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(75.0),
                    bottomLeft: Radius.circular(75.0))
            ),

          )
        ],
      ),
    );
  }
}


GridView _paginaProduto(){

  List<ProdutosModels> _produtosModels = List<ProdutosModels> ();
  List<ProdutosModels> _listaCarrinho = List<ProdutosModels> ();

  return GridView.builder(
    padding: const EdgeInsets.all(4.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: _produtosModels.length,
    itemBuilder: (context, index){

      final String image = _produtosModels[index].image;

      var item = _produtosModels[index];


      return Card(
        margin: EdgeInsets.all(8.0),
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

              ],
            )
        ),
      );
    },
  );
}