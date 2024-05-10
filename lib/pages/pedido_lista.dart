
import 'package:APP2/models/produtos_models.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {

  final List<ProdutosModels> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {

  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProdutosModels> _cart;

  Container pagoTotal(List<ProdutosModels> _cart){
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget> [
          Text("Total: R\$${valorTotal(_cart)}",
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.black)
          )
        ],
      ),
    );
  }

  //1:02:43

  String valorTotal(List<ProdutosModels> listaProdutos){
    double total = 0.0;
    for (int i = 0; i < listaProdutos.length; i++){
      total = total + listaProdutos[i].price * listaProdutos[i].quantity;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget> [
          IconButton(
              icon: Icon(Icons.book_online),
              onPressed: null,
              color: Colors.white,
            )
        ],
        title: Text('Detalhes',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: Colors.black
          )
        ),
        centerTitle: true,
        leading: IconButton(
                 icon: Icon(Icons.arrow_back),
                   onPressed: (){
                   Navigator.of(context).pop();
                   setState(() {
                     _cart.length;
                   });
                },
                   color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details){
          if(_enabled && _firstScroll){
            _scrollController.jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_){
          if (_enabled) _firstScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index){
                  final String imagen = _cart[index].image;
                  var item = _cart[index];
                  return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: Column(
                        children: <Widget> [
                          Row(
                            children: <Widget> [
                              Expanded(child:
                                Container(
                                width: 100,
                                height: 100,
                                  child: new Image.asset("assets/images/$imagen",
                                  fit: BoxFit.contain),
                                )
                              ),
                              Column(
                                children: <Widget> [
                                  Text(item.name,
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                      Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.red[600],
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 6.0,
                                              color: Colors.blue[400],
                                              offset: Offset(0.0, 1.0),
                                            )
                                          ],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          )
                                        ),
                                        margin: EdgeInsets.only(top: 20.0),
                                        padding: EdgeInsets.all(2.0),
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget> [

                                            SizedBox(height: 8.0,),

                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: (){
                                                _removeProduto(index);
                                                valorTotal(_cart);
                                                },
                                              color: Colors.white,
                                            ),

                                            Text('${_cart[index].quantity}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0,
                                              color: Colors.white
                                            )
                                            ),

                                            IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: (){
                                                _addProduto(index);
                                                valorTotal(_cart);
                                              },
                                              color: Colors.yellow,
                                            ),

                                            SizedBox(
                                              height: 8.0,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(
                                width: 38.0,
                              ),

                              Text('R\$',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.black
                              )),

                              Text(item.price.toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      color: Colors.black
                                  ))


                            ],
                           )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.purple,
                      )
                    ]
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                child: Padding (
                  padding: EdgeInsets.only(top: 50),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text("Pagar"),
                    onPressed: () => {
                      showDialog(context: context,
                      builder: (BuildContext context) => FancyDialog(
                        title: "Confirmar Produtos",
                        descreption: "Finalizar Pedido?",
                        animationType: FancyAnimation.BOTTOM_TOP,
                        theme: FancyTheme.FANCY,
                        gifPath: FancyGif.MOVE_FORWARD,
                        okFun: () => {print("Confirmando")},
                      ))
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  _addProduto(int index){
    setState(() {
      _cart[index].quantity++;
    });
  }

  _removeProduto(int index){
    setState(() {
      _cart[index].quantity--;
    });
  }

}
