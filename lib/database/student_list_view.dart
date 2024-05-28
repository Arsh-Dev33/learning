import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:learning/database/student_controller.dart';

class StudentListView extends StatelessWidget {
  StudentController studentController = Get.put(StudentController());
  StudentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(child: GetBuilder<StudentController>(builder: (controller) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.student_controller,
                    decoration: InputDecoration(hintText: "Student Name"),
                  ),
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          controller.addStudent();
                        },
                        child: Text("Submit")))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.studentList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${controller.studentList[index].name}",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: InkWell(
                        onTap: (){
                          controller.deleteStudent(int.parse("${controller.studentList[index].id}"));
                        },
                        child: Icon(Icons.delete)),
                    );
                  }),
            ),
          ],
        );
      })),
    );
  }
}
