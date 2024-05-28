import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:learning/database/database_helper.dart';
import 'package:learning/student_model.dart';
import 'package:sqflite/sqflite.dart';

class StudentController extends GetxController {
  List<Student> studentList = [];
  late DataBaseHelper dataBaseHelper;
  late Database database;
  late TextEditingController student_controller;

  @override
  void onInit() {
    student_controller = TextEditingController();
    dataBaseHelper = DataBaseHelper();
    getStudentList();
    super.onInit();
  }

  void getStudentList() async {
    try {
      database = await dataBaseHelper.db;
      studentList = await dataBaseHelper.getAllStudent();
      update();
    } catch (e) {
      e.printError();
    }
  }

  void addStudent() async {
    try {
      var random = Random();
      int randomNumber = 100 + random.nextInt(999);
      Student student = Student(randomNumber, student_controller.text);
      Student stud = await dataBaseHelper.addStudent(student);
      dev.log("Added id is ${stud.name}");
      student_controller.clear();
      getStudentList();
      update();
    } catch (e) {
      e.printError();
    }
  }

   void deleteStudent(int id) async {
    try {
    
      int stud = await dataBaseHelper.deleteStudent(id);
      dev.log("Added id is $stud");
      student_controller.clear();
      getStudentList();
      update();
    } catch (e) {
      e.printError();
    }
  }


}
