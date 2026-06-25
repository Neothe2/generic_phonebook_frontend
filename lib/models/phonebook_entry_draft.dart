class PhonebookEntryDraft {
  String name;
  String phoneNumber;
  String address;

  PhonebookEntryDraft({
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  factory PhonebookEntryDraft.fromJson(Map<String, dynamic> json) {
    return PhonebookEntryDraft(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'adress': address,
      'phoneNumber': phoneNumber,
    };
  }
}
