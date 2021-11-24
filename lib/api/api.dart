import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_time/env.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/model/order.model.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/home/home.model.dart';

enum CallectionWhere { isEqualTo, arrayContains, arrayContainsIsEqualToTop }

class ApiData<T> {
  final T data;
  final String error;
  final int hashCode;

  ApiData({required this.data, required this.error, required this.hashCode});

  @override
  bool operator ==(Object other) {
    return super == other;
  }
}

class Api {
  var _collectionProducts = FirebaseFirestore.instance.collection('products');
  var _collectionCategories = FirebaseFirestore.instance.collection('cat');
  var _collectionOrders = FirebaseFirestore.instance.collection('orders');
  var _collectionUsers = FirebaseFirestore.instance.collection('users');

  var _auth = FirebaseAuth.instance;
  _apiWhere(CollectionReference<Map<String, dynamic>> collection, String field,
      CallectionWhere type, dynamic value,
      {int limit = 10}) async {
    switch (type) {
      case CallectionWhere.isEqualTo:
        return collection.limit(limit).where(field, isEqualTo: value).get();
      case CallectionWhere.arrayContains:
        return collection.limit(limit).where(field, arrayContains: value).get();
      case CallectionWhere.arrayContainsIsEqualToTop:
        return collection
            .limit(limit)
            .where(field, arrayContains: value)
            .where("isTop", isEqualTo: true)
            .get();
      default:
        return collection.limit(limit).get();
    }
  }

  Future<ApiData<bool?>> createUserWithEmailAndPassword({
    required String password,
    required String email,
    required String name,
    required String address,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _collectionUsers.add({
        "name": name,
        "email": email,
        "address": address,
        "preview": '',
        "orders": [],
        "phone": phone,
        "userID": userCredential.user?.uid,
      });

      return ApiData<bool?>(
          data: true, error: "", hashCode: userCredential.hashCode);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ApiData(
            data: null,
            error: "The password provided is too weak.",
            hashCode: e.hashCode);
      } else if (e.code == 'email-already-in-use') {
        return ApiData(
            data: null,
            error: "The account already exists for that email.",
            hashCode: e.hashCode);
      }
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<Product?>> getProductById(String id) async {
    try {
      var request = await this._collectionProducts.doc(id).get();
      var map = request.data();
      map!["id"] = request.id;
      Product data = Product.fromJson(map);
      return ApiData<Product>(data: data, error: "", hashCode: data.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<UserCustom?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      //TODO add get user in table users

      return ApiData<UserCustom>(
          data: UserCustom(
              address: "",
              email: user.email ?? "",
              name: "",
              preview: "",
              id: user.uid),
          error: "",
          hashCode: user.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<Category>>> getCategories({int limit = 10}) async {
    try {
      var request = await this._collectionCategories.limit(limit).get();
      var docs = request.docs;
      List<Category> data = [];
      docs.forEach((element) {
        var doc = element.data();
        doc['id'] = element.id;
        data.add(Category.fromJson(doc));
      });
      return ApiData<List<Category>>(
          data: data, error: "", hashCode: data.hashCode);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<Category?>> getCategoryById(String id) async {
    try {
      var request = await this._collectionCategories.doc(id).get();
      var map = request.data();
      map!["id"] = request.id;
      Category data = Category.fromJson(map);
      return ApiData<Category>(data: data, error: "", hashCode: data.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<HomeReduserModelSetHome?>> getHome(
      {int limit = 10,
      String? field,
      CallectionWhere? where,
      dynamic value}) async {
    try {
      ApiData<List<Product>> products = await getProductsRequest(
          limit: limit, where: where, field: field, value: value);
      ApiData<List<Category>> cat = await getCategories();
      return ApiData<HomeReduserModelSetHome>(
          data: HomeReduserModelSetHome(cat: cat.data, products: products.data),
          error: "",
          hashCode: products.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<Product>>> getProductsRequest(
      {int limit = 10,
      String? field,
      CallectionWhere? where,
      dynamic value}) async {
    try {
      var request;
      if (field != null && where != null && value != null) {
        request = await this
            ._apiWhere(_collectionProducts, field, where, value, limit: limit);
      } else {
        request = await this._collectionProducts.limit(limit).get();
      }

      var docs = request.docs;
      List<Product> data = [];
      docs.forEach((element) {
        var doc = element.data();
        doc['id'] = element.id;
        data.add(Product.fromJson(doc));
      });
      return ApiData<List<Product>>(
          data: data, error: "", hashCode: data.hashCode);
    } catch (e) {
      log("products error: ${e.toString()} ${e.hashCode}");
      return ApiData<List<Product>>(
          data: [], error: e.toString(), hashCode: e.hashCode);
    }
  }

  Future<ApiData<bool?>> createOrder(OrderModel data) async {
    try {
      List<Map<String, dynamic>> cartJson =
          data.products.map((e) => (e.toJson())).toList();

      var rez = _collectionOrders.add({
        "key": data.key ?? Env.orderKey,
        "name": data.name,
        "email": data.email,
        "date": DateTime.parse(data.date),
        "comments": data.comments,
        "address": data.address,
        "products": cartJson,
        "userID": data.userID ?? 'not_register_user',
      });
      return ApiData<bool>(data: true, error: "", hashCode: rez.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }
}
