import 'package:flutter/material.dart';
import 'package:generic_phonebook_frontend/models/phonebook_entry_draft.dart';

class AddEntryModal extends StatefulWidget {
  final PhonebookEntryDraft? phonebookEntryData;

  const AddEntryModal({super.key, this.phonebookEntryData});

  static Future<PhonebookEntryDraft?> showModal(BuildContext context) {
    return showDialog<PhonebookEntryDraft>(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
  }

  @override
  State<AddEntryModal> createState() => _AddEntryModalState();
}

class _AddEntryModalState extends State<AddEntryModal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
