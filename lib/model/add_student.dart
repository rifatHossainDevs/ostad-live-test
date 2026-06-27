import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ostad_live_test/model/student.dart';

import '../show_snackbar_message.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _rollTEController = TextEditingController();
  final TextEditingController _departmentTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? selectedIsRunning;
  bool isAddedInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Student"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _nameTEController,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Must enter name";
                  }
                  return null;
                },
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                controller: _rollTEController,
                decoration: InputDecoration(
                  hintText: "Enter roll",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Must enter roll";
                  }
                  return null;
                },
              ),

              TextFormField(
                keyboardType: TextInputType.text,
                controller: _departmentTEController,
                decoration: InputDecoration(
                  hintText: "Enter department",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Must enter department";
                  }
                  return null;
                },
              ),

              Visibility(
                visible: isAddedInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _onTapAddStudent,
                  child: Text(
                    "Save Student",
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapAddStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isAddedInProgress = true;
    });

    String name = _nameTEController.text.trim();
    int? roll = int.tryParse(_rollTEController.text.trim()) ?? 0;
    String department = _departmentTEController.text.trim();

    Student student = Student(name: name, roll: roll, department: department);
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .add(student.toJson());

      showSnackBarMessage(context, "Student added Successful");
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      showSnackBarMessage(context, e.message ?? "Something Went wrong");
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isAddedInProgress = false;
      });
    }
  }
}
