import 'dart:async';

import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/CommonRequest.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/networking/repository/Repositories.dart';

class FavouriteBloc{
  FavouriteRepository _favouriteRepository;

  //get favourite by user
  StreamController _getFavBlocController;
  StreamSink<Response<AllUserResponseModel>> get getFavDataSink =>
      _getFavBlocController.sink;
  Stream<Response<AllUserResponseModel>> get getFavStream =>
      _getFavBlocController.stream;

  //create user
  StreamController _favCreateController;
  StreamSink<Response<UserResponseModel>> get addFavDataSink =>
      _favCreateController.sink;
  Stream<Response<UserResponseModel>> get addFavStream =>
      _favCreateController.stream;

  //delete user
  StreamController _removeFavController;
  StreamSink<Response<UserResponseModel>> get removeFavDataSink =>
      _removeFavController.sink;
  Stream<Response<UserResponseModel>> get removeFavStream =>
      _removeFavController.stream;

  FavouriteBloc() {
    _getFavBlocController = StreamController<Response<AllUserResponseModel>>();
    _favCreateController = StreamController<Response<UserResponseModel>>();
    _removeFavController = StreamController<Response<UserResponseModel>>();

    _favouriteRepository = FavouriteRepository();
  }

  getFavourite(CommonRequest commonRequest) async {

    getFavDataSink.add(Response.loading('get users'));
    try {
      AllUserResponseModel ordersResponseData =
      await _favouriteRepository.getFavouriteByUser(commonRequest);
      print(ordersResponseData);

      getFavDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      getFavDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  addToFavourite(String productId) async {

    addFavDataSink.add(Response.loading('add to favourite'));
    try {
      UserResponseModel ordersResponseData =
      await _favouriteRepository.addToFavourite(productId);
      print(ordersResponseData);

      addFavDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      addFavDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  removeFromFavourite(String userId) async {

    removeFavDataSink.add(Response.loading('remove from favourite'));
    try {
      UserResponseModel ordersResponseData =
      await _favouriteRepository.removeFromFavourite(userId);
      print(ordersResponseData);

      removeFavDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      removeFavDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _getFavBlocController.close();
    _favCreateController.close();
    _removeFavController.close();
  }
}