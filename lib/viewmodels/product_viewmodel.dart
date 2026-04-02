import 'package:flutter/foundation.dart';
import 'package:todo/models/product_model.dart';
import 'package:todo/services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  ProductViewModel();

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ProductService.getProducts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
