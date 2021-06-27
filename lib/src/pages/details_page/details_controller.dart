import 'package:wordse_app/src/store/store_controller.dart';

class DetailsController {

  StoreController _storeController = StoreController();

  Future delete(int id) async {
    var x = await _storeController.delete(id);
    if(x == 1){
      await get();
    }
    return x;
  }

  Future get() async {
    await _storeController.get();
  }

}