import 'package:get/get.dart';
import 'package:talktsy/screens/faq/faq_screen.dart';

class FaqController extends GetxController {
  var data = <Item>[].obs;

  @override
  void onInit() {
    super.onInit();
    List<Item> list = [];
    list.add(Item(
      headerValue: 'What is Talktsy?',
      expandedValue:
      'At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.\n\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com',
    ));
    list.add(Item(
      headerValue: 'Can I order a free copy of a magazine to sample?',
      expandedValue:
      'At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.\n\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com',
    ));
    list.add(Item(
      headerValue: 'Where can I subscribe to your newsletter?',
      expandedValue:
      'At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.\n\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com',
    ));
    list.add(Item(
      headerValue: 'Where can in edit my address?',
      expandedValue:
      'At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.\n\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com',
    ));
    list.add(Item(
      headerValue: 'Can I reserve a magazine via Phone or E-mail?',
      expandedValue:
      'At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.\n\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com',
    ));
    list.add(Item(
      headerValue: 'Where on your website can I open a customer account?',
      expandedValue:
      'At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.\n\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com',
    ));
    data.value = list;
  }

  void toggleExpand(int index) {
    data[index].isExpanded = !data[index].isExpanded;
    data.refresh();
  }

  void removeItem(int index) {
    data.removeAt(index);
  }
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
