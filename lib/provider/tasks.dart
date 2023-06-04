import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_app_firebase/provider/task.dart';
import '../models/http_exeception.dart';

class Tasks with ChangeNotifier {
  List<Task> _items = [
    Task(id: "id", title: "tile", description: 'description')
  ];

  List<Task> get items {
    return [..._items];
  }

  Task findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
// https://todoapp-e736b-default-rtdb.firebaseio.com/
    final url =
        Uri.https('todoapp-e736b-default-rtdb.firebaseio.com', '/tasks.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Task> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Task(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Task product) async {
    // final url = Uri.https('flutter-update.firebaseio.com', '/products.json');
    final url = Uri.parse(
        'https://todoapp-e736b-default-rtdb.firebaseio.com/tasks.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
        }),
      );
      final newProduct = Task(
        title: product.title,
        description: product.description,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Task newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          Uri.https('flutter-update.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
    Uri.https('todoapp-e736b-default-rtdb.firebaseio.com', '/tasks/$id.json');
        // Uri.https('flutter-update.firebaseio.com', '/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Task? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpExeception('Could not delete product.');
    }
    existingProduct = null;
  }
}