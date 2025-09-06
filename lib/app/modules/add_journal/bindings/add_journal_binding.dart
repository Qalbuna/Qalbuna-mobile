import 'package:get/get.dart';
import '../controllers/add_journal_controller.dart';

class AddJournalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddJournalController>(
      () => AddJournalController(),
    );
  }
}
