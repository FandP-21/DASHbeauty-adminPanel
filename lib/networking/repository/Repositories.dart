import 'dart:convert';

import 'package:admin/models/AdminDashboardResponse.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/BasicResponseModel.dart';
import 'package:admin/models/CategoryResponseModel.dart';
import 'package:admin/models/CommonRequest.dart';
import 'package:admin/models/LoginResponseModel.dart';
import 'package:admin/constants.dart' as Constants;
import 'package:admin/models/ProductsResponseModel.dart';
import 'package:admin/models/UserResponseModel.dart';
import '../ApiProvider.dart';

class AdminRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<AdminDashBoardResponse> adminDashboard() async {
    final response =
    await _apiProvider.get(Constants.ADMIN_DASHBOARD);
    return AdminDashBoardResponse.fromJson(response);
  }
}

class LoginRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<LoginResponseModel> loginAdmin(LoginRequest loginRequest) async {
    final response =
        await _apiProvider.post(Constants.SING_IN, jsonEncode(loginRequest));
    return LoginResponseModel.fromJson(response);
  }
}

class UserRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getAllUser(UserRequest userRequest) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ALL_USER}?limit=${userRequest.limit}&"
        "page_no=${userRequest.page_no}&userRole=${userRequest.userRole}&search=${userRequest.search}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> createUser(CreateUserRequest userRequest) async {
    final response = await _apiProvider.postWithToken(
        Constants.CREATE_USER, jsonEncode(userRequest));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> deleteUser(String userId) async {
    final response =
        await _apiProvider.delete(Constants.DELETE_USER_BY_ID + userId);
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> activeDeactiveUser(
      String userId, bool isActive) async {
    final response = await _apiProvider.patch(
        Constants.ACTIVE_DEACTIVE_USER + userId,
        body: {"status": isActive});
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> updateUser(
      String id, UpdateUserRequest updateUserRequest) async {
    final response = await _apiProvider
        .put(Constants.UPDATE_USER + id, body: updateUserRequest);
    return UserResponseModel.fromJson(response);
  }
}

class CategoryRepository {
  ApiProvider _apiProvider = ApiProvider();

  //get all category
  Future<CategoryResponseModel> getAllCategory(UserRequest userRequest) async {
    final response = await _apiProvider
        .get("${Constants.GET_ALL_CATEGORY}?limit=${userRequest.limit}&"
            "page_no=${userRequest.page_no}&search=${userRequest.search}");
    return CategoryResponseModel.fromJson(response);
  }

  //pending - create category
  Future<CategoryResponseModel> createCategory(
      CategoryRequest userRequest) async {
    final response = await _apiProvider.post(
        Constants.CREATE_CATEGORY, jsonEncode(userRequest));
    return CategoryResponseModel.fromJson(response);
  }

  //delete category
  Future<CategoryResponseModel> deleteCategory(String id) async {
    final response = await _apiProvider.delete(Constants.DELETE_CATEGORY + id);
    return CategoryResponseModel.fromJson(response);
  }

  //pending - update category (pending for multipart image logic)
  Future<CategoryResponseModel> updateCategory(String id, bool isActive) async {
    final response = await _apiProvider
        .put(Constants.UPDATE_CATEGORY + id, body: {"status": isActive});
    return CategoryResponseModel.fromJson(response);
  }
}

class ProductRepository {
  ApiProvider _apiProvider = ApiProvider();

  //get all Product
  Future<ProductsResponseModel> getAllProduct(UserRequest userRequest) async {
    final response = await _apiProvider
        .get("${Constants.GET_ALL_PRODUCTS}?limit=${userRequest.limit}&"
            "page_no=${userRequest.page_no}&search=${userRequest.search}");
    return ProductsResponseModel.fromJson(response);
  }

  //create Product
  Future<ProductResponseModel> createProduct(
      CreateProductRequest createProductRequest) async {
    final response = await _apiProvider.postWithToken(
        Constants.CREATE_PRODUCTS, jsonEncode(createProductRequest));
    return ProductResponseModel.fromJson(response);
  }

  //delete Product
  Future<BasicResponseModel> deleteProduct(String id) async {
    final response = await _apiProvider.delete(Constants.DELETE_PRODUCTS + id);
    return BasicResponseModel.fromJson(response);
  }

  //update Product
  Future<ProductResponseModel> updateProduct(
      String id, CreateProductRequest createProductRequest) async {
    final response = await _apiProvider.put(Constants.UPDATE_PRODUCTS + id,
        body: createProductRequest);
    return ProductResponseModel.fromJson(response);
  }
}

class OrderRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getAllOrderByUserId(String userId, String limit,String page_no) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ORDER_BY_UESR}$userId?limit=$limit&"
            "page_no=$page_no}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<AllUserResponseModel> getAllOrders(UserRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ORDERS}?limit=${request.limit}&page_no=${request.page_no}}");
    return AllUserResponseModel.fromJson(response);
  }

}

class FavouriteRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getFavouriteByUser(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_FAVOURITE}?limit=${request.limit}&page_no=${request.page_no}&search=${request.search}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> addToFavourite(String productId) async {
    final response = await _apiProvider.postWithToken(
        Constants.GET_FAVOURITE, jsonEncode(productId));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> removeFromFavourite(String productId) async {
    final response = await _apiProvider.delete("${Constants.GET_FAVOURITE}/$productId");
    return UserResponseModel.fromJson(response);
  }

}

class AddressRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getAddressByUser(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ADDRESS}?limit=${request.limit}&page_no=${request.page_no}&search=${request.search}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> createAddressByUser(AddressRequest addressRequest) async {
    final response = await _apiProvider.postWithToken(
        Constants.GET_ADDRESS, jsonEncode(addressRequest));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> updateAddressByUser(String addressId, AddressRequest addressRequest) async {
    final response = await _apiProvider.put("${Constants.GET_ADDRESS}/$addressId", body: jsonEncode(addressRequest));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> deleteAddressByUser(String addressId) async {
    final response = await _apiProvider.delete("${Constants.GET_ADDRESS}/$addressId");
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> getAddressByUserWithAddressId(String addressId) async {
    final response = await _apiProvider.get("${Constants.GET_ADDRESS}/$addressId");
    return UserResponseModel.fromJson(response);
  }
}

class CartRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getCart(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.ADMIN_CART}?limit=${request.limit}&page_no=${request.page_no}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> addToCart(CartRequest request) async {
    final response = await _apiProvider.postWithToken(
        Constants.ADMIN_CART, jsonEncode(request));
    return UserResponseModel.fromJson(response);
  }


  Future<UserResponseModel> updateCart(String id, CartRequest request) async {
    final response = await _apiProvider.put("${Constants.ADMIN_CART}/$id", body: jsonEncode(request));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> deleteCart(String userId) async {
    final response = await _apiProvider.delete("${Constants.ADMIN_CART}/$userId");
    return UserResponseModel.fromJson(response);
  }

}


class PromoCodeRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getPromoCodes(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_PROMO}?limit=${request.limit}&page_no=${request.page_no}&search=${request.search}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> createPromoCode(PromoRequest request) async {
    final response = await _apiProvider.postWithToken(
        Constants.GET_PROMO, jsonEncode(request));
    return UserResponseModel.fromJson(response);
  }


  Future<UserResponseModel> updatePromoCode(String id, PromoRequest request) async {
    final response = await _apiProvider.put("${Constants.GET_PROMO}/$id", body: jsonEncode(request));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> deletePromo(String id) async {
    final response = await _apiProvider.delete("${Constants.GET_PROMO}/$id");
    return UserResponseModel.fromJson(response);
  }

}