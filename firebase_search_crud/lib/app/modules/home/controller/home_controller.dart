import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constant/constant.dart';
import '../../../../utils/fire_store_utils.dart';
import '../../../models/addDataModel.dart';


class HomeController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> surnameController = TextEditingController().obs;
  Rx<bool> isAdd = false.obs;
  Rx<bool> isEdit = false.obs;
  Rx<bool> isLoading = false.obs;

  Rx<AddDataModel> addDataModel = AddDataModel().obs;
  RxList<AddDataModel> modelDataList = <AddDataModel>[].obs;
  RxList<AddDataModel> allData = <AddDataModel>[].obs;


  final Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString searchText = ''.obs;


  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    modelDataList.clear();
    List<AddDataModel> dataList = await FireStoreUtils.getDataList();
    modelDataList.addAll(dataList);
    allData.assignAll(dataList);
    isLoading.value = false;
  }


  getArgument(AddDataModel addDataModels) {
    addDataModel.value = AddDataModel(id: addDataModels.id, name: addDataModels.name, surName: addDataModels.surName);

    nameController.value.text = addDataModels.name ?? '';
    surnameController.value.text = addDataModels.surName ?? '';
  }

  addData() async {
    isAdd.value = true;
    addDataModel.value.id = Constant.getUuid();
    addDataModel.value.name = nameController.value.text;
    addDataModel.value.surName = surnameController.value.text;
    await FireStoreUtils.addDocument(addDataModel.value);
    isAdd.value = false;
    getData();
    Get.back();
  }

  void filterSearchResults(String query) async {
    isLoading.value = true;
    searchText.value = query;

    if (query.isEmpty) {
      modelDataList.assignAll(allData);
      isLoading.value = false;
    } else {
      List<AddDataModel> searchResults = await FireStoreUtils.searchByName(query);
      modelDataList.assignAll(searchResults);
      isLoading.value = false;
    }
  }


  updateData() async {
    isAdd.value = true;
    // addDataModel.value.id = Constant.getUuid();
    addDataModel.value.name = nameController.value.text;
    addDataModel.value.surName = surnameController.value.text;
    await FireStoreUtils.addUpdateDocument(addDataModel.value);
    isAdd.value = false;
    getData();
    Get.back();
  }

  // void filterSearchResults(String query) {
  //   searchText.value = query;
  //   if (query.isEmpty) {
  //     modelDataList.assignAll(allData);
  //   } else {
  //     modelDataList.assignAll(allData.where(
  //           (item) =>
  //       (item.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
  //           (item.surName?.toLowerCase().contains(query.toLowerCase()) ?? false),
  //     ));
  //   }
  // }



  deleteData(String docId) async {
    isLoading.value = true;
    await FireStoreUtils.deleteDocument(docId);
    modelDataList.removeWhere((element) => element.id == docId);
    isLoading.value = false;
  }
}
