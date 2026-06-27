import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ostad_live_test/model/add_student.dart';
import 'package:ostad_live_test/model/student.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("All Students"),
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('student').snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == .waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          }

          List<Student> studentList = [];

          for (DocumentSnapshot doc in asyncSnapshot.data!.docs) {
            studentList.add(
              Student.fromJson(doc.id, doc.data() as Map<String, dynamic>),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: studentList.length,
                    itemBuilder: (context, index) {
                      var student = studentList[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            "Student Name: ${student.name}",
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Roll: ${student.roll}"),
                              SizedBox(height: 6),
                              Text("Department: ${student.department}"),
                            ],
                          ),
                          leading: Text("1"),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 8),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onTapFloatingButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapFloatingButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStudent()),
    );
  }
}
