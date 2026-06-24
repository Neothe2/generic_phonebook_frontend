import 'package:flutter/material.dart';
import 'package:generic_phonebook_frontend/models/phonebook_entry.dart';
import 'package:generic_phonebook_frontend/repositories/phonebook_entry_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late PhonebookEntryRepository phonebookEntryRepository;

  List<PhonebookEntry> phonebookEntries = [];

  @override
  void initState() {
    super.initState();
    phonebookEntryRepository = PhonebookEntryRepository();
    getPhonebookEntries();
    for (var phonebookEntry in phonebookEntries) {
      print(phonebookEntry.name);
    }
  }

  void getPhonebookEntries() async {
    var entries = await phonebookEntryRepository.getAllPhonebookEntries();

    if (!context.mounted) return;

    setState(() async {
      phonebookEntries = entries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generic Phonebook App")),
      body: Center(
        child: Column(
          children: buildPhonebookEntryList(phonebookEntries),
        ),
      ),
    );
  }

  List<Widget> buildPhonebookEntryList(List<PhonebookEntry> phonebookEntries) {
    return phonebookEntries
            .map(
              (entry) => Row(
                children: [Text(entry.name)],
              ),
            )
            .toList()
        as List<Widget>;
  }
}
