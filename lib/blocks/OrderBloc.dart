import 'dart:async';

import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/networking/repository/Repositories.dart';

class OrderBloc {
  OrderRepository _orderRepository;

  //get all order by user id
  StreamController _orederBlocController;

  StreamSink<Response<AllUserResponseModel>> get orderDataSink =>
      _orederBlocController.sink;

  Stream<Response<AllUserResponseModel>> get orderStream =>
      _orederBlocController.stream;


  //get all orders for listing in order screen
  StreamController _allOrederBlocController;

  StreamSink<Response<AllUserResponseModel>> get allOrderDataSink =>
      _allOrederBlocController.sink;

  Stream<Response<AllUserResponseModel>> get allOrderStream =>
      _allOrederBlocController.stream;


  OrderBloc() {
    _orederBlocController = StreamController<Response<AllUserResponseModel>>();
    _allOrederBlocController = StreamController<Response<AllUserResponseModel>>();

    _orderRepository = OrderRepository();
  }

  getOrderByUsersId(String userId, String limit,String page_no) async {
    orderDataSink.add(Response.loading('get order by users id'));
    try {
      AllUserResponseModel ordersResponseData =
          await _orderRepository.getAllOrderByUserId(userId, limit, page_no);
      print(ordersResponseData);

      orderDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      orderDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }


  getAllOrders(UserRequest request) async {
    allOrderDataSink.add(Response.loading('get order by users id'));
    try {
      AllUserResponseModel ordersResponseData =
          await _orderRepository.getAllOrders(request);
      print(ordersResponseData);

      orderDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      orderDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }
}
