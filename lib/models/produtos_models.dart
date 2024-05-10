
import 'package:flutter/material.dart';

class ProdutosModels {

  var id;

  String name;
  String image;
  double price;
  String description;
  String autor;
  String editora;
  int quantity;

  ProdutosModels(

  String documentID,
  String name,
  String image,
  double price,
  String description,
  String autor,
  String editora,
  int quantity,
);

  ProdutosModels.map(dynamic obj){

    this.id = obj['id'];
    this.name = obj['name'];
    this.image = obj['image'];
    this.price = obj['price'];
    this.description = obj['description'];
    this.autor = obj['autor'];
    this.editora = obj['editora'];
    this.quantity = obj['quantity'];


  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['price'] = price;
    map['description'] = description;
    map['autor'] = autor;
    map['editora'] = editora;
    map['quantity'] = quantity;

    return map;
  }

  ProdutosModels.fromMap(Map<String, dynamic> map){

    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'];
    this.price = map['price'];
    this.description = map['description'];
    this.autor = map['autor'];
    this.editora = map['editora'];
    this.quantity = 0;
  }

}

