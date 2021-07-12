import 'dart:async';

import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/CommonRequest.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/networking/repository/Repositories.dart';

class AddressBloc{
  AddressRepository _addressRepository;

  //get all address
  StreamController _addressBlocController;
  StreamSink<Response<AllUserResponseModel>> get addressDataSink =>
      _addressBlocController.sink;
  Stream<Response<AllUserResponseModel>> get addressStream =>
      _addressBlocController.stream;


  //create address
  StreamController _createAddressController;
  StreamSink<Response<UserResponseModel>> get createAddressDataSink =>
      _createAddressController.sink;
  Stream<Response<UserResponseModel>> get createAddressStream =>
      _createAddressController.stream;

  //delete address
  StreamController _deleteAddressController;
  StreamSink<Response<UserResponseModel>> get deleteAddressSink =>
      _deleteAddressController.sink;
  Stream<Response<UserResponseModel>> get deleteAddressStream =>
      _deleteAddressController.stream;

  //update Address
  StreamController _updateAddressController;
  StreamSink<Response<UserResponseModel>> get updateAddressDataSink =>
      _updateAddressController.sink;
  Stream<Response<UserResponseModel>> get updateAddressStream =>
      _updateAddressController.stream;

  AddressBloc() {
    _addressBlocController = StreamController<Response<AllUserResponseModel>>();
    _createAddressController = StreamController<Response<UserResponseModel>>();
    _deleteAddressController = StreamController<Response<UserResponseModel>>();
    _updateAddressController = StreamController<Response<UserResponseModel>>();

    _addressRepository = AddressRepository();
  }


  getAddress(CommonRequest userRequest) async {
    addressDataSink.add(Response.loading('get address'));
    try {
      AllUserResponseModel ordersResponseData =
      await _addressRepository.getAddressByUser(userRequest);
      print(ordersResponseData);

      addressDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      addressDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }


  createAddress(AddressRequest addressRequest) async {

    createAddressDataSink.add(Response.loading('create address'));
    try {
      UserResponseModel ordersResponseData =
      await _addressRepository.createAddressByUser(addressRequest);
      print(ordersResponseData);

      createAddressDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      createAddressDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }


  deleteAddress(String addressId) async {

    deleteAddressSink.add(Response.loading('delete address'));
    try {
      UserResponseModel ordersResponseData =
      await _addressRepository.deleteAddressByUser(addressId);
      print(ordersResponseData);

      deleteAddressSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      deleteAddressSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  updateAddress(String addressId, AddressRequest updateAddress) async {

    updateAddressDataSink.add(Response.loading('Update Address'));
    try {
      UserResponseModel userResponseData =
      await _addressRepository.updateAddressByUser(addressId, updateAddress);
      print(userResponseData);

      updateAddressDataSink.add(Response.completed(userResponseData));
    } catch (e) {
      updateAddressDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }


  getAddressByAddressId(String addressId) async {

    updateAddressDataSink.add(Response.loading('get Address'));
    try {
      UserResponseModel userResponseData =
      await _addressRepository.getAddressByUserWithAddressId(addressId);
      print(userResponseData);

      updateAddressDataSink.add(Response.completed(userResponseData));
    } catch (e) {
      updateAddressDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _addressBlocController.close();
    _createAddressController.close();
    _deleteAddressController.close();
    _updateAddressController.close();
  }

}