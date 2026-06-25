import 'package:generic_phonebook_frontend/models/phonebook_entry_draft.dart';

class PhonebookEntry {
  int id;
  String name;
  String phoneNumber;
  String address;

  PhonebookEntry({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  factory PhonebookEntry.fromJson(Map<String, dynamic> json) {
    return PhonebookEntry(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adress': address,
      'phoneNumber': phoneNumber,
    };
  }

  void update(PhonebookEntryDraft draft) {
    name = draft.name;
    phoneNumber = draft.phoneNumber;
    address = draft.address;
  }

  PhonebookEntryDraft toDraft() {
    return PhonebookEntryDraft(
      name: name,
      phoneNumber: phoneNumber,
      address: address,
    );
  }
}
