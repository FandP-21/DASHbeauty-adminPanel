import 'dart:async';

import 'package:admin/models/AdminDashboardResponse.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/networking/repository/Repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboardBloc {
  AdminRepository _adminRepository;
  StreamController _adminDashboardBlocController;

  StreamSink<Response<AdminDashBoardResponse>> get adminDashboardDataSink =>
      _adminDashboardBlocController.sink;

  Stream<Response<AdminDashBoardResponse>> get adminDashboardStream =>
      _adminDashboardBlocController.stream;

  AdminDashboardBloc() {
    _adminDashboardBlocController = StreamController<Response<AdminDashBoardResponse>>();
    _adminRepository = AdminRepository();
  }


  adminDashboard() async {
    adminDashboardDataSink.add(Response.loading('get dashboard data'));
    try {
      AdminDashBoardResponse loginData =
      await _adminRepository.adminDashboard();
      print(loginData);

      adminDashboardDataSink.add(Response.completed(loginData));
    } catch (e) {
      adminDashboardDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _adminDashboardBlocController.close();
  }

}