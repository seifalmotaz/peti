import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/request.dart';
import 'package:petiapp/providers/request.dart';

class RequestsInboxController extends GetxController {
  final String? petId;
  RequestsInboxController(this.petId);

  RxBool loading = true.obs;
  RequestProvider requestConnect = RequestProvider();

  RxList<Request> requests = <Request>[].obs;

  getNewRequests() async {
    loading.value = true;
    Response res = await requestConnect.newRequests(petId);
    if (res.statusCode == 200) {
      requests.clear();
      for (var item in res.data) {
        requests.add(Request.fromMap(item));
      }
    }
    loading.value = false;
  }

  getMyRequests() async {
    loading.value = true;
    Response res = await requestConnect.myRequests(petId);
    if (res.statusCode == 200) {
      requests.clear();
      for (var item in res.data) {
        requests.add(Request.fromMap(item));
      }
    }
    loading.value = false;
  }

  getAcceptedRequests() async {
    loading.value = true;
    Response res = await requestConnect.acceptedRequests(petId);
    if (res.statusCode == 200) {
      requests.clear();
      for (var item in res.data) {
        requests.add(Request.fromMap(item));
      }
    }
    loading.value = false;
  }

  getRefusedRequests() async {
    loading.value = true;
    Response res = await requestConnect.refusedRequests(petId);
    if (res.statusCode == 200) {
      requests.clear();
      for (var item in res.data) {
        requests.add(Request.fromMap(item));
      }
    }
    loading.value = false;
  }

  getCompletedRequests() async {
    loading.value = true;
    Response res = await requestConnect.completedRequests(petId);
    if (res.statusCode == 200) {
      requests.clear();
      for (var item in res.data) {
        requests.add(Request.fromMap(item));
      }
    }
    loading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getNewRequests();
  }
}
