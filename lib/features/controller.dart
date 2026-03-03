import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/common/Toast.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/services/auth_service.dart';

class CartData extends ChangeNotifier {
  List<Map<String, String>> selectedPackages = [];
  int cartCount = 0;

  CartData() {
    loadCartData();
  }

  Future<void> _saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(selectedPackages);
    await prefs.setString('selectedPackages', encoded);
    final token = await AuthService.getToken();
    if (token != null && token.isNotEmpty) {
      try {
        final res = await http.post(
          Uri.parse(ApiConfig.cart),
          headers: await AuthService.authHeaders(),
          body: json.encode({'items': selectedPackages}),
        );
        if (res.statusCode != 200) {
          print('Cart API save failed: ${res.statusCode} ${res.body}');
        }
      } catch (e) {
        print('Cart API error: $e');
      }
    }
  }

  Future<void> loadCartData() async {
    final token = await AuthService.getToken();
    if (token != null && token.isNotEmpty) {
      try {
        final res = await http.get(
          Uri.parse(ApiConfig.cart),
          headers: await AuthService.authHeaders(),
        );
        if (res.statusCode == 200) {
          final data = json.decode(res.body);
          final items = data['items'];
          if (items is List) {
            selectedPackages = items.map((e) => Map<String, String>.from(Map.from(e).map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')))).toList();
            cartCount = selectedPackages.length;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('selectedPackages', json.encode(selectedPackages));
            notifyListeners();
            return;
          }
        }
      } catch (e) {
        print('Cart API load error: $e');
      }
    }
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('selectedPackages');
    if (data != null) {
      try {
        final decoded = json.decode(data);
        if (decoded is List) {
          selectedPackages = decoded.map((item) => Map<String, String>.from(Map.from(item).map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')))).toList();
          cartCount = selectedPackages.length;
          notifyListeners();
        }
      } catch (_) {}
    }
  }

  //  Add package and update cart icon
  void addPackage(BuildContext context, String title, String price) async {
    // Load existing cart data before adding new package
    await loadCartData();

    print("Before Adding: $selectedPackages");

    bool exists = selectedPackages.any(
            (pkg) => pkg['title']!.toLowerCase() == title.toLowerCase());

    if (!exists) {
      selectedPackages.add({'title': title, 'price': price});

      // Update cartCount after adding the package
      cartCount = selectedPackages.length;

      print("After Adding: $selectedPackages");

      // Save updated data to SharedPreferences
      await _saveCartData();
      notifyListeners(); //  Notify listeners to update UI

      ToastMessage().toastMessage("$title added to cart.");
    } else {
      ToastMessage().toastMessage("$title is already in cart!");
    }
  }

  //  Remove package from cart by index
  void removePackage(int index) async {
    if (index >= 0 && index < selectedPackages.length) {
      String removedTitle = selectedPackages[index]['title'] ?? 'Item';
      selectedPackages.removeAt(index);

      // Update cartCount after removing
      cartCount = selectedPackages.length;

      // Save updated data to SharedPreferences
      await _saveCartData();
      notifyListeners(); //  Notify listeners to update UI

      ToastMessage().toastMessage("$removedTitle removed from cart");
      print("After Removing: $selectedPackages");
    }
  }

  //  Remove package by title
  void removePackageByTitle(String title) async {
    int initialLength = selectedPackages.length;
    selectedPackages.removeWhere(
            (pkg) => pkg['title']!.toLowerCase() == title.toLowerCase());

    if (selectedPackages.length < initialLength) {
      // Update cartCount after removing
      cartCount = selectedPackages.length;

      // Save updated data to SharedPreferences
      await _saveCartData();
      notifyListeners(); //  Notify listeners to update UI

      ToastMessage().toastMessage("$title removed from cart");
      print("After Removing: $selectedPackages");
    }
  }

  //  Clear cart
  void clearCart() async {
    selectedPackages.clear();
    cartCount = 0;
    await _saveCartData();
    notifyListeners(); //  Notify listeners to update UI
    ToastMessage().toastMessage("Cart cleared");
  }

  //  Get total price of all items in cart
  double getTotalPrice() {
    return selectedPackages.fold(
      0.0,
          (sum, item) => sum + double.parse(item['price'] ?? '0'),
    );
  }

  //  Get number of items in cart
  int getItemCount() {
    return selectedPackages.length;
  }

  //  Check if item exists in cart
  bool isInCart(String title) {
    return selectedPackages.any(
            (pkg) => pkg['title']!.toLowerCase() == title.toLowerCase());
  }
}