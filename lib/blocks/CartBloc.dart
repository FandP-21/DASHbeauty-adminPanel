import 'dart:async';

import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/CommonRequest.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/networking/repository/Repositories.dart';

class CartBloc{
  CartRepository _cartRepository;

  //get cart data
  StreamController _cartBlocController;
  StreamSink<Response<AllUserResponseModel>> get cartDataSink =>
      _cartBlocController.sink;
  Stream<Response<AllUserResponseModel>> get cartStream =>
      _cartBlocController.stream;


  //add to cart
  StreamController _cartCreateController;
  StreamSink<Response<UserResponseModel>> get addCartDataSink =>
      _cartCreateController.sink;
  Stream<Response<UserResponseModel>> get addCartStream =>
      _cartCreateController.stream;


  //delete cart
  StreamController _deleteCartController;
  StreamSink<Response<UserResponseModel>> get deleteCartSink =>
      _deleteCartController.sink;
  Stream<Response<UserResponseModel>> get deleteCartStream =>
      _deleteCartController.stream;

  //update user
  StreamController _updateCartController;
  StreamSink<Response<UserResponseModel>> get updateCartDataSink =>
      _updateCartController.sink;
  Stream<Response<UserResponseModel>> get updateCartStream =>
      _updateCartController.stream;

  CartBloc() {
    _cartBlocController = StreamController<Response<AllUserResponseModel>>();
    _cartCreateController = StreamController<Response<UserResponseModel>>();
    _deleteCartController = StreamController<Response<UserResponseModel>>();
    _updateCartController = StreamController<Response<UserResponseModel>>();

    _cartRepository = CartRepository();
  }

  getCart(CommonRequest commonRequest) async {
    cartDataSink.add(Response.loading('get cart'));
    try {
      AllUserResponseModel ordersResponseData =
      await _cartRepository.getCart(commonRequest);
      print(ordersResponseData);

      cartDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      cartDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  addToCart(CartRequest request) async {

    addCartDataSink.add(Response.loading('add to cart'));
    try {
      UserResponseModel ordersResponseData =
      await _cartRepository.addToCart(request);
      print(ordersResponseData);

      addCartDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      addCartDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  deleteCart(String userId) async {

    deleteCartSink.add(Response.loading('delete cart'));
    try {
      UserResponseModel ordersResponseData =
      await _cartRepository.deleteCart(userId);
      print(ordersResponseData);

      deleteCartSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      deleteCartSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  //to update cart
  updateUser(String id, CartRequest request) async {

    updateCartDataSink.add(Response.loading('Update Product'));
    try {
      UserResponseModel userResponseData =
      await _cartRepository.updateCart(id, request);
      print(userResponseData);

      updateCartDataSink.add(Response.completed(userResponseData));
    } catch (e) {
      updateCartDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _cartBlocController.close();
    _cartCreateController.close();
    _deleteCartController.close();
    _updateCartController.close();
  }
}