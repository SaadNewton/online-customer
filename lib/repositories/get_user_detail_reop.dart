import 'dart:developer';


import 'package:doctoworld_user/Models/user_detail_model.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';

 getUserDetailRepo() async{
  log('user detail ' + storageBox!.read('user_detail').toString());
  userDetailModel = UserDetailModel.fromJson(storageBox!.read('user_detail'));
  storageBox!.write('customerId', userDetailModel.data.id);

}

