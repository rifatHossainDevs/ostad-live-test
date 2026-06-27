import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Form(
        key: _formKey,
        child: Column(
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
              keyboardType: TextInputType.text,
              controller: _rollTEController,
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
              keyboardType: TextInputType.text,
              controller: _departmentTEController,
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
    );
  }

  void _onTapAddStudent() {}
}
