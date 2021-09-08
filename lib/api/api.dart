import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/state/home/home.model.dart';

enum CallectionWhere { isEqualTo, arrayContains, arrayContainsIsEqualToTop }

class Api {
  var _collectionProducts = FirebaseFirestore.instance.collection('products');
  var _collectionCategories = FirebaseFirestore.instance.collection('cat');
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

  Future<Product> getProductById(String id) async {
    try {
      var request = await this._collectionProducts.doc(id).get();
      var map = request.data();
      map!["id"] = request.id;
      Product data = Product.fromJson(map);
      return data;
    } catch (e) {
      return throw (e.toString());
    }
  }

  Future<List<Product>> getProducts(
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
      return data;
    } catch (e) {
      log("products error: ${e.toString()} ${e.hashCode}");
      return throw (e.toString());
    }
  }

  Future<List<Category>> getCategoryes({int limit = 10}) async {
    try {
      var request = await this._collectionCategories.limit(limit).get();
      var docs = request.docs;
      List<Category> data = [];
      docs.forEach((element) {
        var doc = element.data();
        doc['id'] = element.id;
        data.add(Category.fromJson(doc));
      });
      return data;
    } catch (e) {
      log("cat error: ${e.toString()} ${e.hashCode}");
      return throw (e.toString());
    }
  }

  Future<Category> getCategoryById(String id) async {
    try {
      var request = await this._collectionCategories.doc(id).get();
      var map = request.data();
      map!["id"] = request.id;
      Category data = Category.fromJson(map);
      return data;
    } catch (e) {
      return throw (e.toString());
    }
  }

  Future<HomeReduserModelSetHome> getHome(
      {int limit = 10,
      String? field,
      CallectionWhere? where,
      dynamic value}) async {
    try {
      List<Product> products = await getProducts(
          limit: limit, where: where, field: field, value: value);
      //List<Category> cat = await getCategoryes();
      return HomeReduserModelSetHome(cat: [], products: products);
    } catch (e) {
      log("products error: ${e.toString()} ${e.hashCode}");
      return throw (e.toString());
    }
  }
}
