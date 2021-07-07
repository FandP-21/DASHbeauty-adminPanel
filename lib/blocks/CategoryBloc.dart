import 'dart:async';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/BasicResponseModel.dart';
import 'package:admin/models/CategoryResponseModel.dart';
import 'package:admin/models/ProductsResponseModel.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/networking/repository/Repositories.dart';

class CategoryBloc {
  CategoryRepository _categoryRepository;

  //get all Category
  StreamController _categoryBlocController;
  StreamSink<Response<CategoryResponseModel>> get categoryDataSink =>
      _categoryBlocController.sink;
  Stream<Response<CategoryResponseModel>> get categoryStream =>
      _categoryBlocController.stream;


  //create Category
  StreamController _categoryCreateController;
  StreamSink<Response<CategoryResponseModel>> get createCategoryDataSink =>
      _categoryCreateController.sink;
  Stream<Response<CategoryResponseModel>> get createCategoryStream =>
      _categoryCreateController.stream;

  //delete Category
  StreamController _deleteCategoryController;
  StreamSink<Response<CategoryResponseModel>> get deleteCategoryDataSink =>
      _deleteCategoryController.sink;
  Stream<Response<CategoryResponseModel>> get deleteCategoryStream =>
      _deleteCategoryController.stream;


  //update Category
  StreamController _updateCategoryController;
  StreamSink<Response<CategoryResponseModel>> get updateCategoryDataSink =>
      _updateCategoryController.sink;
  Stream<Response<CategoryResponseModel>> get updateCategoryStream =>
      _updateCategoryController.stream;


  CategoryBloc() {
    _categoryBlocController = StreamController<Response<CategoryResponseModel>>();
    _categoryCreateController = StreamController<Response<CategoryResponseModel>>();
    _deleteCategoryController = StreamController<Response<CategoryResponseModel>>();
    _updateCategoryController = StreamController<Response<CategoryResponseModel>>();
    _categoryRepository = CategoryRepository();
  }

  //to get all Category with pagination and search filter
  getCategory([UserRequest userRequest]) async {
    categoryDataSink.add(Response.loading('get categories'));
    try {
      CategoryResponseModel ordersResponseData =
      await _categoryRepository.getAllCategory(userRequest);
      print(ordersResponseData);

      categoryDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      categoryDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  //to create new Category
  createCategory(CategoryRequest createProductRequest) async {

    createCategoryDataSink.add(Response.loading('create user'));
    try {
      CategoryResponseModel ordersResponseData =
      await _categoryRepository.createCategory(createProductRequest);
      print(ordersResponseData);

      createCategoryDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      createCategoryDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }


  //to delete Category
  deleteCategory(String categoryId) async {

    deleteCategoryDataSink.add(Response.loading('delete category'));
    try {
      CategoryResponseModel ordersResponseData =
      await _categoryRepository.deleteCategory(categoryId);
      print(ordersResponseData);

      deleteCategoryDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      deleteCategoryDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }


  //to update Category
  updateCategory(String caregoryId, CategoryRequest updateProductRequest) async {

    updateCategoryDataSink.add(Response.loading('Update category'));
    // try {
    //   CategoryResponseModel ordersResponseData =
    //   await _categoryRepository.updateCategory(caregoryId, updateProductRequest);
    //   print(ordersResponseData);
    //
    //   updateCategoryDataSink.add(Response.completed(ordersResponseData));
    // } catch (e) {
    //   updateCategoryDataSink.add(Response.error(e.toString()));
    //   print(e);
    // }
    // return null;
  }


  dispose() {
    _categoryCreateController.close();
    _categoryBlocController.close();
    _deleteCategoryController.close();
    _updateCategoryController.close();
  }
}
