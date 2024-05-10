import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:APP2/models/produtos_models.dart';
import 'dart:async';

final CollectionReference productCollection =
      Firestore.instance.collection('Produtos');

class FirebaseService {
      static final FirebaseService _instance = new FirebaseService.internal();
      factory FirebaseService() => _instance;

      FirebaseService.internal();

      Future<ProdutosModels> createProduct(
          String name, String image, double price, int quantity, String autor, String editora, String description){
            final TransactionHandler createTransaction = (Transaction tx) async {
                  final DocumentSnapshot doc = await tx.get(productCollection.document());

                  final ProdutosModels produto = new ProdutosModels(doc.documentID, name, image, price, description, autor, editora, quantity);

                  final Map<String, dynamic> data = produto.toMap();

                  await tx.set(doc.reference, data);

                  return data;
            };
            return Firestore.instance.runTransaction(createTransaction).then((mapData){
                  return ProdutosModels.fromMap(mapData);
            }).catchError((error){
                  print('error: $error');
                  return null;
            });
      }

      Stream<QuerySnapshot> getProductList({int offset, int limit}){
            Stream<QuerySnapshot> snapshot = productCollection.snapshots();

            if (offset != null) {
                  snapshot = snapshot.skip(offset);
            }
            if (limit != null) {
                  snapshot = snapshot.skip(limit);
            }
            return snapshot;
      }
}
