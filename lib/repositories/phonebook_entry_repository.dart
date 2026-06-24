import 'package:generic_phonebook_frontend/models/phonebook_entry.dart';
import 'package:generic_phonebook_frontend/repositories/http_service.dart';

class PhonebookEntryRepository {
  late HttpService http;

  PhonebookEntryRepository() {
    http = HttpService();
  }

  Future<List<PhonebookEntry>> getAllPhonebookEntries() async {
    List<Map<String, dynamic>> response = await http.get("api/PhonebookEntry");
    var phonebookEntries = response
        .map((entry) => PhonebookEntry.fromJson(entry))
        .toList();
    return phonebookEntries;
  }

  Future<PhonebookEntry?> getPhonebookEntry(int id) async {
    var response = await http.get("api/PhonebookEntry/$id");
    if (response == null) {
      return null;
    }
    var phonebookEntry = PhonebookEntry.fromJson(response);
    return phonebookEntry;
  }

  void addPhonebookEntry(PhonebookEntry phonebookEntry) async {
    await http.post("api/PhonebookEntry", phonebookEntry.toJson());
  }

  void updatePhonebookEntry(PhonebookEntry phonebookEntry) async {
    await http.put(
      "api/PhonebookEntry/${phonebookEntry.id}",
      phonebookEntry.toJson(),
    );
  }

  void deletePhonebookEntry(PhonebookEntry phonebookEntry) async {
    await http.delete("api/PhonebookEntry/${phonebookEntry.id}");
  }
}
