class Student {
  String name;
  String roll;
  String department;

  Student({required this.name, required this.roll, required this.department});

  factory Student.fromJson(String docId, Map<String, dynamic> jsonData) {
    return Student(
      name: jsonData['name'],
      roll: jsonData['roll'],
      department: jsonData['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "roll": roll, "department": department};
  }
}
