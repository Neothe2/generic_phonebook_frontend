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

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phonebookEntryRepository = PhonebookEntryRepository();
    getPhonebookEntries().then(
      (List<PhonebookEntry> entries) => {
        setState(() {
          phonebookEntries = entries;
        }),
      },
    );
    for (var phonebookEntry in phonebookEntries) {
      print(phonebookEntry.name);
    }
  }

  Future<bool> showCancelModal() async {
    var response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cancel?"),
          content: Text(
            "Are you sure you want to cancel? You'll lose the data that you entered.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No, take me back"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Yes, cancel"),
            ),
          ],
        );
      },
    );
    if (response is! bool) {
      return false;
    }
    return response;
  }

  Future<void> showAddEntryModal() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Phonebook Entry"),
          content: Column(
            children: [
              TextField(
                controller: nameController,
              ),
              TextField(
                controller: phoneNumberController,
              ),
              TextField(
                controller: addressController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                var response = await showCancelModal();
                if (!context.mounted) return;
                if (response) Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Add")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Generic Phonebook App"),
        actions: [buildAddEntryButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildEntryList()],
        ),
      ),
    );
  }

  Future<bool> showDeleteConfirmDialog(PhonebookEntry phonebookEntry) async {
    bool? response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete ${phonebookEntry.name}?"),
          content: Text(
            "Are you sure you want to delete the entry for ${phonebookEntry.name}? This action is irreversible.",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );

    if (response is! bool) {
      return false;
    }
    return response;
  }

  Widget buildEntryList() {
    var headingStyle = TextStyle(fontWeight: FontWeight.bold);
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            blurRadius: 20,
            // blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: DataTable(
          dataRowMaxHeight: double.infinity,
          columns: [
            DataColumn(label: Text("Name", style: headingStyle)),
            DataColumn(label: Text("Phone Number", style: headingStyle)),
            DataColumn(label: Text("Address", style: headingStyle)),
            DataColumn(label: Text("Actions", style: headingStyle)),
          ],
          rows: [
            ...phonebookEntries.map((PhonebookEntry entry) {
              return DataRow(
                cells: [
                  DataCell(Text(entry.name)),
                  DataCell(Text(entry.phoneNumber)),
                  DataCell(
                    Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: Text(
                        entry.address,
                        // softWrap: true,
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.edit),
                        IconButton(
                          onPressed: () {
                            showDeleteConfirmDialog(entry).then((bool result) {
                              print(result);
                              if (result) {
                                phonebookEntryRepository.deletePhonebookEntry(
                                  entry,
                                );
                                setState(() {
                                  phonebookEntries.remove(entry);
                                  getPhonebookEntries();
                                });
                              }
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildAddEntryButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          // minimumSize: const Size(150, 48),
          padding: EdgeInsets.all(15),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () async {
          await showAddEntryModal();
        },
        // 1. Define the icon here
        icon: const Icon(
          Icons.add,
          size: 25,
        ),
        // 2. Define the text here
        label: const Text("Add Entry"),

        // 3. OPTIONAL: If you want the icon on the right side!
        // (Note: This requires Flutter 3.16 or newer)
        iconAlignment: IconAlignment.end,
      ),
    );
  }

  List<Widget> buildPhonebookEntryList(List<PhonebookEntry> phonebookEntries) {
    return phonebookEntries
            .map(
              (entry) => Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.name),
                    Text(entry.phoneNumber),
                    Text(entry.address),
                    Row(
                      spacing: 10,
                      children: [
                        Icon(Icons.edit),
                        Icon(Icons.delete),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList()
        as List<Widget>;
  }

  Future<List<PhonebookEntry>> getPhonebookEntries() async {
    var entries = await phonebookEntryRepository.getAllPhonebookEntries();
    return entries;
  }
}
